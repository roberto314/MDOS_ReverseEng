# Ths file is part of: ditool.py - The Disk Image Tool
# 2026, R. Offner
# Version: 2.0
#
# Version History:
# 2.0: rewrite with dictionaries
# 1: first Version with Lists

import os

class class_MDOS(object):

    def __init__(self, parent, fspec, verbose):
        #self.PARENT = parent
        self.fspec = fspec
        self.verbose = verbose
        self.parent = parent
        if self.verbose != 0:
            print(f'Imageformat:')
            print(f'Tracks: {fspec["Tracks"]}')
            print(f'Sides: {fspec["Sides"]}')
            print(f'Sectors: {fspec["Sectors"]}')
            print(f'Bytes / Sector: {fspec["bps"]}')
            print(f'Directory starts at: 0x{fspec["Dirstart"]:04X}')
            print(f'Files starts at: 0x{fspec["Filestart"]:04X}')
            print(f'File Entry size: {fspec["Direntrysize"]}')
            print(f'Emptyvalue: {fspec["Emptyval"]:02X}')
    #----------------------------------
    def print_examples(self):
        print(f'')
        for k, v in self.fspec.items():
            print(f'{k}: 0x{v:04X}/{v}')
        print(f'')
    #----------------------------------
    def isascii(self,b):
        try:
            s = b.decode("ascii")
        except UnicodeDecodeError:
            print(f'Deleted File: xx{(b[2:8]).decode("ascii")}.{(b[8:10]).decode("ascii")}')
            return False
        else:
            # Check only first Character. If Space or NON-Ascii return false
            if ord(s[0]) > 0x20 and ord(s[0]) < 0x80:
                #print(f'Str.: {s} with char: {ord(s[0])} is ACII')
                return True
            else:
                #print(f'Str.: {s} with char: {ord(s[0])} is not ACII')
                return False
            #print(f'Str.: {s} is ACII')
            #return len(s) == len(s.encode("ascii"))
    #----------------------------------
    def conv16 (self, data, startoff):
        number = data[startoff]*256
        number += data[startoff+1]
        return number    
    #----------------------------------
    def chs_to_offset(self, c, h, s):
        offset = (self.fspec["Sectors"] * self.fspec["bps"] * c) + self.fspec["bps"] * s
        return offset
    #----------------------------------
    def offset_to_chs(self, off):
        totalsec = int(off / self.fspec["bps"])
        track = (totalsec / self.fspec["Sectors"]) # How many Tracks are these
        s = (totalsec % self.fspec["Sectors"])  # How many Sectors are rest
        c = int(track)
        h = 0
        if self.verbose > 0:
            print(f'off: {off:04X} c: {c} s: {s} totalsec: {totalsec} Track: {track}')
        return c, h, s
    #----------------------------------
    def create_image(self):
        img = bytearray(self.fspec["Emptyval"] for _ in range(self.fspec["Imagesize"])) # make empty imagefile with correct size
        return img
    #----------------------------------
    # parses the directory block
    def get_dir(self, imgfile):
        entries = [] # List of all Entries (plus header)
        offset = self.fspec["Dirstart"]
        header = []                   # Build the Header
        header.append("Name        ")
        header.append("SFX")
        header.append("Attrib")
        header.append("Type")
        header.append("WDSCN")
        header.append("PSN")
        header.append("Pos")
        header.append("PSec")
        header.append("RIBAdr")
        header.append("BytLS")
        header.append("Secs")
        header.append("Start")
        header.append("Exec")
        header.append("SDW0")
        header.append("TERM")
        header.append("DskStrt")
        header.append("Cclust")
        header.append("EOFSec")
        header.append("FSize")
        header.append("EndDisk")
        entries.append(header)
        while (offset < self.fspec["Filestart"]):
            entry = {}   # Dictionary of one Directory Entry
            if self.isascii(imgfile[offset:(offset+10)]): # Check if we have a "real" directory entry, 
                name = (imgfile[offset:(offset+8)]).decode("ascii")
                if "MDOS" in name: # Print System files in Green
                    entry["Name"]        = ["strg", name]
                else:
                    entry["Name"]        = ["strw", name]
                entry["Suffix"]      = ["strw", (imgfile[(offset+8):(offset+10)]).decode("ascii")]
                #--------------------------------------------------------------------------------
                attrib = imgfile[(offset+12)] # save Attribute for later
                entry["Attribute"]   = ["hx8", (attrib)]
                fileformat = (attrib & 0x07)
                if (fileformat == 0):
                    fileformatTXT = 'User'
                elif(fileformat == 2):
                    fileformatTXT = 'MEM'
                elif(fileformat == 3):
                    fileformatTXT = 'BIN'
                elif(fileformat == 5):
                    fileformatTXT = 'ASCI'
                elif(fileformat == 7):
                    fileformatTXT = 'ACB'
                entry["Filetype"]    = ["strw",  fileformatTXT]

                if (attrib & 0x80):
                    ABIT = 'W'
                else:
                    ABIT = '-'
                if (attrib & 0x40):
                    ABIT += 'D'
                else:
                    ABIT += '-'
                if (attrib & 0x20):
                    ABIT += 'S'
                else:
                    ABIT += '-'
                if (attrib & 0x10):
                    ABIT += 'C'
                else:
                    ABIT += '-'
                if (attrib & 0x08):
                    ABIT += 'N'
                else:
                    ABIT += '-'
                entry["Attribute Bit"]    = ["strw",  ABIT]

                #--------------------------------------------------------------------------------
                entry["StartPSN"]    = ["hx16", self.conv16(imgfile, (offset+10))]
                
                temp = int((offset-self.fspec["Dirstart"])/self.fspec["Direntrysize"]) # DEN (Dir. Entry Nr.)
                pos = temp & 0x07          # DEN Position 
                psec = (temp >> 3) & 0x1F  # DEN Physical Sector
                entry["DEN Position"] = ["hx8", (pos)]   
                entry["DEN PhSector"] = ["hx8", (psec)]  
                
                FRIB = entry["StartPSN"][1]*128 # Get Start of File RIB
            #    entry["File RIB: "]  = ["arr8x", imgfile[FRIB:FRIB+128]] # Dump the RIB as Array
                entry["File RIB Addr.: "]  = ["hx16", FRIB]               # Show only RIB Start
                # Stuff in File RIB (Retrieval Information Block)
                # the number of bytes to load from the last sector
                byteLS = imgfile[(FRIB+0x75)]
                if byteLS == 0:
                    entry["BytLS"]       = ["strw",  '--']
                else:
                    entry["BytLS"]       = ["hx8",  byteLS]
                # number of sectors to load
                sec2load = self.conv16(imgfile, (FRIB+0x76))
                if sec2load == 0:
                    entry["Secs"]        = ["strw",  '----']
                else:
                    entry["Secs"]        = ["hx16", sec2load]
                # the starting load address
                startAddr = self.conv16(imgfile, (FRIB+0x78))
                if startAddr == 0:
                    entry["StartAdr"]    = ["strw",  '----']
                else:
                    entry["StartAdr"]    = ["hx16", startAddr]
                # the starting execution address
                exexAddr = self.conv16(imgfile, (FRIB+0x7A))
                if exexAddr == 0:
                    entry["ExecAdr"]     = ["strw",  '----']
                else:
                    entry["ExecAdr"]     = ["hx16", exexAddr]
                # Get all the valid SDWs
                SDW = []
                TERM = 0
                i = 0
                for o in range(0,0x74,2):
                    sdw = self.conv16(imgfile, (FRIB+o))
                    if sdw & 0x8000: # Terminator
                        TERM = sdw
                    else:            # regular SDWs
                        SDW.append(sdw)
                    i += 1

                entry["SDW0"]          = ["hx16", SDW[0]]
                entry["TERM"]          = ["hx16", TERM]
                startclust = SDW[0] & 0x1FF # only the first 9 Bit
                contclust = ((SDW[0] & 0x7C00)>>10)+1  # Bits 10-14 are Number of contin. clusters - 1
                logsecEOF = TERM & 0x7FFF # lower 15 Bits only
                
                # Cluster * 4 = Sectors*0x80 = Bytes, Add size of RIB 
                diskstart = (startclust*4)*0x80+0x80
                entry["StartonDisk"]   = ["hx16",  diskstart]
                entry["ContinClustr"]  = ["hx16",  contclust]
                entry["EOFSec"]        = ["hx16",  logsecEOF]
                if byteLS == 0 or startAddr == 0:    # ASCII Files
                    FSIZ = (logsecEOF  + 2 ) * 128
                else:                                # Binary Files
                    FSIZ = (sec2load-1)*128 + byteLS # looks good!
                
                ENDDSK = FSIZ + diskstart - 1     # End on Disk
                entry["Filesize"]       = ["hx16",  FSIZ]
                entry["EndDisk"]        = ["hx16",  ENDDSK]

                entries.append(entry)                 # append to list of entries
            else:
                pass
            offset += self.fspec["Direntrysize"]  # cue to next entry
        
        # Print statistics at the end of listing
        stats = {}
        stats["Diskette ID: "]        = ["strw", (imgfile[0:8]).decode("ascii")]
        stats["Version #: "]          = ["strw", (imgfile[8:10]).decode("ascii")]
        stats["Revision #: "]         = ["strw", (imgfile[10:12]).decode("ascii")]
        stats["Gen. Date: "]          = ["strw", (imgfile[12:18]).decode("ascii")]
        stats["User Name: "]          = ["strw", (imgfile[18:38]).decode("ascii")]
       #stats["Overlay RIB Addr.: "]  = ["arr8x", imgfile[38:58]]                  # dump the table
       #stats["Cluster Alloc. Tab.: "]= ["arr8x", imgfile[128:256]]                # dump the table
       #stats["Lockout Alloc. Tab.: "]= ["arr8x", imgfile[256:384]]                # dump the table
        bbstart = 0x17*128
        #stats["Bootblock @ PSN17, B80: "]= ["arr8x", imgfile[bbstart:bbstart+128]] # dump the table

        return entries, stats
    #----------------------------------
    def get_file(self, imgfile, entry):
        data = bytearray()
        start = entry["StartonDisk"][1]
        end = entry["EndDisk"][1]+1
        data = imgfile[start:end]
        return data
    #----------------------------------
    # Prints out Directory
    def print_dir(self, entries, stats):
        print(f'Showing Directory. (all values in hex!)') # Directory is easy, it starts @ 0x1400 until a 0xFF is found @ first position
        for idx,e in enumerate(entries): # cycle through entries
            if idx == 0:                 # first entry is the header
                for h in e:
                   print(f'{h}', end="\t") # Print keys and TAB
                print(f'')
            else:
                for k, v in e.items():
                    if 'hx8' == v[0]:                   # Print 8-Bit HEX
                        print(f'{v[1]:02X}', end="\t")
                    elif 'arr8x' == v[0]:
                        self.parent.dump_data(v[1],16)
                    elif 'hx16' == v[0]:                  # Print 16-Bit HEX
                        print(f'{v[1]:04X}', end="\t")
                    elif 'strw' == v[0]:                  # Print String in White
                        print(f'{v[1]}', end="\t")
                    elif 'strg' == v[0]:                  # Print String in Green
                        print(f'{self.parent.GRN}',end = '')
                        print(f'{v[1]}', end="\t")
                        print(f'{self.parent.END}',end = '')
                print(f'')
        
        for k, v in stats.items():
            print(f'{k}', end="\t") # Print keys and TAB
            if 'hx8' == v[0]:
                print(f'{v[1]:02X}')
            elif 'arr8x' == v[0]:
                self.parent.dump_data(v[1],16)
            elif 'hx16' == v[0]:
                print(f'{v[1]:04X}')
            elif 'strw' == v[0]:
                print(f'{v[1]}')
            elif 'strg' == v[0]:
                print(f'{self.parent.GRN}',end = '')
                print(f'{v[1]}',end = '')
                print(f'{self.parent.END}')
    #----------------------------------
    # adds the last entry which indicates no more files and free space on floppy
    def add_last_enty(self, img, pos, off):
        totalsec = (self.fspec["Imagesize"] - off) / self.fspec["bps"]
        nft,h,nfs = self.offset_to_chs(off)
        track = int(off / self.fspec["bps"]) # How many Tracks are these
        print(f'Next Free Trk.: {nft}, Next Free Sec.: {nfs}, Tracks used: {track} TotalFree: {totalsec}, 0x{int(totalsec):02X}')       
        ap = pos * self.fspec["Direntrysize"] + offset # actual Position
        clrpos = pos * self.fspec["Direntrysize"] + offset
        zeros = bytearray(0 for _ in range(self.fspec["Filestart"] - clrpos)) # Clear out 
        if self.verbose > 0:
            print(f'Clear: {len(zeros)}, 0x{len(zeros):04X}, Clrpos: 0x{clrpos:04X}')
        img[ap:ap+len(zeros)] = zeros
        img[ap] = 0xFF # Signature for no more entries
        img[ap+16] = nft # Next free Track
        img[ap+17] = nfs # Next free Sector
        free = int(totalsec)
        if self.verbose > 0:
            print(f'Total Free Trk.: {free}, 0x{free:04X}')
        img[ap+18:ap+20] = (free).to_bytes(2, 'big')
    #----------------------------------
    # adds a file to the directory including all the necessary data
    def add_dir_enty(self, img, pos, name, passw, sttrk, stsec, siz, typ, saddr, eaddr, pc, hilin, sp0, sp1, sp2):
        ap = pos * self.fspec["Direntrysize"] + offset # actual Position
        text = bytearray(0x20 for _ in range(16)) # Clear out name and password
        namtxt = (name.encode("ascii")).strip()
        passtxt = (passw.encode("ascii")).strip()
        text[0:len(namtxt)] = namtxt
        text[8:8+len(passtxt)] = passtxt
        img[ap:ap+16] = text
        img[ap+16] = int(sttrk)
        img[ap+17] = int(stsec)
        img[ap+18:ap+20] = siz.to_bytes(2, 'big')
        img[ap+20] = typ
        img[ap+21:ap+23] = saddr.to_bytes(2, 'big')
        img[ap+23:ap+25] = eaddr.to_bytes(2, 'big')
        img[ap+25:ap+27] = pc.to_bytes(2, 'big')
        img[ap+27:ap+29] = hilin.to_bytes(2, 'big')
        img[ap+29] = sp0
        img[ap+30] = sp1
        img[ap+31] = sp2
    #----------------------------------
    def add_file(self, img, fdata, sttrk, stsec, siz):
        off = self.chs_to_offset(sttrk, 0, stsec)
        for idx in range(siz): # go through the sectors
            cstart = idx * self.fspec["bps"]
            start = off + cstart
            img[start:start+self.fspec["bps"]] = fdata[cstart:cstart+self.fspec["bps"]]
    #----------------------------------
    def add_files(self, fdir, entries, stats, img, action):
        #if action == 'CREATEBOOT':
        #    print(f'Creating Boot Image is no really necessary on FDOS.')
        #    print(f'Just put a file named $DOS in the FILES Directory and it will be the bootfile.')
        self.print_dir(entries, stats)
        return img
        
        statslines = []
        statslines = (statsfile.split('\n'))[1:] # one line per track and start after header
        #----------------------------------
        # Here we add the filenames to the Directory
        # We need the stats file for Filetype, Startaddress, Endaddress, Program Counter,
        # Hiline (Basic) and three 'spares'.
        # Also the size can come from the stats file or from the actual filesize
        totalsz = 0
        c = 0
        h = 0
        s = 0
        for idx,line in enumerate(statslines):
            e = line.split(';')
            #print(f'Stats: {e} {idx}')
            if idx >= numfiles: # don't take the last line
                break
            name = e[0].strip()
            fn = name
            if ('/' in name):
                fn = name.replace('/', '_')
                #print(f'Looking for different name: {name}')
            fdata = self.parent.read_file((fdir+fn), 'binary') # Get the filedata
            #-------------------------------------------------------------------------
            # Get the filesize from the actual file and pad it to the next sector (alternative)
            #-------------------------------------------------------------------------
            #tempsiz = len(fdata)/self.fspec["bps"]  # Size (in sectors) from actual filesize
            #temprest = self.fspec["bps"] - (len(fdata)%self.fspec["bps"])  # Rest in sectors
            #zeros = bytearray(0 for _ in range(temprest))
            #fdata += zeros
            #nsiz = int(len(fdata)/self.fspec["bps"])
            #print(f'Tempsiz: {tempsiz}, Temprest: {temprest}, new: {nsiz}')
            #siz = nsiz # Use actual filesize padded to next sectorboundry
            #-------------------------------------------------------------------------
            siz = int(e[4], 0) # Use size from stats file
            c,h,s = self.offset_to_chs(totalsz)
            totalsz += siz * self.fspec["bps"]
            passw = e[1]
            if name == '$DOS':
                sttrk = int(e[2], 0)
                stsec = int(e[3], 0)
                totalsz += self.fspec["Sectors"] * self.fspec["bps"] # one track extra for directory
            else:
                sttrk = c
                stsec = s
                
            if 'Blank' in e[5]:
                typ = 0
            elif 'System' in e[5]:
                typ = 0x11
            elif 'Object' in e[5]:
                typ = 0x22
            elif 'Basic' in e[5]:
                typ = 0x55
            elif 'Cores' in e[5]:
                typ = 0x77
            elif 'B.Data' in e[5]:
                typ = 0x99
            saddr = int(e[6], 0)
            eaddr = int(e[7], 0)
            pc = int(e[8], 0)
            hilin = int(e[9], 0)
            sp0 = int(e[10], 0)
            sp1 = int(e[11], 0)
            sp2 = int(e[12], 0)
            print(f'Adding {name:8} to: {sttrk=:2} {stsec=:2} {siz=:2} NxtOff: {totalsz:>05X} Size of File: {len(fdata)/self.fspec["bps"]:>5.1f}')
            self.add_dir_enty(img, idx, name, passw, sttrk, stsec, siz, typ, saddr, eaddr, pc, hilin, sp0, sp1, sp2)
            #----------------------------------
            # Now add the actual files to the Image
            self.add_file(img, fdata, sttrk, stsec, siz)
        #c,h,s = self.offset_to_chs(totalsz)
        self.add_last_enty(img, idx, totalsz)
        return img
