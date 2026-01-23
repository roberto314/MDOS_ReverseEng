# Ths file is part of: ditool.py - The Disk Image Tool
# 2025, R. Offner
import os

class class_MDOS(object):
    def conv16 (self, data, startoff):
        number = data[startoff]*256
        number += data[startoff+1]
        return number

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
        imgstat.append((imgfile[0:8]).decode("ascii"))   # 0 # Diskette ID
        imgstat.append((imgfile[8:10]).decode("ascii"))  # 1 # Verion Nr.
        imgstat.append((imgfile[10:12]).decode("ascii")) # 2 # Revision Nr.
        imgstat.append((imgfile[12:18]).decode("ascii")) # 3 # Generation Date
        imgstat.append((imgfile[18:38]).decode("ascii")) # 4 # User Name
        imgstat.append((imgfile[38:58]))                 # 5 # MDOS Overlay RIB Addresses
        imgstat.append((imgfile[128:256]))               # 6 # Cluster Allocation Table
        imgstat.append((imgfile[256:384]))               # 7 # Lockout Allocation Table
        off = self.DIROFF
        while (off < self.DIREND):
            #print(f'Off: {off}, Data: {imgfile[off]}')
            if ((imgfile[off] != 0x00) and (imgfile[off] != 0xFF)):            # Position in:
                #print(f'Off: 0x{off:04X}, Data: {imgfile[off]}')              # entry # entries
                entry.append((imgfile[off:(off+8)]).decode("ascii"))              # 8  # 0 # Name
                entry.append((imgfile[(off+8):(off+10)]).decode("ascii"))         # 9  # 1 # Suffix
                entry.append(self.conv16(imgfile, off+10))                        # 10 # 2 # Start PSN
                entry.append(imgfile[(off+12)]) # Low Byte of attrib. is not used # 11 # 3 # Attributes
                temp = int((off-self.DIROFF)/self.ENTRYSZ) # DEN (Dir. Entry Nr.)
                pos = temp & 0x07
                psec = (temp >> 3) & 0x1F
                entry.append(pos)                                                 # 12 # 4 # DEN Position 
                entry.append(psec)                                                # 13 # 5 # DEN Physical Sector
                FRIB = entry[2]*128
                entry.append(imgfile[FRIB:FRIB+128])                              # 14 # 6 # File RIB
                entries.append(entry) # Append only directory entries here
                entry = []
            off += self.ENTRYSZ
        BOOTBLOCK = 0x17 * 128
        imgstat.append((imgfile[BOOTBLOCK:BOOTBLOCK+128])) # 8 # BOOTBLOCK
        return entries, imgstat
    #----------------------------------
    # Prints out Directory
    def print_dir(self, img):
        print(f'Showing Directory.')
        entries, imgstat = self.get_dir(img)
        print(f'Disk sides: {self.SIDES}')
        print(f'Diskette ID: "{imgstat[0]}"')
        print(f'Version: {imgstat[1]}')
        print(f'Rev.: {imgstat[2]} ')
        print(f'Gen. Date: {imgstat[3]}') 
        print(f'Username:  "{imgstat[4]}"')
        print(f'Overlay RIB Addr.:') #.to_bytes(2,'big')
        ORIB = imgstat[5]
        for i in range(0,len(ORIB),2):
            RIBA = self.conv16(ORIB, i)
            print(f'Overlay {int(i/2)}: 0x{RIBA:02X}')
        CAT = imgstat[6]
        print(f'Cluster Allocation Table: (0x80)')
        self.PARENT.dump_data(CAT,16)
        #print(f'sec: 0123456789012345678901234501234567890123456789012345')
        #for trk in range(77):
        #    print(f'{trk:02}   ', end = '')
        #    for sect in range(26*2):
        #        print(f'x',end = '')
        #    print(f'')

        LAT = imgstat[7]
        print(f'Lockout Cluster Allocation Table: (0x100)')
        self.PARENT.dump_data(LAT,16)
        print(f'Directory starts @ PSN: $03-$16, 0x180-0xB7F')
        #        e[0]      e[1]  TYP  e[2]    e[3]     e[4]  e[5]    e[6]      e[7]  STARTLOAD EXECADDR  NBLS   ENDLD   ENDDSK
        print(f'Name     Suffix  TYP  PSN     Attrib   Pos. Ph.Sec.  RIBaddr  Sec2Ld StartAddr ExecAddr BytesLS EndLOAD EndonDSK')
        for e in entries:
            NBLS = e[6][0x75]                          # RIB: Byes in last Sector
            NSL = self.conv16(e[6], 0x76)              # RIB: Number of Sectors to Load
            STARTLOAD = self.conv16(e[6], 0x78)        # RIB: Starting Load Address
            EXECADDR = self.conv16(e[6], 0x7a)         # RIB: ExecutionAddress
            ENDLD = (NSL-1)*128 + NBLS + STARTLOAD - 1 # RIB: End Load Address
            FSIZ = (NSL-1)*128 + NBLS
            ENDDSK = (e[2]*128)+0x80 + FSIZ - 1
            TYP = ''
            if (e[3] & 7) == 0:
                TYP = 'USR'
            elif (e[3] & 7) == 2:
                TYP = 'MEM'
            elif (e[3] & 7) == 3:
                TYP = 'BIN'
            elif (e[3] & 7) == 5:
                TYP = 'ASC'
            elif (e[3] & 7) == 7:
                TYP = 'ACB'

            i = 0
            for idx in range(0,0x73, 2):
                #self.PARENT.dump_data(e[6],16) # Dump File RIB
                SDW = e[6][idx]*256
                SDW += e[6][idx+1]
                if SDW != 0:
                    if SDW & 0x8000:
                        EOFSECT = SDW & 0x7FFF
                        print(f'Terminator: {SDW:04X} Log. Sect. of EOF: {EOFSECT:02X}')
                    else:
                        STARTCL = SDW & 0x03FF # lower 10 bits are Starting Cluster
                        CONTCL = ((SDW & 0x7C00)>>9)+1  # Bits 10-14 are Number of contin. clusters - 1
                        print(f'SDW{i}: {SDW:04X} STARTCLUSTER: {STARTCL:04X} Continuous Cluster: {CONTCL:02X}')
                i += 1
            if TYP == 'ASC' or TYP == 'ACB':
                ENDLD = 0
                FSIZ = CONTCL * 4 * 128
                #FSIZ = EOFSECT * 128
                ENDDSK = e[2] * 128 + FSIZ - 1

            if 'MDOS' in e[0]:
                print(f'{self.PARENT.GRN}',end = '') # Print System Files in Green
            print(f'{e[0]:8} .{e[1]}     {TYP:3}  0x{e[2]:04X}   0x{e[3]:02X}    {e[4]:2}    {e[5]:2}      {(e[2]*128):05X}      {NSL:02X}     {STARTLOAD:04X}      {EXECADDR:04X}     {NBLS:02X}    {ENDLD:04X}  {ENDDSK:05X}')
            print(f'{self.PARENT.END}',end = '')
            #print(f'FRIB starts @ PSN: {e[2]}, {(e[2]*128):05X}')


        BOOTBLOCK = imgstat[8]
        #RIB = imgstat[9]
        print(f'BOOTBLOCK starts @ PSN: $17, 0xB80')
        self.PARENT.dump_data(BOOTBLOCK,16)

        #print(f'RIB starts @ PSN: $18, 0xC00')
        #self.PARENT.dump_data(RIB,16)

        print(f'Data (mdos.sy) data starts @ PSN: $19, 0xC80')
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
