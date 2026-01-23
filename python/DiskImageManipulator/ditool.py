#!/usr/bin/env python3
#
# ditool.py - The Disk Image Tool
# 2025, R. Offner
# Start it and look at the help message
# This script is mainly for very old and obscure images like FDOS, SDOS, MDOS, FLEX,...
#
# With this script one can:
# .) Handles a variety of Imageformats (with external Programs)
# .) Extract files from Image
# .) Show Directory
# .) Make Image from a directory of files
#
# Version History:
# v0.2: Framework should be finalised, 
#       FDOS works, 
#       MDOS only dir works
# v0.1: Nothing works
#
import shutil, shlex               # for checking if commands exist
from subprocess import Popen, PIPE # for checking if commands exist
import argparse                    # for argument parser
import os                          # for files handling
from pathlib import Path           # for Batchmode
#import re, sys, math, time
exorpath="/home/rob/Data/sync/Computer/CPU\ -\ MC6800/Exorciser/exorsim/"
ver = '0.2'

#print(f'{self.RED}{self.END}')
#print(f'{self.GRN}{self.END}')
#print(f'{self.YEL}{self.END}')
#print(f'{self.BLU}{self.END}')
#print(f'{self.PUR}{self.END}')
#print(f'{self.CYN}{self.END}')

