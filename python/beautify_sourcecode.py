#!/usr/bin/python3
import sys, os, stat, subprocess, re, binascii, time


ver = 1.00

CPU = "6303" # can also be "hc11"
ENDADDRESS = 65536
SEPARATOR = "##############################################################"

class bcolors:
    FAIL = '\033[91m'    #red
    OKGREEN = '\033[92m' #green
    WARNING = '\033[93m' #yellow
    OKBLUE = '\033[94m'  #dblue
    HEADER = '\033[95m'  #purple
    OKCYAN = '\033[96m'  #cyan
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
#print(f'{bcolors.FAIL}{bcolors.ENDC}')
#print(f'{bcolors.OKGREEN}{bcolors.ENDC}')
#print(f'{bcolors.WARNING}{bcolors.ENDC}')
#print(f'{bcolors.OKBLUE}{bcolors.ENDC}')
#print(f'{bcolors.HEADER}{bcolors.ENDC}')
#print(f'{bcolors.OKCYAN}{bcolors.ENDC}')

# Line Format:
# Label (not always) Mnemonic Argument (zero or one field) (;) comment
# ZFFD9              STAB     M00E7                            with or w/o ;
#
NOARGMN = {'ABA','CLRA','CLRB','CBA','COMA','COMB','NEGA','NEGB','DAA',
           'DECA','DECB','INCA','INCB','PSHA','PSHB','PULA','PULB','ROLA',
           'ROLB','RORA','RORB','ASLA','ASLB','ASRA','ASRB','LSRA','LSRB',
           'SBA','TAB','TBA','TSTA','TSTB','SEI','DEX','CLI','RTS','INX',
           'INS','DES','TSX','TXS','CLC'}

def remove_empty(line):
	retline = ''
	argument = ''
	for i in range(len(line)):
		if line[i] != '':
			argument = line[i]
			retline = line[i+1:]
			return retline, argument.strip()
	return retline, argument

def assemble_comment(tl):
	line = ''
	#print(f'{tl}')
	for p in tl:
		ch = p.strip()
		if ch != '' and ch != ';':
			if ch == 'BLE':
				line = line.strip() + ch + ' '
			else:
				line = line + ch + ' '
	return line.strip()

def get_args(line):
	al = ''
	for p in line:
		if p != '':
			al = al + p.strip() + ' '
	return al

def bt_cmt(line):
	ret = ''
	l = line.split(' ')
	for c in l:
		p = c.strip()
		if p != '':
			#print(f'{p} ')
			ret = ret + p + ' '
	return ret

def parse_line(line):
	label = ''
	mnemonic = ''
	argument = ''
	cmt = ''
	lcmt = ''
	tl = line.split(' ')
	temp = tl[0]
	#print(f'In Parse_line.. {line} Chunk: {temp}')
	if temp.startswith(";"):
		cmt = bt_cmt(line)
		return cmt, label, mnemonic, argument, lcmt
	if tl[0] != '':
		label = tl[0]
	tl = tl[1:]
	tl, mnemonic = remove_empty(tl)
	if mnemonic in NOARGMN:  # no argument
		#argument = '-----'
		#print(f'Mn: {mnemonic}')
		lcmt = assemble_comment(tl)
	elif mnemonic == 'FCC': # special case for character strings
		argument = get_args(tl)
		#print(f'------- {tl}')
	else:                     # argument
		tl, temp = remove_empty(tl)
		argument = temp
		#tl, temp = remove_empty(tl)
		lcmt = assemble_comment(tl)
	#if tl != '': # comment
	#	lcmt = ''
	#lcmt = tl
	if label == '' and mnemonic == '':
		return ';','','','',''
	else:
		return cmt,label, mnemonic, argument, lcmt

def return16(t1, t2):
	retval = 0
	hl = 0
	low = 0
	#print(f't1: {t1} t2: {t2}')
	if t1 != '':
		hl = int(t1,16)
	if t2 != '':
		low = int(t2,16)
	if t2 != '':
		retval = hl*256 + low
	elif t1 != '':
		retval = hl
	else:
		retval = 0
	return retval
	
def put_line(filename, line):
	with open(filename, 'a') as fp:
		fp.write(line)

def main(asmfile):
	filename = 'test2.asm'
	with open(filename, 'w') as fp:
		fp.write('')
	for line in asmfile:
		cmt,label,mnemonic, argument, lcmt = parse_line(line)
		if mnemonic == 'SWI':
			addr, rest = lcmt.split(':')
			adr = int(addr,16)
			adr +=1
			print(f'data {adr:04X}')
#		if cmt == '':
#			print(f'{label:8}{mnemonic:6}{argument:35}; {lcmt}')
#			put_line(filename, f'{label:8}{mnemonic:6}{argument:35}; {lcmt}\n')
#		else:
#			print(f'{cmt}')
#			put_line(filename, f'{cmt}\n')

	exit()


if __name__ == '__main__':
	# Here we create the infofile with the usual entries and also
	# check for the disassembler f9dasm or dasmfw
	if len(sys.argv) < 2:
		print(f'{bcolors.FAIL}Please supply sourcefile as argument!{bcolors.ENDC}')
		exit()
	os.system('clear')
	print(f'Scriptversion: {ver}')
	sourcefile = sys.argv[1]
	if os.path.isfile(sourcefile) == False:
		print(f'{bcolors.FAIL}File {sourcefile} does not exist!{bcolors.ENDC}')
		exit()
	ext = sourcefile.split('.')[-1]
	filename = sourcefile.split('.')[0]
	if os.path.isfile(filename+".asm") == False:
		print(f'Disassembly not here. Run once...')
		exit()
	with open(filename+".asm", 'r') as fp:
		asmfile = fp.read().split("\n")
		fp.close()	
	main(asmfile)