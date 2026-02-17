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

import os

class class_FDOS(object):

    def __init__(self, parent, fspec, verbose):
        #self.parent = parent
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
    #----------------------------------
    def isascii(self,b):
        try:
            s = b.decode("ascii")
        except UnicodeDecodeError:
            #print(f'Deleted File: xx{(b[2:8]).decode("ascii")}')
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
    def create_image(self, stats, variant):
        img = bytearray(self.fspec["Emptyval"] for _ in range(self.fspec["Imagesize"])) # make empty imagefile with correct size
        return img
    #----------------------------------
    # parses the directory block
    def get_dir(self, imgfile):
        entries = [] # List of all Entries
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
            if self.isascii(imgfile[offset:(offset+8)]): # We have a "real" directory entry
                name = (imgfile[offset:(offset+8)]).decode("ascii")
                if "DOS" in name: # Print System files in Green
                    entry["Name"]        = ["strg", name, "Name        "]
                else:
                    entry["Name"]        = ["strw", name, "Name        "]
                entry["Password"]    = ["strw", '\''+(imgfile[(offset+8):(offset+16)]).decode("ascii")+'\'']
                entry["Password_Clean"]    = ["not", (imgfile[(offset+8):(offset+16)]).decode("ascii")]
                entry["StartTrack"]  = ["hx8", imgfile[(offset+16)], "STrk"]
                entry["StartSector"] = ["hx8", imgfile[(offset+17)], "SSec"]
                entry["SizeinSecs"]  = ["hx8", self.conv16(imgfile, (offset+18)), "SSiz"]
                FTYPE = int((imgfile[(offset+20)])) # What is the Filetype
                entry["Attribute"] = ["hx8", FTYPE, "Atrib"]
                FTYPETXT = ''
                if (FTYPE == 0x00):
                    FTYPETXT = 'Blank'
                elif(FTYPE == 0x11):
                    FTYPETXT = 'System'
                elif(FTYPE == 0x22):
                    FTYPETXT = 'Object'
                elif(FTYPE == 0x55):
                    FTYPETXT = 'Basic'
                elif(FTYPE == 0x77):
                    FTYPETXT = 'Cores'
                elif(FTYPE == 0x99):
                    FTYPETXT = 'B.Data'
                entry["Filetype"]    = ["strw",  FTYPETXT, "Type"]
                entry["SAddr"]       = ["hx16", self.conv16(imgfile, (offset+21))]
                entry["EAddr"]       = ["hx16", self.conv16(imgfile, (offset+23))]
                entry["Exec"]        = ["hx16", self.conv16(imgfile, (offset+25))]
                entry["Hi"]          = ["hx16", self.conv16(imgfile, (offset+27))]
                entry["Sp0"]         = ["hx8",  (imgfile[(offset+29)])]
                entry["Sp1"]         = ["hx8",  (imgfile[(offset+30)])]
                entry["Sp2"]         = ["hx8",  (imgfile[(offset+31)])]
                FSIZ = entry["SizeinSecs"][1] * self.fspec["bps"]
                entry["Filesize"]    = ["dec5",  FSIZ, "FSize"]
                entry["Directoryposition"] = ["dec2",  dirpos, "Dirpos"]
                entries.append(entry)                 # append to list of entries
                dirpos += 1
            else:
                break
            offset += self.fspec["Direntrysize"]  # cue to next entry
        
        # Print statistics at the end of listing
        stats = {}
        stats["Next free Track: "]    = ["hx8", imgfile[(offset+16)]]
        stats["Next free Sector: "]   = ["hx8", imgfile[(offset+17)]]
        stats["Total free sectors: "] = ["hx8", (self.conv16(imgfile, (offset+18)))]

        return entries, stats
    #----------------------------------
    def get_file(self, imgfile, entry):
        data = bytearray()
        track = entry["StartTrack"][1]
        sector = entry["StartSector"][1]
        for s in range(entry["SizeinSecs"][1]):
            off = self.chs_to_offset(track, 0, sector)
            data += imgfile[off:(off+self.fspec["bps"])]
            #if self.verbose > 0:
            #    print(f'Track: {track}, Sector: {sector}, Offset: 0x{off:04X}')
            sector += 1
            if sector >= self.fspec["Sectors"]:
                sector = 0
                track += 1
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
        print(f'Showing Directory. (all values in hex!)') # Directory is easy, it starts @ 0x1400 until a 0xFF is found @ first position
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
    # adds the last entry which indicates no more files and free space on floppy
    def add_last_enty(self, img, pos, off):
        totalsec = (self.fspec["Imagesize"] - off) / self.fspec["bps"] + self.fspec["Sectors"] # remove extra track for dir
        nft,h,nfs = self.offset_to_chs(off)
        track = int(off / self.fspec["bps"]) # How many Tracks are these
        print(f'Next Free Trk.: {nft}, Next Free Sec.: {nfs}, Tracks used: {track} Rest: {self.fspec["Imagesize"]-off} TotalFree: {totalsec}/ 0x{int(totalsec):02X}')       
        ap = pos * self.fspec["Direntrysize"] + self.fspec["Dirstart"] # actual Position
        clrpos = pos * self.fspec["Direntrysize"] + self.fspec["Dirstart"]
        zeros = bytearray(0 for _ in range(0x1700 - clrpos)) # Clear out part of dir
        #zeros = bytearray(0 for _ in range(self.fspec["Filestart"] - clrpos)) # Clear out rest of dir
        #zeros = bytearray(0 for _ in range(self.fspec["Direntrysize"])) # Clear out direntry only
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
        ap = pos * self.fspec["Direntrysize"] + self.fspec["Dirstart"] # actual Position
        text = bytearray(0x20 for _ in range(16)) # Clear out name and password
        namtxt = (name.encode("ascii")).strip()
        passtxt = (passw.encode("ascii")).strip()
        text[0:len(namtxt)] = namtxt
        text[8:8+len(passtxt)] = passtxt
        #print(f'Adding: {text} @ {ap:04X}')
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
        entry["Name"]        =    ["strw", '        ', "Name        "]
        entry["Password"]    = ["strw", '\'          \'']
        entry["Password_Clean"] =  ["not", '        ']
        entry["StartTrack"]  = ["hx8", 0, "STrk"]
        entry["StartSector"] = ["hx8", 0, "SSec"]
        entry["SizeinSecs"]  = ["hx8", 0, "SSiz"]
        entry["Attribute"]   = ["hx8", 0x22, "Atrib"]
        entry["Filetype"]    = ["strw",  '     ', "Type"]
        entry["SAddr"]       = ["hx16", 0]
        entry["EAddr"]       = ["hx16", 0]
        entry["Exec"]        = ["hx16", 0]
        entry["Hi"]          = ["hx16", 0]
        entry["Sp0"]         = ["hx8",  0]
        entry["Sp1"]         = ["hx8",  0]
        entry["Sp2"]         = ["hx8",  0]
        entry["Filesize"]    = ["dec5",  0, "FSize"]
        entry["Directoryposition"]    = ["dec5",  0, "Dirpos"]
        return entry        
    #----------------------------------
    def create_entries_file(self, pathname):
        entries = []
        entry = self.set_default_values()
        if self.verbose > 0:
            print(f'Looking in: {pathname}')
            #print(f'Dir: {os.listdir(pathname)}')
            idx = 0
        for f in os.listdir(pathname):
            if os.path.isfile(pathname+f):
                #print(f'Found File: {f}')
                fsiz = os.path.getsize(pathname+f)
                #print('---------------------------------------------------------------------------------------------')
                entry["Name"]        = ["strw", f'{f:8}', "Name        "]
                entry["Filesize"]    = ["dec5",  fsiz, "FSize"]
                #self.print_entry(1, entry) # Print values
                #entry["Name"]        = ["strw", self.get_val(entry, "Name"), "Name        "]
                #entry["StartTrack"]  = ["hx8", self.get_val(entry, "StartTrack"), "STrk"]
                #entry["StartSector"] = ["hx8", self.get_val(entry, "StartSector"), "SSec"]
                #entry["Attribute"]   = ["hx8", self.get_val(entry, "Attribute"), "Atrib"]
                #entry["SAddr"]       = ["hx16", self.get_val(entry, "SAddr")]
                #entry["EAddr"]       = ["hx16", self.get_val(entry, "EAddr")]
                #entry["Exec"]        = ["hx16", self.get_val(entry, "Exec")]
                #entry["Hi"]          = ["hx16", self.get_val(entry, "Hi")]
                #entry["Sp0"]         = ["hx8",  self.get_val(entry, "Sp0")]
                #entry["Sp1"]         = ["hx8",  self.get_val(entry, "Sp1")]
                #entry["Sp2"]         = ["hx8",  self.get_val(entry, "Sp2")]
                self.print_entry(idx, entry) # Print values
                entries.append(entry)
                idx += 1
                entry = self.set_default_values()
        #print(f'Entries Len: {len(entries)}')
        return entries
    #----------------------------------
    def add_file(self, img, fdata, sttrk, stsec, siz):
        off = self.chs_to_offset(sttrk, 0, stsec)
        for idx in range(siz): # go through the sectors
            cstart = idx * self.fspec["bps"]
            start = off + cstart
            img[start:start+self.fspec["bps"]] = fdata[cstart:cstart+self.fspec["bps"]]
    #----------------------------------
    def add_files(self, fdir, entries, stats, img, action):
        if action == 'CREATEBOOT':
            print(f'Creating Boot Image is no really necessary on FDOS.')
            print(f'Just put a file named $DOS in the FILES Directory and it will be the bootfile.')
        
        self.print_dir(entries, stats)
        
        totalsz = 0
        c = 0
        h = 0
        s = 0
        diridx = 0
        bps = self.fspec["bps"]

        while len(entries) > diridx:                        # cycle through entries
            for idx,entry in enumerate(entries):            # look for lowest Directoryposition
                if entry["Directoryposition"][1] == diridx:
                    name = entry["Name"][1].strip()
                    if self.verbose > 0:
                        print(f'Checking {entry["Directoryposition"]}, diridx: {diridx}, len: {len(entries)}')
                    fn = name
                    #----------------------------------
                    # Here we add the filenames to the Directory
                    # We need the stats file for Filetype, Startaddress, Endaddress, Program Counter,
                    # Hiline (Basic) and three 'spares'.
                    # Also the size can come from the stats file or from the actual filesize
                    if ('/' in name):
                        fn = name.replace('/', '_')
                    fdata = self.parent.read_file((fdir+fn), 'binary') # Get the filedata
                    if self.verbose > 0:
                        print(f'Got File: {fn} with size: {len(fdata)}')
                    #-------------------------------------------------------------------------
                    # Get the filesize from the actual file and pad it to the next sector
                    #-------------------------------------------------------------------------
                    flen = len(fdata)
                    tempsiz = flen/bps  # Size (in sectors) from actual filesize
                    temprest = (flen%bps)  # Rest in sectors
                    zeros = bytearray(0 for _ in range(temprest))
                    fdata += zeros
                    nsiz = int(len(fdata)/bps)
                    if self.verbose > 0:
                        print(f'Sectors: {tempsiz}, Rest: {temprest}, new: {nsiz}')
                    siz = nsiz # Use actual filesize padded to next sectorboundry
                    #-------------------------------------------------------------------------
                    #siz = int(entry["SizeinSecs"][1]) # Use size from stats file
                    totalsz += siz * bps
                    #passw = entry["Password_Clean"][1] # this is needed from entries file (can maybe be a default value)
                    passw = '        ' # default is no password
                    if name == '$DOS':
                        totalsz += self.fspec["Sectors"] * bps # Add one track for directory
                        sttrk = 0 # We need to start with $DOS at 0,0
                        stsec = 0 # We need to start with $DOS at 0,0
                    #else:
                    #    sttrk = c
                    #    stsec = s
                    sttrk = (entry["StartTrack"][1])  # this is needed from entries file (can be calculated)
                    stsec = (entry["StartSector"][1]) # this is needed from entries file (can be calculated)
                    saddr = entry["SAddr"][1]         # this is needed from entries file
                    eaddr = entry["EAddr"][1]         # this is needed from entries file
                    pc = entry["Exec"][1]             # this is needed from entries file
                    hilin = entry["Hi"][1]            # this is needed from entries file
                    sp0 = entry["Sp0"][1]             # this is needed from entries file
                    sp1 = entry["Sp1"][1]             # this is needed from entries file
                    sp2 = entry["Sp2"][1]             # this is needed from entries file
                    typ = entry["Attribute"][1]       # this is needed from entries file
                    #print(f'Adding #{diridx} {name:8} to: {sttrk=:2} {stsec=:2} {siz=:2} NxtOff: {totalsz:>05X} Size of File: {len(fdata)/bps:>5.1f}')
                    self.add_dir_enty(img, diridx, name, passw, sttrk, stsec, siz, typ, saddr, eaddr, pc, hilin, sp0, sp1, sp2)
                    #----------------------------------
                    # Now add the actual files to the Image
                    self.add_file(img, fdata, sttrk, stsec, siz)
                    c,h,s = self.offset_to_chs(totalsz) # Get position now for next free sector
                    diridx += 1
        self.add_last_enty(img, diridx, totalsz)
        return img
