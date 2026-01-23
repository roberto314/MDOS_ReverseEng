# Ths file is part of: ditool.py - The Disk Image Tool
# 2025, R. Offner
import os

class class_FDOS(object):

    def __init__(self, parent, diskstruct, verbose):
        self.PARENT = parent
        self.verbose = verbose
        self.TRACKS = diskstruct[0]
        self.SIDES = diskstruct[1]
        self.SECTORS = diskstruct[2]
        self.SECLEN = diskstruct[3]
        self.DIROFF = diskstruct[4]
        self.DIREND = diskstruct[5]
        self.ENTRYSZ = diskstruct[6]
        self.EMPTYVAL = diskstruct[7]
        #self.EMPTYVAL = 0xE5
        self.TOTALSEC = self.SECTORS  * self.SIDES * self.TRACKS
        self.IMGSIZE = self.TOTALSEC * self.SECLEN # Size is usually 89600 Bytes SSSD (FM)
        if verbose > 0:
            print(f'Imageformat:')
            print(f' Tracks: {self.TRACKS}')
            print(f' Sides: {self.SIDES}')
            print(f' Sectors: {self.SECTORS}')
            print(f' Bytes/Sectors: {self.SECLEN}')
            print(f' Directory at: 0x{self.DIROFF:04X}')
            print(f' Files at: 0x{self.DIREND:04X}')
            print(f' Size of entry: {self.ENTRYSZ}')
            print(f' Emptyvalue: {self.EMPTYVAL}')
    #----------------------------------
    # parses the directory block
    def get_dir(self, imgfile):
        entries = []
        entry = []
        imgstat = []
        while (imgfile[self.DIROFF] != 0xFF):
            entry.append((imgfile[self.DIROFF:(self.DIROFF+8)]).decode("ascii")) # Name
            entry.append((imgfile[(self.DIROFF+8):(self.DIROFF+16)]).decode("ascii")) # Password
            entry.append((imgfile[(self.DIROFF+16)])) # Start Track
            entry.append((imgfile[(self.DIROFF+17)])) # Start Sector
            entry.append((imgfile[(self.DIROFF+18)]*256 + imgfile[(self.DIROFF+19)])) # Size in Sectors
            FTYPE = int((imgfile[(self.DIROFF+20)]))
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
            entry.append(FTYPETXT) # Filetype
            entry.append((imgfile[(self.DIROFF+21)]*256 + imgfile[(self.DIROFF+22)])) # Starting Address (in Memory)
            entry.append((imgfile[(self.DIROFF+23)]*256 + imgfile[(self.DIROFF+24)])) # Ending Address (in Memory)
            entry.append((imgfile[(self.DIROFF+25)]*256 + imgfile[(self.DIROFF+26)])) # Program Start Address
            entry.append((imgfile[(self.DIROFF+27)]*256 + imgfile[(self.DIROFF+28)])) # High Line (for Basic adn co-res)
            entry.append((imgfile[(self.DIROFF+29)])) # Spares
            entry.append((imgfile[(self.DIROFF+30)])) # Spares
            entry.append((imgfile[(self.DIROFF+31)])) # Spares
            
            entries.append(entry)
            entry = []
            self.DIROFF += self.ENTRYSZ
        imgstat.append((imgfile[(self.DIROFF+16)])) # Next free Track
        imgstat.append((imgfile[(self.DIROFF+17)])) # Next free Sector
        imgstat.append((imgfile[(self.DIROFF+18)]*256 + imgfile[(self.DIROFF+19)])) # Total free Sectors
        return entries, imgstat
    #----------------------------------
    # Prints out Directory
    def print_dir(self, img):
        print(f'Showing Directory.') # Directory is easy, it starts @ 0x1400 until a 0xFF is found @ first position
        entries, imgstat = self.get_dir(img)
        #        e[0]      e[1]       e[2]    e[3]     e[4]     e[5]    e[6]     e[7]     e[8]    e[9]   e[10]-e[12]
        print(f'Name      Password  StartTrk StartSec SecSize   Type  Startaddr EndAddr PC-Addr Hi-Line    Spares')
        for e in entries:
            print(f'{e[0]:8} ({e[1]}) {e[2]:8} {e[3]:8} {e[4]:7} {e[5]:>8}  0x{e[6]:04X}  0x{e[7]:04X}   0x{e[8]:04X} 0x{e[9]:04X} 0x{e[10]:02X} 0x{e[11]:02X} 0x{e[12]:02X}')
        print(f'Next free Track: {imgstat[0]} / Sector: {imgstat[1]}. Free Sectors: 0x{imgstat[2]:04X}')
    #----------------------------------
    # adds a file to the directory including all the necessary data
    def add_dir_enty(self, img, pos, name, passw, sttrk, stsec, siz, typ, saddr, eaddr, pc, hilin, sp0, sp1, sp2):
        ap = pos * self.ENTRYSZ + self.DIROFF # actual Position
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
    def chs_to_offset(self, c, h, s):
        offset = (self.SECTORS * self.SECLEN * c) + self.SECLEN * s
        return offset
    #----------------------------------
    def offset_to_chs(self, off):
        totalsec = int(off / self.SECLEN)
        track = (totalsec / self.SECTORS) # How many Tracks are these
        s = (totalsec % self.SECTORS)  # How many Sectors are rest
        c = int(track)
        h = 0
        if self.verbose > 0:
            print(f'off: {off:04X} c: {c} s: {s} totalsec: {totalsec} Track: {track}')
        return c, h, s
    #----------------------------------
    # adds the last entry which indicates no more files and free space on floppy
    def add_last_enty(self, img, pos, off):
        totalsec = (self.IMGSIZE - off) / self.SECLEN
        nft,h,nfs = self.offset_to_chs(off)
        track = int(off / self.SECLEN) # How many Tracks are these
        print(f'Next Free Trk.: {nft}, Next Free Sec.: {nfs}, Tracks used: {track} TotalFree: {totalsec}, 0x{int(totalsec):02X}')       
        ap = pos * self.ENTRYSZ + self.DIROFF # actual Position
        clrpos = pos * self.ENTRYSZ + self.DIROFF
        zeros = bytearray(0 for _ in range(self.DIREND - clrpos)) # Clear out 
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
    def get_file(self, imgfile, e):
        data = bytearray()
        track = e[2]
        sector = e[3]
        for s in range(e[4]):
            off = self.chs_to_offset(track, 0, sector)
            data += imgfile[off:(off+self.SECLEN)]
            #print(f'Track: {track}, Sector: {sector}, Offset: 0x{off:04X}')
            sector += 1
            if sector >= self.SECTORS:
                sector = 0
                track += 1
        return data
    #----------------------------------
    def convert_stats(self, ent, stat):
        string = ''
        string = 'Name      Password  StartTrk StartSec SecSize   Type  Start  End  PCnt  Hi-Line Spares\n'
        #print(ent)
        for e in ent:
            #string += ('{:8}|{:8}|{:8}|{:8}|{:8}|{:02X}|{:04X}|{:04X}|{:04X}|{:04X}|{:02X}|{:02X}|{:02X}\n'.format(e[0],e[1],e[2],e[3],e[4],e[5],e[6],e[7],e[8],e[9],e[10],e[11],e[12]))
            string += ('{:9};{:9};{:9};{:9};{:9};{:>7};0x{:04X};0x{:04X};0x{:04X};0x{:04X};0x{:02X};0x{:02X};0x{:02X}\n'.format(e[0],e[1],e[2],e[3],e[4],e[5],e[6],e[7],e[8],e[9],e[10],e[11],e[12]))

        string += ('Next Free Track: {:3} Next Free Sector: {:3} Free Sectors: 0x{:04X}'.format(stat[0],stat[1], int(stat[2]))) + '\n'
        return string
    #----------------------------------
    def create_image(self):
        img = bytearray(self.EMPTYVAL for _ in range(self.IMGSIZE)) # make empty imagefile with correct size
        return img
    #----------------------------------
    # In FDOS this is not really usefull since the $DOS File is the bootsector and is like a 
    # normal file
