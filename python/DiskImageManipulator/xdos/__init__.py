# Ths file is part of: ditool.py - The Disk Image Tool
# 2025, R. Offner
import os

class bcolors:
	#FAIL = '\033[91m\033[107m' #red inverse
	FAIL = '\033[91m'    #red
	OKGREEN = '\033[92m'       #green
	WARNING = '\033[93m'       #yellow
	OKBLUE = '\033[94m'        #dblue
	HEADER = '\033[95m'        #purple
	OKCYAN = '\033[96m'        #cyan
	ENDC = '\033[0m'
	BOLD = '\033[1m'
	UNDERLINE = '\033[4m'
#print(f'{bcolors.FAIL}{bcolors.ENDC}')
#print(f'{bcolors.OKGREEN}{bcolors.ENDC}')
#print(f'{bcolors.WARNING}{bcolors.ENDC}')
#print(f'{bcolors.OKBLUE}{bcolors.ENDC}')
#print(f'{bcolors.HEADER}{bcolors.ENDC}')
#print(f'{bcolors.OKCYAN}{bcolors.ENDC}')
#------------------------------------------
class class_XDOS(object):

	def __init__(self, diskstruct, verbose):
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
	def read_file(self, fn, type = 'binary'):
		if (type == 'binary'):
			try:
				with open(fn, "rb") as f:
					#print(f'{bcolors.OKGREEN}File: {fn} open as binary for reading.{bcolors.ENDC}')
					img = f.read()
					f.close()
					return img
			except Exception as e:
				print(f'{bcolors.FAIL}Binary File {fn} not found!{bcolors.ENDC}')
				#exit()
		else:
			try:
				with open(fn, "r") as f:
					#print(f'{bcolors.OKGREEN}File: {fn} open as text for reading.{bcolors.ENDC}')
					img = f.read()
					f.close()
					return img
			except Exception as e:
				print(f'{bcolors.FAIL}Text File {fn} not found!{bcolors.ENDC}')
				#exit()
	#----------------------------------
	# parses the directory block
	def get_dir(self, imgfile):
		entries = []
		entry = []
		imgstat = []
		imgstat.append((imgfile[0:8]).decode("ascii")) # Disk ID
		imgstat.append((imgfile[8:10]).decode("ascii")) # Version
		imgstat.append((imgfile[10:12]).decode("ascii")) # Revision
		imgstat.append((imgfile[12:18]).decode("ascii")) # Generation Date
		imgstat.append((imgfile[18:38]).decode("ascii")) # Username
		imgstat.append((imgfile[38:58])) # Overlay
		imgstat.append((imgfile[128:256])) # Cluster Allocation Table
		imgstat.append((imgfile[256:384])) # Lockout Allocation Table
		off = self.DIROFF
		while (off < self.DIREND):
			#print(f'Off: {off}, Data: {imgfile[off]}')
			if ((imgfile[off] != 0x00) and (imgfile[off] != 0xFF)):
				#print(f'Off: 0x{off:04X}, Data: {imgfile[off]}')
				entry.append((imgfile[off:(off+8)]).decode("ascii"))      # Name
				entry.append((imgfile[(off+8):(off+10)]).decode("ascii")) # Suffix
				entry.append((imgfile[(off+10)]*256 + imgfile[(off+11)])) # Start PSN
				entry.append(imgfile[(off+12)]) # Attributes
				temp = int((off-self.DIROFF)/self.ENTRYSZ) # DEN (Dir. Entry Nr.)
				pos = temp & 0x07
				psec = (temp >> 3) & 0x1F
				entry.append(pos)  # DEN Position 
				entry.append(psec) # DEN Physical Sector
				entries.append(entry)
				entry = []
			off += self.ENTRYSZ
		RIB = 0x18*128
		imgstat.append((imgfile[RIB:RIB+128])) # RIB
#		imgstat.append((imgfile[(off+17)])) # Next free Sector
#		imgstat.append((imgfile[(off+18)]*256 + imgfile[(off+19)])) # Total free Sectors
		return entries, imgstat
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
#	def create_boot_image(self):
#		img = self.create_image()
#		img[:len(fdos_boot)] = fdos_boot
#		secsz = 20
#		self.add_dir_enty(img, 0,'$DOS', '', 0,0,secsz,0,0x2400,0x2FFF,0x2600,0x3824,0x99,0xBD,0x42)
#		self.add_last_enty(img, 1, self.DIREND)
#		return img
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
		statsfile = self.read_file(fn, 'text')
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
			fdata = self.read_file((fdir+fn), 'binary') # Get the filedata
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