class DITOOL():
    def __init__(self):
        self.RED = '\033[91m'    # red
        self.GRN = '\033[92m'    # green
        self.YEL = '\033[93m'    # yellow
        self.BLU = '\033[94m'    # dblue
        self.PUR = '\033[95m'    # purple
        self.CYN = '\033[96m'    # cyan
        self.END = '\033[0m'     # Back to Normal
        self.BLD = '\033[1m'     # Bold
        self.ULN = '\033[4m'     # Underline
        self.INV = '\033[107m'   # Inverse        
    #------------------------------------------
    def dump_text(self, data):
        print(f'{data}')
    #------------------------------------------
    def dump_data(self, data, width):
        idx = len(data)
        for w in range(width):
            print (f'{self.CYN}  {w:02} ', end = '')
        print(f'{self.END}')
        for i in range(0, len(data), width):
            #print(f'idx: {self.idx}')
            if idx < width:
                stop = idx
            else:
                stop = width
            for j in range(0,stop):
                print(f'{self.YEL}0x{data[i+j]:02X} ', end = '')
            idx -= width
            if (idx >= width):
                print(f'{self.END} - {(i+width):>2} ({(i+width):02X})\r')
            else:
                print(f'{self.END}')
            #print(f'{self.END}\r')
    #------------------------------------------
    def read_file(self, fn, type = 'binary'):
        if (type == 'binary'):
            try:
                with open(fn, "rb") as f:
                    #print(f'File: {fn} open as binary for reading.')
                    img = f.read()
                    f.close()
                    return img
            except Exception as e:
                print(f'File {fn} not found!')
                exit()
        else:
            try:
                with open(fn, "r") as f:
                    #print(f'File: {fn} open as text for reading.')
                    img = f.read()
                    f.close()
                    return img
            except Exception as e:
                print(f'File {fn} not found!')
                exit()
    #----------------------------------
    def write_file(self, data, fn, type = 'binary'):
        if (type == 'binary'):
            if fn == '':
                dump_data(data, 16)
                exit()
            else:
                with open(fn, "wb") as f:
                    #print(f'File: {fn} open as binary for writing.')
                    f.write(bytes(data))
                    f.close()
        else:
            if fn == '':
                dump_text(data)
                exit()
            else:
                with open(fn, "w") as f:
                    #print(f'File: {fn} open as text for writing.')
                    f.write(data)
                    f.close()
    #----------------------------------
    def get_exitcode_stdout_stderr(self, cmd):
        """
        Execute the external command and get its exitcode, stdout and stderr.
        """
        args = shlex.split(cmd)
    
        proc = Popen(args, stdout=PIPE, stderr=PIPE)
        out, err = proc.communicate()
        exitcode = proc.returncode
        #
        return exitcode, out, err
    
        #cmd = "..."  # arbitrary external command, e.g. "python mytest.py"
        #exitcode, out, err = get_exitcode_stdout_stderr(cmd)
    #----------------------------------
    def cleanup(self, name):
        cleanname = name.replace('/', '_')
        if "/" in name:
            print(f'Renamed {name} in {cleanname}!\n')
        return cleanname.strip()
    #----------------------------------
    def handle_fdos(self, imgfile, imgname, action, diskstruct, verbose):
        from fdos import class_FDOS
        obj = class_FDOS(self, diskstruct, verbose)
        pathname = imgname + '_FILES/'
    
        if (action == 'DIR'):
            obj.print_dir(imgfile)
    
        elif (action == 'EXTRACT'):
            print(f'Extracting Files.')
            entries, imgstat = obj.get_dir(imgfile)
            #print(entries)
            stats = obj.convert_stats(entries, imgstat)
            #print(stats)
            self.write_file(stats, pathname + 'stats', 'text')
            for e in entries:
                print(f'Extracting: {e[0]:2} ({e[4]:2} Sectors from Track {e[2]:2}, Sector {e[3]})')
                data = obj.get_file(imgfile, e)
                fn = pathname + self.cleanup(e[0])
                if fn == pathname:
                    print(f'{self.RED}Filename Empty!{self.END}')
                else:
                    self.write_file(data, fn, 'binary')
        elif (action == 'CREATEBOOT'):
            print(f'Creating Boot Image is no really necessary on FDOS.')
            print(f'Just put a file named $DOS in the FILES Directory and it will be the bootfile.')
            #imgfile = obj.add_files(pathname, obj.create_boot_image())
            #fn = imgname + '.img'
            #print(f'Bootable Image with {len(imgfile)} bytes and Name: {fn} created.')
            #self.write_file(imgfile, fn, 'binary')
        elif (action == 'CREATE'):
            print(f'Creating Image.')
            imgfile = obj.add_files(pathname, obj.create_image())
            fn = imgname + '.img'
            print(f'Image with {len(imgfile)} bytes and Name: {fn} created.')
            self.write_file(imgfile, fn, 'binary')
    #----------------------------------
    def handle_mdos(self, imgfile, imgname, action, diskstruct, verbose):
        from mdos import class_MDOS
        obj = class_MDOS(self, diskstruct, verbose)
        pathname = imgname + '_FILES/'
    
        if (action == 'DIR'):
            obj.print_dir(imgfile)
    
        elif (action == 'EXTRACT'):
            print(f'Extracting Files.')
            entries, imgstat = obj.get_dir(imgfile)
            #print(entries)
            stats = obj.convert_stats(entries, imgstat)
            #print(stats)
            self.write_file(stats, pathname + 'stats', 'text')
            for e in entries:
                print(f'Extracting: {e[0]:2} ({e[4]:2} Sectors from Track {e[2]:2}, Sector {e[3]})')
                data = obj.get_file(imgfile, e)
                fn = pathname + self.cleanup(e[0])
                if fn == pathname:
                    print(f'{self.RED}Filename Empty!{self.END}')
                else:
                    self.write_file(data, fn, 'binary')
        elif (action == 'CREATEBOOT'):
            print(f'Creating Boot Image is no really necessary on FDOS.')
            print(f'Just put a file named $DOS in the FILES Directory and it will be the bootfile.')
            #imgfile = obj.add_files(pathname, obj.create_boot_image())
            #fn = imgname + '.img'
            #print(f'Bootable Image with {len(imgfile)} bytes and Name: {fn} created.')
            #self.write_file(imgfile, fn, 'binary')
        elif (action == 'CREATE'):
            print(f'Creating Image.')
            imgfile = obj.add_files(pathname, obj.create_image())
            fn = imgname + '.img'
            print(f'Image with {len(imgfile)} bytes and Name: {fn} created.')
            self.write_file(imgfile, fn, 'binary')

    #----------------------------------
    def main (self, imgfile, imgname, variant, action, diskstruct, verbose):
        if (variant == 'FDOS'):
            formatspec = []
            formatspec.append(35)     # Tracks
            formatspec.append(1)      # Sides
            formatspec.append(10)     # Sectors
            formatspec.append(256)    # Byte/Sector
            formatspec.append(0x1400) # Start of Directory
            formatspec.append(0x1E00) # Start of Files
            formatspec.append(0x20)   # Size of one directory entry
            formatspec.append(0x0)    # Value for Empty Space
            if len(diskstruct) > 0:
                for idx, txt in enumerate(diskstruct):
                    formatspec[idx] = txt
                    #print(f'{txt=}')
            self.handle_fdos(imgfile, imgname, action, formatspec, verbose)
        elif (variant == 'MDOS'):
            formatspec = []
            formatspec.append(77)     # Tracks
            if (len(imgfile) > 256256):
                formatspec.append(2)      # Sides
            else:
                formatspec.append(1)      # Sides
            formatspec.append(26)     # Sectors
            formatspec.append(128)    # Byte/Sector
            formatspec.append(0x180)  # Start of Directory
            formatspec.append(0xB80)  # Start of Bootblock
            formatspec.append(0x10)   # Size of one directory entry
            formatspec.append(0x0)    # Value for Empty Space
            formatspec.append(2)      # Interleave
            if len(diskstruct) > 0:
                for idx, txt in enumerate(diskstruct):
                    formatspec[idx] = txt
                    #print(f'{txt=}')
            self.handle_mdos(imgfile, imgname, action, formatspec, verbose)
        else:
            print(f'Sorry, not implemented yet.')    
    #----------------------------------
    def print_fdos_examples(self):
        print(f' 1: Tracks,')
        print(f' 2: Sides,')
        print(f' 3: Sectors,')
        print(f' 4: Bytes/Sector,')
        print(f' 5: Start of Directory,')
        print(f' 6: Start of Files,')
        print(f' 7: Size of one directory entry,')
        print(f' 8: Value for Empty Space.')
        print(f'{self.END}')
    #----------------------------------
    def print_mdos_examples(self):
        print(f' 1: Tracks,')
        print(f' 2: Sides,')
        print(f' 3: Sectors,')
        print(f' 4: Bytes/Sector,')
        print(f' 5: Start of Directory,')
        print(f' 6: Start of Files,')
        print(f' 7: Size of one directory entry,')
        print(f' 8: Value for Empty Space,')
        print(f' 9: Interleave.')
        print(f'{self.END}')
    #----------------------------------
    def print_cp68_examples(self):
        print(f' 1: ,')
        print(f' 2: ,')
        print(f' 3: ,')
        print(f' 4: ,')
        print(f' 5: ,')
        print(f' 6: ,')
        print(f' 7: ,')
        print(f' 8: .')
        print(f'{self.END}')
    #----------------------------------
    def print_examples(self):
        print(f'{self.YEL}')
        print(f'ditool.py - the Disk Image Tool')
        print(f'Examples:')    
        print(f' ditool.py fdos dir IMAGE - shows files from fdos IMAGE.')
        print(f' ditool.py fdos create IMAGE - builds an imagefile with files from directory named as IMAGE_FILES.')
        print(f' ditool.py fdos -format 11,22,33,44 -nowait create IMAGE - ')
        print(f'    builds an imagefile with alternate format definition and don\'t wait for user input.')
        print(f' The format numbers are comma-separated and can be decimal (nn) or hex (0xnn).')
        print(f' The format definition is filesystem specific, but begins with:')
        if args.type == 'fdos':
            self.print_fdos_examples()
        elif args.type == 'mdos':
            self.print_mdos_examples()
        else:
            print(f'{self.RED}Add Examples!{self.END}')
        exit()