#   def create_boot_image(self):
#       img = self.create_image()
#       img[:len(fdos_boot)] = fdos_boot
#       secsz = 20
#       self.add_dir_enty(img, 0,'$DOS', '', 0,0,secsz,0,0x2400,0x2FFF,0x2600,0x3824,0x99,0xBD,0x42)
#       self.add_last_enty(img, 1, self.DIREND)
#       return img
    #----------------------------------
    def add_file(self, img, fdata, sttrk, stsec, siz):
        off = self.chs_to_offset(sttrk, 0, stsec)
        for idx in range(siz): # go through the sectors
            cstart = idx * self.SECLEN
            start = off + cstart
            img[start:start+self.SECLEN] = fdata[cstart:cstart+self.SECLEN]
    #----------------------------------
    def add_files(self, fdir, img):
        arr = os.listdir(fdir)
        numfiles = len(arr)-1 # remove stats file
        fn = fdir + 'stats'
        statslines = []
        statsfile = self.PARENT.read_file(fn, 'text')
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
            fdata = self.PARENT.read_file((fdir+fn), 'binary') # Get the filedata
            #-------------------------------------------------------------------------
            # Get the filesize from the actual file and pad it to the next sector (alternative)
            #-------------------------------------------------------------------------
            #tempsiz = len(fdata)/self.SECLEN  # Size (in sectors) from actual filesize
            #temprest = self.SECLEN - (len(fdata)%self.SECLEN)  # Rest in sectors
            #zeros = bytearray(0 for _ in range(temprest))
            #fdata += zeros
            #nsiz = int(len(fdata)/self.SECLEN)
            #print(f'Tempsiz: {tempsiz}, Temprest: {temprest}, new: {nsiz}')
            #siz = nsiz # Use actual filesize padded to next sectorboundry
            #-------------------------------------------------------------------------
            siz = int(e[4], 0) # Use size from stats file
            c,h,s = self.offset_to_chs(totalsz)
            totalsz += siz * self.SECLEN
            passw = e[1]
            if name == '$DOS':
                sttrk = int(e[2], 0)
                stsec = int(e[3], 0)
                totalsz += self.SECTORS * self.SECLEN # one track extra for directory
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
            print(f'Adding {name:8} to: {sttrk=:2} {stsec=:2} {siz=:2} NxtOff: {totalsz:>05X} Size of File: {len(fdata)/self.SECLEN:>5.1f}')
            self.add_dir_enty(img, idx, name, passw, sttrk, stsec, siz, typ, saddr, eaddr, pc, hilin, sp0, sp1, sp2)
            #----------------------------------
            # Now add the actual files to the Image
            self.add_file(img, fdata, sttrk, stsec, siz)
        #c,h,s = self.offset_to_chs(totalsz)
        self.add_last_enty(img, idx, totalsz)
        return img
