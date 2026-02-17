# Ths file is part of: ditool.py - The Disk Image Tool
# 2026, R. Offner
# Version: 2.0
#
# Version History:
# 2.0: rewrite with dictionaries
#  Features of v2.0:
#  - Export data as json so it is user-readeable and possible to edit,
#  - In the json file is also the original Name and Directoryposition so reassembled images are exactly the same
#  - Possibility to create a new entries.json file with all files from a directory
#  - Header data is in the entry dictionary items (like a shortened text)
#  - alternating Disk paramterer can be entered at the commandline
#  - .imd and .hfe files as input supported (need hxcfe in the directory to convert them to .img)
#
# 1: first Version with Lists

import os, math
#from bitstring import BitStream, BitArray

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
            try:
                print(f'{k}: 0x{v:04X}/{v}')
            except:
                print(f'{k}: {v}')
        print(f'')
        print(f'Needed for all Files: (must be in entries.json!)')
        print(f'Name')
        print(f'Suffix')
        print(f'Attribute')
        print(f'Needed for Binary Files:')
        print(f'StartAdr')
        print(f'ExecAdr')
        print(f'Optional for the Image: (may be supplied via commandline with the ''-format'' option)')
        print(f'DiskID')
        print(f'Version')
        print(f'Revision')
        print(f'Date')
        print(f'UserName')
        print(f'Possible Valies to override:')
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
    def get_number(self, img, pos, siz):
        number = 0
        mul = pow(256,siz-1)
        for n in range(pos, pos+siz):
            number += img[n] * mul
            mul /= 256
            #print(f'IDX: {n:02X}, MUL: {mul}, SIZ: {siz} Number: {number} IMG: {img[n]:02X}')
        return int(number)
    #----------------------------------
    def write_number2image(self, v_in, img, off, size):
        if type(v_in) == str:
            number = 0
        else:
            number = v_in
        val = number.to_bytes(size, 'big')
        img[off:off+size] = val
        return img
    #----------------------------------
    def write_text2image(self, text, img, off, size):
        t = text.encode("ASCII")
        e = bytearray(0x20 for _ in range(size-len(t)))
        #if self.verbose > 0:
        #    print(f'Write {text} w. len {len(t)} to pos {off} Restlen: {len(e)}')
        img[off:off+size] = t+e
        return img
    #----------------------------------
    def create_ClusterAllocationTable(self, img, start):
        pos = start
        end = start + self.fspec["bps"]
        size = int(len(img) / (self.fspec["bps"]*4)) # Clusters per disk (4 sector / cluster)
        cbytes = int(size / 8)                       # one bit per cluster
        rest = size % 8                              # one bit per cluster
        if self.verbose > 0:
            print(f'Write 00 for {size} cluster. {cbytes:02X} bytes + {rest} bits rest')
        for i in range(cbytes):
            self.write_number2image(0x00, img, pos, 1) # Free cluters
            pos += 1

        shiftval = 0x007F                         # one cluster free (Bit 7)
        lastval = 0xFF                            # all occupied
        for sh in range(rest):                    # write bits for free cluster
            lastval = lastval & (shiftval & 0xFF) # shift zero from the top for every free cluster
            shiftval = shiftval >> 1              # one more cluster free ?
        self.write_number2image(lastval, img, pos, 1) # write last byte
        if self.verbose > 0:
            print(f'Write shiftval {shiftval:04X} lastval {lastval:02X} to 0x{pos:02X}')
        pos += 1

        if self.verbose > 0:
            print(f'Write FF for 0x{(end - pos):02X} rest of sector')

        for i in range(end - pos):
            self.write_number2image(0xFF, img, pos, 1) # not allocated cluters
            pos += 1
        return img
    #----------------------------------
    def create_image(self, stats, variant):
        # create empty image
        if self.verbose > 0:
            print(f'Make image w. {self.fspec["Imagesize"]} bytes')
        img = bytearray(self.fspec["Emptyval"] for _ in range(self.fspec["Imagesize"])) # make empty imagefile with correct size
        if variant == "virgin": # Output a 'formatted' image (all E5)
            return img
        end = 0x18*128 # 0x18 Sectors w. 128 Byte
        if self.verbose > 0:
            print(f'Clear out {end:04X} bytes')
        RIB = bytearray(0 for _ in range(end)) # Clear out DiskID, MDOS Overlay RIB, CAT, LCAT, Directory, Bootblock and MDOS RIB
        img[0:end] = RIB

        # create Diskette ID Block
        try:
            diskid = self.fspec["DiskID"]
        except:
            if stats != {}:
                diskid = stats["Diskette ID: "][1]
            else:
                diskid = ' '
        self.write_text2image(diskid, img, 0, 8)         # Diskette ID

        try:
            version = self.fspec["Version"]
        except:
            if stats != {}:
                version = stats["Version #: "][1]
            else:
                version = ' '
        self.write_text2image(version, img, 8, 2)        # Version #

        try:
            revision = self.fspec["Revision"]
        except:
            if stats != {}:
                revision = stats["Revision #: "] [1]
            else:
                revision = ' '
        self.write_text2image(revision, img, 0x0A, 2)    # Revision #

        try:
            generationdate = self.fspec["Date"]
        except:
            if stats != {}:
                generationdate = stats["Gen. Date: "] [1]
            else:
                generationdate = ''
        self.write_text2image(generationdate, img, 0x0C, 6) # Gen. Date

        try:
            username = self.fspec["UserName"]
        except:
            if stats != {}:
                username = stats["User Name: "][1]
            else:
                username = ' '
        self.write_text2image(username, img, 0x12, 0x14) # User Name

        #----------------------
        # create Cluster Allocation Table 80-FF
        self.create_ClusterAllocationTable(img, 0x80)
        for p in range(0x80, 0x85): # Reserve space for System Files
            img[p] = 0xFF
        img[0x85] = 0xF8 # also for system files
        #----------------------
        # create Lockout Cluster Allocation Table
        self.create_ClusterAllocationTable(img, 0x100)
        img[0x100] = 0xFC # the first 6 clusters (=24/0x18 sectors) are always occupied!
        # create Directory Region
        # nothing to do here
        return img
    #----------------------------------
    # parses the directory block
    def get_dir(self, imgfile):
        entries = [] # List of all Entries (plus header)
        offset = self.fspec["Dirstart"]
        dirpos = 0
        # 
        # One entry is a dictionary item. The key is the name and should be descriptive of the function,
        # the value is a list containing:
        # .) a string how the value is listed (hx8 for HEX 8-bit, strg for String in Green color,...)
        # .) the actual value of the key
        # .) NEW: the shortname displayed in the header (optional)
        #
        while (offset < self.fspec["Filestart"]):
            entry = {}   # Dictionary of one Directory Entry
            if self.isascii(imgfile[offset:(offset+10)]): # Check if we have a "real" directory entry, 
                name = (imgfile[offset:(offset+8)]).decode("ascii")
                if "MDOS" in name: # Print System files in Green
                    entry["Name"]        = ["strg", name, "Name        "]
                else:
                    entry["Name"]        = ["strw", name, "Name        "]
                entry["Suffix"]      = ["strw", (imgfile[(offset+8):(offset+10)]).decode("ascii"), "SFX"]
                #--------------------------------------------------------------------------------
                attrib = imgfile[(offset+12)] # save Attribute for later
                entry["Attribute"]   = ["hx8", (attrib), "Atrib"]
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
                entry["Filetype"]    = ["strw",  fileformatTXT, "FTyp"]

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
                entry["Attribute Bit"]    = ["strw",  ABIT, "WDSCN"]

                #--------------------------------------------------------------------------------
                psn = self.conv16(imgfile, (offset+10))
                entry["StartPSN"]    = ["hx16", psn, "PSN"]
                
                FRIB = entry["StartPSN"][1]*128 # Get Start of File RIB
                # Get all the valid SDWs
                SDW = []
                ContCluster = []
                StartingCluster = []
                TERM = 0
                contclust = 0
                #logsecEOF = 0
                i = 0
                for o in range(0,0x74,2):
                    sdw = self.conv16(imgfile, (FRIB+o))
                    if sdw & 0x8000: # Terminator
                        logsecEOF = sdw & 0x7FFF # lower 15 Bits only
                        break
                    else:            # regular SDWs
                        SDW.append(sdw)
                        StartingCluster.append(sdw&0x3FF)  # only the first 10 Bit
                        ContCluster.append(((sdw & 0x7C00)>>10)+1) # Bits 10-14 are Number of contin. clusters - 1
                    i += 1
                # Cluster * 4 = Sectors*0x80 = Bytes, Add size of RIB 
                diskstart = (StartingCluster[0]*4)*0x80+0x80
                for s in range(len(SDW)):
                    contclust += ContCluster[s]

                PhysicalSize = contclust * 4 # convert to clusters, round up, back to sectors
                # the number of bytes to load from the last sector
                byteLS = imgfile[(FRIB+0x75)]
                # Sectors to load
                sec2load = self.conv16(imgfile, (FRIB+0x76))
                # the starting load address
                startAddr = self.conv16(imgfile, (FRIB+0x78))
                # the starting execution address
                exexAddr = self.conv16(imgfile, (FRIB+0x7A))

                #if byteLS == 0 or startAddr == 0:    # ASCII Files
                if attrib & 4:    # ASCII Files
                    FSIZ = (logsecEOF +1) * 128 # Since Rest == 0 we need an additional sector! (see Chap. 24.2.1)
                else:                                # Binary Files
                    FSIZ = (sec2load-1)*128 + byteLS # looks good!
                ENDDSK = FSIZ + diskstart - 1     # End on Disk
                entry["PSecs"]        = ["hx16", PhysicalSize]

                #temp = int((offset-self.fspec["Dirstart"])/self.fspec["Direntrysize"]) # DEN (Dir. Entry Nr.)
                pos = (offset>>4) & 0x07          # DEN Position 
                psec = int(offset/self.fspec["bps"])<<3 # DEN Physical Sector
                #psec = (offset)>>4 # DEN Physical Sector
                #psec = (temp >> 3) & 0x1F  # DEN Physical Sector
                #entry["DEN Position"] = ["hx8", (pos), "POS"]   
                #entry["DEN PhSector"] = ["hx8", (psec), "PSec"]  
                entry["DEN"] = ["hx8", (psec+pos)]  
                entry["SDW"] = ["dec2", 0]
                entry["SecSt"] = ["hx16", psn]
                entry["SecSz"] = ["hx8", ContCluster[0]*4]
                
            #    entry["File RIB: "]  = ["arr8x", imgfile[FRIB:FRIB+128]] # Dump the RIB as Array
                #entry["File RIB Addr.: "]  = ["hx16", FRIB, "RIB@"]               # Show only RIB Start
                # Stuff in File RIB (Retrieval Information Block)
                if byteLS == 0:
                    entry["BytLS"]       = ["strw",  '--']
                else:
                    entry["BytLS"]       = ["hx8",  byteLS]
                if startAddr == 0:
                    entry["StartAdr"]    = ["strw",  '----', "Start"]
                else:
                    entry["StartAdr"]    = ["hx16", startAddr, "Start"]
                if exexAddr == 0:
                    entry["ExecAdr"]     = ["strw",  '----', "Exec"]
                else:
                    entry["ExecAdr"]     = ["hx16", exexAddr, "Exec"]

                #entry["SDW0"]          = ["hx16", SDW[0]]#                entry["SDW#"]          = ["hx16", len(SDW)]#                
                entry["StartonDisk"]   = ["hx16",  diskstart, "DSTRT"]
                entry["ContinClustr"]  = ["hx16",  contclust, "CClust"]
                entry["LSec"]        = ["hx16",  logsecEOF]
                
                
                #if sec2load == 0:
                #    #entry["Secs"]        = ["strw",  '----']
                #    entry["LSecs"]        = ["hx16", int(FSIZ/128)]
                #else:
                #    entry["LSecs"]        = ["hx16", sec2load]
                entry["Filesize"]       = ["hx16",  FSIZ, "FSize"]
                entry["EndDisk"]        = ["hx16",  ENDDSK, "DskEnd"]
                #entry["Directoryposition"] = ["dec2",  dirpos, "Dirpos"]
                entries.append(entry)                 # append to list of entries
                dirpos += 1
            else:
                pass # not a "real" Direntry - skip
            offset += self.fspec["Direntrysize"]  # cue to next entry
        
        # Get Bootsector into the files listing
        bbstart = 0x17*128
        entry = self.set_default_values()
        entry["Name"]          = ["strw", "BOOTSECTOR ", "Name        "]
        entry["Secs"]          = ["hx16", 1]
        entry["StartAdr"]      = ["hx16", 0x20, "Start"]
        entry["ExecAdr"]       = ["hx16", 0x20, "Exec"]
        entry["StartonDisk"]   = ["hx16",  bbstart, "DSTRT"]
        entry["EndDisk"]        = ["hx16",  bbstart+0x80-1, "DskEnd"]
        #entry["Directoryposition"] = ["dec2",  dirpos, "Dirpos"]
        entries.append(entry)                 # append to list of entries

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
    def print_body(self, e):
        # Prints out Directory entries only
        for k, v in e.items():
            if 'hx8' == v[0]:                   # Print 8-Bit HEX
                print(f'{v[1]:02X}', end="\t")
            elif 'arr8x' == v[0]:
                self.parent.dump_data(v[1],16)
            elif 'hx16' == v[0]:                  # Print 16-Bit HEX
                print(f'{v[1]:04X}', end="\t")
            elif 'dec5' == v[0]:                  # Print 5 places decimal
                print(f'{v[1]:05}', end="\t")
            elif 'dec2' == v[0]:                  # Print 2 places decimal
                print(f'{v[1]:02}', end="\t")
            elif 'strw' == v[0]:                  # Print String in White
                print(f'{v[1]}', end="\t")
            elif 'strg' == v[0]:                  # Print String in Green
                print(f'{self.parent.GRN}',end = '')
                print(f'{v[1]}', end="\t")
                print(f'{self.parent.END}',end = '')
        print(f'')
    #----------------------------------
    def print_header(self, e):
        # Prints out Directory header only
        for k, v in e.items():
            try:
                print(f'{v[2]}', end="\t") # Print short entry and TAB
            except:
                if v[0] != "not": # only print if it should actually be printed
                    print(f'{k}', end="\t") # Print key and TAB
        print(f'')        
    #----------------------------------
    def print_entry(self, idx, e):
        if idx == 0:                 # get the header from the first entry
            self.print_header(e)
            self.print_body(e)
        else:
            self.print_body(e)  
    #----------------------------------
    # Prints out Directory and stats
    def print_dir(self, entries, stats):
        print(f'Showing all entries in json. (all values in hex!)') # Directory is easy, it starts @ 0x1400 until a 0xFF is found @ first position
        for idx,e in enumerate(entries): # cycle through entries
            self.print_entry(idx, e)
        
        for k, v in stats.items(): # print stats
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
    def occupy_cat(self, img, pos, siz):
        startbyte = int(pos/8)+0x80            # first byte which is NOT 0xFF
        mask = pow(2,siz)-1 # we mask this value with the CAT value
        bytes_needed = math.ceil(siz/8) + 1 # we need to look at minimum two bytes, more if sizclu > 8
        startbit = (bytes_needed*8)-siz - int(pos%8)  # shift number (from bottom)
        mask = mask << startbit
        if self.verbose > 0:
            print(f'StartByte: {startbyte:02X} Shift: {startbit} needed: {bytes_needed} Mask: {mask:08b}/{mask:4X}')
        number = self.get_number(img, startbyte, bytes_needed)
        if self.verbose > 0:
            print(f'Got Number: before: {number:8X} after: {(number|mask):8X}')
        img = self.write_number2image(number|mask, img, startbyte, bytes_needed)
        return img
    #----------------------------------
    def find_free_space(self, siz, img):
        # returns the first free cluster
        bpos = -1
        # Cluster Allocation Table sits at 0x80 and one bit is one cluster (4 sectors)
        catstr = ''
        for i in range(0x80, 0x100): # read the whole CAT and convert it to a string of bits.
            catstr += f'{img[i]:08b}'
        filestr = (bytearray(0x30 for _ in range(siz)).decode("ASCII")) # make string with n times '0'
        bpos = catstr.find(filestr)          # actually look for n zeros in big string of clusters
        #print(f'Got free cluster @ POS: {bpos} filestr: {len(filestr)} bit {len(catstr)}')
        return bpos
    #----------------------------------
    def get_free_cluster(self, img):
        catstr = ''
        lcatstr = ''
        for i in range(0x80, 0x100): # read the whole CAT and convert it to a string of bits.
            catstr += f'{img[i]:08b}'
        for i in range(0x100, 0x180): # read the whole LCAT and convert it to a string of bits.
            lcatstr += f'{img[i]:08b}'
        frc = catstr.count('0')
        lc = lcatstr.count('0')
        print(f'Free Clusters: {frc}')
        if self.fspec["Sides"] == 1:
            totalclusters = 500
        else:
            totalclusters = 1001
        locked = totalclusters - lc - 6
        print(f'Lockout Clusters: {locked} (except 6 system clusters)')
    #----------------------------------
    def find_free_space_old(self, siz, img):
        pos = 0
        # Cluster Allocation Table sits at 0x80 and one bit is one cluster (4 sectors)
        bytes_needed = math.ceil(siz/8) + 1 # we need to look at minimum two bytes, more if sizclu > 8
        clusterstr = (bytearray(0x30 for _ in range(siz)).decode("ASCII")) # make string with n times '0'
        #print(f'Looking for space for {siz} clusters in {bytes_needed} bytes. STR: {clusterstr}')
        for i in range(0x80, 0xFF):
            #print(f'Looking at: {i:02X}, Num: {img[i]:02X}')
            if img[i] != 0xFF: # we could have space
                number = self.get_number(img, i, bytes_needed)
                #bitstr = format(number,'b') # format numbers in CAT as string so we can find zeros
                bitstr = f'{number:016b}' # format numbers in CAT as string so we can find zeros
                bpos = bitstr.find(clusterstr) # actually look for n zeros
                #print(f'Looking at: {i:02X}, Num: {number:08X}, bitstr: {bitstr} bpos: {bpos}')
                if bpos == -1: # not found means no more space
                    print(f'No more space at: {i:02X}')
                    return 0
                cpos = bpos + (i-0x80)*8 # cpos is at first free cluster
                pos = cpos               # next free cluster is at position....
                #print(f'Got nr.: {number:08X}, IDX: {i:02X} BPOS: {bpos} CPOS: {cpos}')
                return pos
        return pos
    #----------------------------------
    def as_rol(self, nr, carry):
        c = 0
        out = (nr << 1) | carry
        if out > 0xFF:
            c = 1
        return (out&0xFF),c
    #----------------------------------
    def as_ror(self, nr, carry):
        c = 0
        out = (nr >> 1) | carry << 7
        if nr & 1:
            c = 1
        return (out&0xFF),c
    #----------------------------------
    def mdos_hash(self, name, sfx):
        # Fill rest of characters with space
        nt = name.encode("ASCII")
        ns = bytearray(0x20 for _ in range(8-len(name)))
        st = sfx.encode("ASCII")
        ss = bytearray(0x20 for _ in range(2-len(sfx)))
        name_bytes = nt+ns+st+ss 
        A = 0
        B = 0
        carry = 0
        for i in range(10):
            temp = name_bytes[i] - 0x25
            if temp < 0:
                tmp1 = 0
            else:
                tmp1 = temp & 0xFF
            
            B = B + tmp1 + carry
            carry = 0
            #print(f'char {(name_bytes[i]):02X} {tmp1:02X} {B:02X}')
            if B>0xFF:
                carry = 1
                B = B&0xFF
            B, carry = self.as_rol(B, carry)

        B, carry = self.as_ror(B, carry)
        A = B
        #print(f'A now {A:02x}')
        for _ in range(4):
            #print(f'ror {A:08b}')
            A, carry = self.as_ror(A, carry)

        #print(f'A now2 {carry} {A:02x}')
        A += B
        #print(f'A now3 {carry} {A:02x}')
        B = A & 0xFF
        #print(f'B now {carry} {B:02x}')
        B &= 0x1F
        #print(f'B now2 {carry} {B:02x}')
        if B <= 0x13:
            return B
        B -= 0x14
        #print(f'B now3 {carry} B:{B:02x} A:{A:02X}')
        if B > 9:
            return B
        if A&1:
            carry = 1
        else:
            carry = 0
        B, carry = self.as_rol(B, carry)
        return B
    #----------------------------------
    def add_dir_entry(self, img, dirpos, filepos, entry):
        name = entry["Name"][1].strip()
        suffx = entry["Suffix"][1].strip()
        attrib = entry["Attribute"][1]
        for p in range(self.fspec["Dirstart"], self.fspec["Filestart"], self.fspec["Direntrysize"]):
            if ((p >= dirpos) and (img[p] == 0)): 
                #print(f'pos: {p:04X}')
                img = self.write_text2image(name, img, p, 8)
                img = self.write_text2image(suffx, img, p+8, 2)
                img = self.write_number2image(filepos, img, p+0x0a, 2)
                img = self.write_number2image(attrib, img, p+0x0c, 1)
                return img
        return img
    #----------------------------------
    # adds a file to the directory including all the necessary data
    def add_files_to_img(self, img, entry, fdata):
        name = entry["Name"][1].strip()
        suffx = entry["Suffix"][1].strip()
        sizsec = int(math.ceil(len(fdata)/128))
        sizclu = int(math.ceil((sizsec+1) / 4)) # size in clusters (filesize + RIB)
        fhash = self.mdos_hash(name, suffx) # HASH is from 0-20 (sectors)
        dirpos = (fhash + 3) * 128 # DIR starts at sector 3
        print(f'-------------------------------------------------------')
        print(f'HASH: {fhash:02} - {name:8}.{suffx} Pos: {dirpos:04X} Size in clusters: {sizclu:02X}, secs: {sizsec:02X}')
        cluster = 0
        psn = 0
        if name == "MDOS":
            print(f'{self.parent.GRN}Got System file: {name}{self.parent.END}')
            psn = 0x18
        elif name == "MDOSOV0":
            print(f'{self.parent.GRN}Got System file: {name}{self.parent.END}')
            psn = 0x5C
            self.write_number2image(psn, img, 0x26, 2)
        elif name == "MDOSOV1":
            print(f'{self.parent.GRN}Got System file: {name}{self.parent.END}')
            psn = 0x6C
            self.write_number2image(psn, img, 0x28, 2)
        elif name == "MDOSOV2":
            print(f'{self.parent.GRN}Got System file: {name}{self.parent.END}')
            psn = 0x7C
            self.write_number2image(psn, img, 0x2A, 2)
        elif name == "MDOSOV3":
            print(f'{self.parent.GRN}Got System file: {name}{self.parent.END}')
            psn = 0x84
            self.write_number2image(psn, img, 0x2C, 2)
        elif name == "MDOSOV4":
            print(f'{self.parent.GRN}Got System file: {name}{self.parent.END}')
            psn = 0x8C
            self.write_number2image(psn, img, 0x2E, 2)
        elif name == "MDOSOV5":
            print(f'{self.parent.GRN}Got System file: {name}{self.parent.END}')
            psn = 0x94
            self.write_number2image(psn, img, 0x30, 2)
        elif name == "MDOSOV6":
            print(f'{self.parent.GRN}Got System file: {name}{self.parent.END}')
            psn = 0x9C
            self.write_number2image(psn, img, 0x32, 2)
        elif name == "MDOSER":
            print(f'{self.parent.GRN}Got System file: {name}{self.parent.END}')
            psn = 0xA4
        else: # normal file, look for free space
            cluster = (self.find_free_space(sizclu, img)) # returns cluster or -1 if disk is full
        
        if cluster == -1:
            print(f'{self.parent.RED}No more Space in Image!{self.parent.END}')
            exit(1)
        if psn:
            filepos = psn * 128
            cluster = int(psn / 4)
        else:
            filepos = cluster * 4 * 128
            psn = cluster * 4

        if psn > 0x9C: # non-systemfile
            print(f'Found free cluster @: {cluster:02X}/{cluster} psn: {psn:02X}, {filepos:06X}')
            img = self.occupy_cat(img, int(psn/4), sizclu)

        img = self.add_dir_entry(img, dirpos, psn, entry)
        img = self.add_rib(img, psn*128, entry, len(fdata))
        img = self.add_file(img, (psn+1)*128, fdata)

        return img
    #----------------------------------
    def get_val(self, entry, key):
        #k,v = entry.items()
        v = entry.get(key) # values
        #print(f'Values: {v}')
        fmt = v[0]
        try:
            txt = v[2]
        except:
            txt = key
        inp = input(f'Enter {txt}: ')
        if 'str' in fmt:
            retval = inp if inp != '#' else v[1]
        elif fmt == 'hx8':
            retval = int(inp,0) if inp != '#' else v[1]
        elif fmt == 'hx16':
            retval = int(inp,0) if inp != '#' else v[1]

        return retval
    #----------------------------------
    def set_default_values(self):
        entry = {}
        entry["Name"]          = ["strw", "        ", "Name        "]
        entry["Suffix"]        = ["strw", "  ", "SFX"]
        entry["Attribute"]     = ["hx8", 0x72, "Atrib"]
        #entry["Filetype"]      = ["strw",  "MEM", "FTyp"]
        #entry["Attribute Bit"] = ["strw",  "-----", "WDSCN"]
        #entry["StartPSN"]      = ["hx16", 0, "PSN"]
        #entry["DEN"]           = ["hx8", 0]   
        #entry["DEN Position"]  = ["hx8", 0, "POS"]   
        #entry["DEN PhSector"]  = ["hx8", 0, "PSec"]  
        #entry["File RIB Addr.: "]  = ["hx16", 0, "RIB@"]
        #entry["BytLS"]         = ["hx8",  0]
        #entry["Secs"]          = ["hx16", 0]
        entry["StartAdr"]      = ["hx16", 0, "Start"]
        entry["ExecAdr"]       = ["hx16", 0, "Exec"]
        #entry["SDW0"]          = ["hx16", 0]
        #entry["TERM"]          = ["hx16", 0]
        #entry["StartonDisk"]   = ["hx16",  0, "DSTRT"]
        #entry["ContinClustr"]  = ["hx16",  0, "CClust"]
        #entry["EOFSec"]        = ["hx16",  0]
        #entry["Filesize"]       = ["hx16",  0x80, "FSize"]
        #entry["EndDisk"]        = ["hx16",  0, "DskEnd"]
        #entry["Directoryposition"] = ["dec2",  0, "Dirpos"]
        return entry        
    #----------------------------------
    def create_entries_file(self, pathname):
        entries = []
        fn = ''
        sfx = ''
        attrib = 0x72 # Default: Non-compressed, Contiguous alloc., System File, Binary Record
        entry = self.set_default_values()
        if self.verbose > 0:
            print(f'Looking in: {pathname}')
            #print(f'Dir: {os.listdir(pathname)}')
            idx = 0
        for f in os.listdir(pathname):
            if os.path.isfile(pathname+f) and "json" not in f:
                fn,sfx = f.split('.')
                #print(f'Found File: {f} {fn} . {sfx}')
                fsiz = os.path.getsize(pathname+f)
                attrib = 0x72
                if fn == "MDOSER":
                    attrib = 0x65
                if sfx == "SA":
                    attrib = 0x05
                if sfx == "CF":
                    attrib = 0x45
                #print('---------------------------------------------------------------------------------------------')
                entry["Name"]        = ["strw", f'{fn:8}', "Name        "]
                entry["Suffix"]        = ["strw", f'{sfx:2}', "SFX"]
                entry["Filesize"]    = ["dec5",  fsiz, "FSize"]
                entry["Attribute"]     = ["hx8", attrib, "Atrib"]
                self.print_entry(idx, entry) # Print values
                entries.append(entry)
                idx += 1
                entry = self.set_default_values()
        return entries
    #----------------------------------
    def add_rib(self, img, start, entry, filelen):
        bps = self.fspec["bps"]
        #filetype = entry["Filetype"][1]
        attrib = (entry["Attribute"][1] & 7)
        pos = start
        sizclu = math.ceil((filelen + 128) / 128 / 4) # size in clusters (filesize + RIB)
        sizsec = math.ceil(filelen/128)
        rest = filelen%128
        newstart = int(start/128/4)
        print(f'Add RIB @ {pos:06X} Size: {sizclu:02X} clusters')
        zeros = bytearray(0 for _ in range(bps))
        img[pos:pos+bps] = zeros # clear all 
        sdws = 1

        sdws = int(math.ceil(sizclu / 32)) # max cotniguous clusters in SDW is 32-1

        if self.verbose > 0:
            print(f'Size: {sizclu} cluster, need {sdws} SDWs')

        for s in range(sdws):
            if s == sdws-1:
                newsize = sizclu - 32*s
            else:
                newsize = 32
    
            if self.verbose > 0:
                print(f'Starting Cluster {newstart:04X} @ {newstart*4*128:04X} Size: {newsize:02X}')
            SDW = newstart # starting cluster
            SDW |= ((newsize-1)<<10)
            self.write_number2image(SDW, img, pos, 2)
            newstart += 0x20
            pos += 2

        if self.verbose > 0:
            print(f'Logical Sectors: {int(filelen/128):04X}, Rest: {rest:02X} Attribute: {attrib}')
        if rest == 0: # This does not work, see Chapter 24.2.1 (...must be non-zero)
            rest = 0x80
            TERM = 0x8000 | int(filelen/128)-1 # change TERM to reflect that
            self.write_number2image(TERM, img, pos, 2)
        else:
            TERM = 0x8000 | int(filelen/128)
            self.write_number2image(TERM, img, pos, 2)
        if (attrib & 4) == 0: # Bit 2 set means ASCII or ASCII-converted-binary
            self.write_number2image(rest, img, start+0x75, 1)
            self.write_number2image(sizsec, img, start+0x76, 2)
            self.write_number2image(entry["StartAdr"][1], img, start+0x78, 2)
            self.write_number2image(entry["ExecAdr"][1], img, start+0x7A, 2)
        return img
    #----------------------------------
    def add_file(self, img, start, fdata):
        bps = self.fspec["bps"]
        sizsec = int(math.ceil(len(fdata)/128))
        rest = len(fdata)%128
        filelen = len(fdata)
        padding = 0
        if rest:
            zeros = bytearray(0 for _ in range(bps-rest)) # Pad to full sector
            fdata += zeros
            padding = len(zeros)
        pos = start
        print(f'Add file @ {pos:06X} Size: {filelen:04X} or {sizsec:02X} sectors, padding with {padding:02X} zeros')
        img[start:start+len(fdata)] = fdata
        #for idx in range(sizsec): # go through the sectors
        #    b = idx*bps
        #    #print(f'Add chunk {idx} sector @ {pos:04X} chunk {b:04X} sectors: {len(fdata)/bps}')
        #    img[pos:pos+bps] = fdata[b:b+bps]
        #    pos += bps
        return img
    #----------------------------------
    def add_files(self, fdir, entries, stats, img, action):
        if action == 'CREATEBOOT':
            # Don't forget to update the Disk-RIB with the Overlay Addresses!
            print(f'Creating Boot Image is not really necessary on MDOS.')
            print(f'Every Disk is bootable and there is no space saving omitting the BOOTSECTOR.')
            print(f'Also it is necessary to include the MDOS and MDOSOV* Files (It is the FORMAT ;U Option in MDOS.)')
        
        self.print_dir(entries, stats)
        
        totalsz = 0
        c = 0
        h = 0
        s = 0
        diridx = 0
        dirstart = self.fspec["Dirstart"]
        direntrysize = self.fspec["Direntrysize"]
        bps = self.fspec["bps"]
        all_files = os.listdir(fdir)
        all_files.sort(reverse=True) # Optionally apply some sorting to match the original disk

        for f in all_files:
            if os.path.isfile(fdir+f) and 'json' not in f:
                #print(f'Found File: {f}')
                fdata = self.parent.read_file((fdir+f), 'binary') # Get the filedata
                if 'BOOTSECTOR' in f:
                    print(f'{self.parent.YEL}Found Bootsector{self.parent.END}')
                    img = self.add_file(img, 0xB80, fdata)
                else:
                    for idx,entry in enumerate(entries):            # look for lowest Directoryposition
                        ename = entry["Name"][1].strip()
                        esuffx = entry["Suffix"][1].strip()
                        efn = ename + '.' + esuffx
                        if efn == f:
                            print(f'Found File in entry: {efn}')
                            img = self.add_files_to_img(img, entry, fdata)

        #exit()
        #while len(entries) > diridx:                        # cycle through entries
        #if entry["Directoryposition"][1] == diridx:

            #psn = entry["StartPSN"][1]
            #----------------------------------
            # Here we add the filenames to the Directory
            # We need the stats file for Filetype, Startaddress, Endaddress, Program Counter,
            # Hiline (Basic) and three 'spares'.
            # Also the size can come from the stats file or from the actual filesize
            #if ('/' in name): # in FDOS Filenames can contain slash, we change them to underline
            #    fn = name.replace('/', '_')
            #fdata = self.parent.read_file((fdir+fn), 'binary') # Get the filedata
            #-------------------------------------------------------------------------
            # Get the filesize from the actual file and pad it to the next sector
            #-------------------------------------------------------------------------
            #flen = len(fdata)
            #tempsiz = flen/bps  # Size (in sectors) from actual filesize
            #temprest = (flen%bps)  # Rest in sectors
            #zeros = bytearray(0 for _ in range(bps-temprest)) # Pad to full sector
            ##fdata += zeros 
            #nsiz = int(math.ceil(tempsiz))
            #if temprest > 0:
            #    nsiz += 1
            #if self.verbose > 0:
            #    if temprest:
            #        print(f'{self.parent.YEL}Sectors: {tempsiz}, Rest: {temprest}/0x{temprest:02X}, needed sectors: {nsiz}/0x{nsiz:02X} Sectors: {len(fdata)/bps}{self.parent.END}')
            #siz = nsiz # Use actual filesize padded to next sectorboundry
            #-------------------------------------------------------------------------
            #pos = dirstart + diridx * direntrysize
            #pos = dirstart + entry["DEN"][1] * direntrysize
        #if self.verbose > 0:
            #    print(f'Checking {entry["Directoryposition"][1]}, diridx: {diridx}, of {len(entries)} entries. Pos: {pos:04X}')
        #if name == 'BOOTSECTOR':
        #    print(f'{self.parent.YEL}Found Bootsector{self.parent.END}')
        #    img = self.add_file(img, 0xB80, fdata)
        #else:
        #    img = self.add_files_to_img(img, entry, fdata)
                #----------------------------------
                # Now add the actual files to the Image
                #pos = psn * bps
                #if self.verbose > 0:
                #    print(f'Got File: {fn} with secs: {nsiz:02X} and rest: {temprest:02X} on pos: {pos:04X}')
                #img = self.add_rib(img, pos, entry)
                #pos += bps # RIB is always one sector
                #img = self.add_file(img, pos, fdata, siz)
                #if diridx >= 0:
                #    return img
            #c,h,s = self.offset_to_chs(totalsz) # Get position now for next free sector
            #diridx += 1
        #self.add_last_enty(img, diridx, totalsz)
        self.get_free_cluster(img)
        return img