#----------------------------------
if __name__ == '__main__':
    me = DITOOL()
    parser = argparse.ArgumentParser(description = f'{me.GRN}ditool.py - the Disk Image Tool. '
        + ' Version: ' + str(ver))
    parser.add_argument('-v', '--verbose', action = 'count', default = 0, help = 'increase logging level')
    parser.add_argument('-format', help='alternate format definition (comma-separated, no spaces)')
    parser.add_argument('-nowait', action='store_true', help='don\'t wait for user inpt.')
    parser.add_argument('-overwrite', action='store_true', help='overwrite existing image.')
    parser.add_argument('-convert', action='store_true', help='only convert .imd or .hfe image to .img.')
    parser.add_argument('-batchmode', action='store_true', help='convert all files with name .imd or .hfe to .img.')
    parser.add_argument('-simulate', action='store_true', help='start exorsim afterwards.')
    parser.add_argument('type', choices=['fdos','mdos','xdos','cp68'], help='Which Filesystem to use.')
    #parser.add_argument('type', choices=['example','fdos','cp68'], help='Which Filesystem to use.')
    #parser.add_argument('action', choices=['create','createboot','dir','extract'], help='Which action to take.')
    subparsers = parser.add_subparsers(dest='action')
    #---------------------------------------------------------------------------------    
    subparser = subparsers.add_parser('create', help='Create an Imagefile')
    subparser.add_argument('file', help='imgfile')
    subparser = subparsers.add_parser('createboot', help='Create a bootable Imagefile')
    subparser.add_argument('file', help='imgfile')
    subparser = subparsers.add_parser('dir', help='Show directory of Imagefile')
    subparser.add_argument('file', help='imgfile')
    subparser = subparsers.add_parser('extract', help='Extract files from Imagefile')
    subparser.add_argument('file', help='imgfile')
    subparser = subparsers.add_parser('example', help='Show Examples for Filetype.')
    #---------------------------------------------------------------------------------    
    args = parser.parse_args()
    #if args.type == 'example':
    #    print_fdos_examples()
    if args.action == None:
        print(f'{me.RED}An action is needed!{me.END}')
        exit()
    if args.action == 'example':
        me.print_examples()

    HXCFE = './hxcfe'  # Check if hxcfe exists and is functional
    if shutil.which(HXCFE) == None:
        print(f'{me.RED}{HXCFE} does not exist in this directory!{me.END}')
        exit()
    cmd = "./hxcfe -license"
    exitcode, out, err = me.get_exitcode_stdout_stderr(cmd)
    if exitcode != 0:
        print(f'{me.RED}Error in hxcfe!{me.END}')
        print(f'Exitcode: {exitcode}')
        print(f'Error: {self.err}')
        exit()
    text = out.decode()
    lines = text.split('\n') # one line per track and side
    print(f'{lines[0]}') # Version Number of Floppy image file converter
    print(f'{lines[6]}') # Version Number of libhxcfe
    #-------------------------------
    variant = args.type.upper()
    action = args.action.upper()
    nowait = args.nowait
    overwrite = args.overwrite
    #-------------------------------
    input_files = []
    rootdir = os.getcwd()
    if args.batchmode == True:
        print(f'Looks like you want Batchmode for files ending in {args.file}.')
        extension = args.file
        #print(f'{extension=}')
        for path in Path(rootdir).glob('*.' + extension):
            print("Found: " + str(path))
            input_files.append(str(path))
    else:
        input_file = args.file
        # Check if Imagefile exists
        if ((os.path.isfile(args.file) != True) and ('create' not in args.action)):
            print(f'{me.RED}Image {args.file} not found!{me.END}')
            exit()
        input_files.append(str(os.path.join(rootdir, args.file)))

    for input_file in input_files:
        print(f'{input_file=}')

        #exit()
        diskformat = []
        disk = []
        if args.format != None:
            diskformat = args.format.split(',')
            for idx,val in enumerate(diskformat):
                disk.append(int(diskformat[idx],0))
    
        print(f'{me.YEL}Gettting to work.{me.END}')
        print(f'{me.CYN}Variant: {variant}{me.END}')
        print(f'{me.CYN}Action: {action}{me.END}')
        print(f'{me.CYN}Filename: {input_file}{me.END}')
        print(f'{me.CYN}Format: {disk}{me.END}')
        print(f'{me.CYN}Overwrite: {overwrite}{me.END}')
        if nowait == False:
            input("Press any key to continue.") # Wait for User to read everything 
        os.system('clear')
        #-------------------------------
        fn,ext = os.path.splitext(input_file)
        DIRNAM = fn + '_FILES'
        MKDIRCMD = 'mkdir ' + DIRNAM
        RMDIRCMD = 'rm -r ' + DIRNAM
        if ('CREATE' in action): # Making Directory for CREATE images files
            if (os.path.isdir(DIRNAM) == False):
                print(f'{me.YEL}Directory: {DIRNAM} does not exist - creating it.{me.END}')
                os.system(MKDIRCMD)
                print(f'{me.YEL}You probably want some files there too!.{me.END}')
                #exit()
        if (action == 'EXTRACT'): # Creating Directory for EXTRACT images
            if (os.path.isdir(DIRNAM) == False):
                print(f'{me.YEL}Directory: {DIRNAM} does not exist - creating it.{me.END}')
                os.system(MKDIRCMD)
                print(f'{me.YEL}You will find the files there!.{me.END}')
            if ((os.path.isdir(DIRNAM) == True) and (len(os.listdir(DIRNAM)) != 0)):
                print(f'{me.RED}Directory: {DIRNAM} does exist but is NOT empty - Deleting it.{me.END}')
                os.system(RMDIRCMD)
                os.system(MKDIRCMD)
        #------------------------------------------------------------
        # Converting non-straight binary Images.
        #------------------------------------------------------------
        if (ext.upper() == '.HFE'):
            print(f'{me.YEL}HFE Image found, converting to .img.{me.END}')
            img_file = fn + "_DITOOL.img"
            #------------------------------------------------------------
            # here we call the external program hxcfe to convert the image
            #------------------------------------------------------------
            #cmd = "./hxcfe -finput:" + input_file + " -foutput:" + img_file + " -conv:RAW_LOADER"
            #cmd = "./hxcfe -finput:\""+input_file+"\" -foutput:\""+img_file+"\" -conv:RAW_LOADER"
            cmd = f'./hxcfe -finput:+input_file+" -foutput:"{img_file}" -conv:RAW_LOADER'

            exitcode, out, err = me.get_exitcode_stdout_stderr(cmd)
            if exitcode != 0:
                print(f'{me.RED}Error in hxcfe!{me.END}')
                print(f'Exitcode: {exitcode}')
                print(f'Error: {self.err}')
                exit()
            text = out.decode('ascii')
            #lines = text.split('\n') # one line per track and side
            print(text)
            print(f'{me.CYN}Output File is: {img_file}{me.END}')
            if ('CREATE' in action):
                print(f'Create a .hfe Image is not supported!')
                exit()
            input_file = img_file # New file is now input
        elif (ext.upper() == '.IMD'):
            print(f'{me.YEL}Imagedisk File found, converting to .img.{me.END}')
            img_file = fn + "_DITOOL.img"
            #------------------------------------------------------------
            # here we call the external program hxcfe to convert the image
            #------------------------------------------------------------
            #cmd = "./hxcfe -finput:" + input_file + " -foutput:" + img_file + " -conv:RAW_LOADER"
            #cmd = "./hxcfe -finput:\""+input_file+"\" -foutput:\""+img_file+"\" -conv:RAW_LOADER"
            cmd = f'./hxcfe -finput:"{input_file}" -foutput:"{img_file}" -conv:RAW_LOADER'

            exitcode, out, err = me.get_exitcode_stdout_stderr(cmd)
            if exitcode != 0:
                print(f'{me.RED}Error in hxcfe!{me.END}')
                print(f'Exitcode: {exitcode}')
                print(f'Error: {self.err}')
                exit()
            text = out.decode('ascii')
            #lines = text.split('\n') # one line per track and side
            print(text)
            print(f'{me.CYN}Output File is: {img_file}{me.END}')
            if ('CREATE' in action):
                print(f'Create a .imd Image is not supported!')
                exit()
            input_file = img_file # New file is now input
        else:              # Normal binary Image
            print(f'{me.YEL}Assuming {input_file} is a straight binary Image.{me.END}')
        
        if ('CREATE' in action):
            f = []
        else:
            f = me.read_file(input_file, 'binary')
        
        #print(f'{args=}')
        if args.convert != True: # Convert to .img and process further
            me.main(f, fn, variant, action, disk, args.verbose)
        if args.simulate == True:
            print(f'Start exorsim.')
            if args.type == 'fdos':
                os.system(exorpath+'exor --swtpc --exbug '+exorpath+'swtbug.bin -x --facts '+exorpath+'facts -0 '+input_file)
            elif args.type == 'mdos':
                os.system(exorpath+'exor --exbug '+exorpath+'exbug.bin --facts '+exorpath+'facts')
