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
# v0.3: Framework cleanup and use of dictionaries
# v0.2: Framework should be finalised, 
#       FDOS works, 
#       MDOS only dir works
# v0.1: Nothing works
#
import shutil, shlex               # for checking if commands exist
from subprocess import Popen, PIPE # for checking if commands exist
import argparse                    # for argument parser
import os,sys                      # for files handling
from pathlib import Path           # for Batchmode
import json                        # saving stats and entries in file

#import re, sys, math, time
exorpath="/home/rob/Data/sync/Computer/CPU\ -\ MC6800/Exorciser/exorsim/"
ver = '0.3'

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
        print(f'') # Print a newline before
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
                print(f'Binary file {fn} not found!')
                return []
                #exit()
        else:
            try:
                with open(fn, "r") as f:
                    #print(f'File: {fn} open as text for reading.')
                    img = f.read()
                    f.close()
                    return img
            except Exception as e:
                print(f'Textfile {fn} not found!')
                return []
                #exit()
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
            print(f'{self.RED}Renamed {name} in {cleanname}!{self.END}')
            #print(f'Renamed {name} in {cleanname}!')
        return cleanname.strip()
    #----------------------------------
    def check_alternate_format(self, fspec):
        # Do we have alternative values?
        formatspec = []
        if len(formatdef) > 0:
            for k,v in formatdef.items():
                print(f'{me.CYN}Changing {k} to {v}{me.END}')
                if k in fspec.keys():
                    fspec[k] = v
        # Calculated Values
        fspec["Total Sectors"] = fspec["Sectors"] * fspec["Sides"] * fspec["Tracks"]
        fspec["Imagesize"] = fspec["Total Sectors"] * fspec["bps"] # Size is usually 89600 Bytes SSSD (FM)

        return fspec
    #----------------------------------
    def handle_action(self, obj, imgfile, imgname, action, fspec, verbose):
        pathname = imgname + '_FILES/'
        if (action == 'DIR'):
            entries, stats = obj.get_dir(imgfile)
            obj.print_dir(entries, stats)
    
        elif (action == 'EXTRACT'):
            entries, stats = obj.get_dir(imgfile)
            with open(pathname + 'entries.json', 'w') as file:
                file.write(json.dumps(entries, indent=2))
            with open(pathname + 'stats.json', 'w') as file:
                file.write(json.dumps(stats, indent=2))

            for idx,e in enumerate(entries):
                data = obj.get_file(imgfile, e)
                try:
                    fn = self.cleanup(e["Name"][1]) + '.' + self.cleanup(e["Suffix"][1])
                except:
                    fn = self.cleanup(e["Name"][1])
                if fn == '':
                    print(f'{self.RED}Filename Empty!{self.END}')
                else:
                    if verbose > 0:
                        print(f'Extracting file: {fn}')
                    self.write_file(data, pathname+fn, 'binary')

        elif ('CREATE' in action):
            try:
                with open(pathname + 'stats.json') as fp:
                    stats = json.load(fp)
                
            except OSError:
                print(f'No stats file found! Not really needed.')
                stats = {}

            try:
                with open(pathname + 'entries.json') as fp:
                    entries = json.load(fp)
                if entries == {}:
                    print(f'Error: entries file is empty!')
                    exit()

            except OSError:
                if action == 'CREATEENTRIES':
                    print(f'Creating an entries file.')
                    entries = obj.create_entries_file(pathname)
                    with open(pathname + 'entries.json', 'w') as file:
                        file.write(json.dumps(entries, indent=2))
                    print(f'{self.RED}Don\'t forget to manually edit entries.json!{self.END}')
                    exit()
                else:
                    print(f'No entries file found! Making empty image')
                    imgfile = obj.create_image(stats, "virgin")
            else:
                imgfile = obj.add_files(pathname, entries, stats, obj.create_image(stats, "normal"), action)
            
            fn = imgname + '.img'
            print(f'Image with {len(imgfile)} bytes and Name: {fn} created.')
            self.write_file(imgfile, fn, 'binary')

        #elif (action == 'MODIFYENTRIES'):
        #    try:
        #        with open(pathname + 'entries.pkl', 'rb') as fp:
        #            entries = pickle.load(fp)
        #            if entries == {}:
        #                print(f'Error: entries file is empty!')
        #                exit()
        #            else:
        #                entries = obj.modify_entries_file(entries)
        #                with open(pathname + 'entries.pkl', 'wb') as fp:
        #                    pickle.dump(entries, fp)
        #                exit()
        #    except OSError:
        #        print(f'No entries file found! Exiting.')
        #        exit()

        elif (action == 'EXAMPLE'):
            self.print_examples()
            obj.print_examples()
    #----------------------------------
    def check_hxcfe(self):
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
    #----------------------------------
    def main (self, imgfile, imgname, variant, action, formatdef, verbose):
        fspec = {}

        if (variant == 'FDOS'):
            # We have some standard Values
            fspec["Tracks"] = 35 
            fspec["Sides"] = 1
            fspec["Sectors"] = 10
            fspec["bps"] = 256
            fspec["Dirstart"] = 0x1400
            fspec["Filestart"] = 0x1E00
            fspec["Direntrysize"] = 0x20
            fspec["Emptyval"] = 0xE5
            fspec = me.check_alternate_format(fspec)
            from fdos import class_FDOS
            obj = class_FDOS(self, fspec, verbose)
            self.handle_action(obj, imgfile, imgname, action, fspec, verbose)

        elif (variant == 'MDOS'):
            fspec["Tracks"] = 77
            #if (len(imgfile) > 256256):
            #    fspec["Sides"] = 1
            #else:
            #    fspec["Sides"] = 2
            fspec["Sides"] = 1
            fspec["Sectors"] = 26
            fspec["bps"] = 128
            fspec["Dirstart"] = 0x180
            fspec["Filestart"] = 0xB80
            fspec["Direntrysize"] = 0x10
            fspec["Emptyval"] = 0xE5
            #fspec["DiskID"] = "MASTEREU"
            #fspec["Version"] = "03"
            #fspec["Revision"] = "00"
            #fspec["Date"] = "010479"
            #fspec["UserName"] = "RASM ASM EDIT RLOAD"
            
            fspec["DiskID"] = "SYSTEM"
            fspec["Version"] = " 3"
            fspec["Revision"] = "05"
            fspec["Date"] = "010101"
            fspec["UserName"] = "SYSTEM"
            fspec = me.check_alternate_format(fspec)
            from mdos import class_MDOS
            obj = class_MDOS(self, fspec, verbose)
            self.handle_action(obj, imgfile, imgname, action, fspec, verbose)

        else:
            print(f'Sorry, not implemented yet.')    

    #----------------------------------
    def print_examples(self):
        print(f'{self.YEL}')
        print(f'ditool.py - the Disk Image Tool')
        print(f'Examples:')    
        print(f' ditool.py fdos dir IMAGE - shows files from fdos IMAGE.')
        print(f' ditool.py fdos create IMAGE - builds an imagefile with files from directory named as IMAGE_FILES.')
        print(f' ditool.py fdos -format Sides=2,Sectors=12 -nowait create IMAGE - ')
        print(f'    builds an imagefile with alternate format definition and don\'t wait for user input.')
        print(f' The format values are comma-separated key=value pairs and can be decimal (nn) or hex (0xnn).')
        print(f' The format definition is filesystem specific, but begins with:')
#----------------------------------
if __name__ == '__main__':
    me = DITOOL()
    parser = argparse.ArgumentParser(description = f'{me.GRN}ditool.py - the Disk Image Tool. '
        + ' Version: ' + str(ver))
    parser.add_argument('-v', '--verbose', action = 'count', default = 0, help = 'increase logging level')
    parser.add_argument('-format', help='alternate format definition (comma-separated key=value pair, no spaces)')
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
    subparser = subparsers.add_parser('createentries', help='Create an entries file with information on the files to add.')
    subparser.add_argument('file', help='imgfile')
    #subparser = subparsers.add_parser('modifyentries', help='Modify an entries file.')
    #subparser.add_argument('file', help='imgfile')
    subparser = subparsers.add_parser('createboot', help='Create a bootable Imagefile.')
    subparser.add_argument('file', help='imgfile')
    subparser = subparsers.add_parser('dir', help='Show directory of Imagefile.')
    subparser.add_argument('file', help='imgfile')
    subparser = subparsers.add_parser('extract', help='Extract files from Imagefile.')
    subparser.add_argument('file', help='imgfile')
    subparser = subparsers.add_parser('example', help='Show Examples for Filetype.')
    #---------------------------------------------------------------------------------    
    args = parser.parse_args()
    #if args.type == 'example':
    #    print_fdos_examples()
    if args.action == None:
        print(f'{me.RED}An action is needed!{me.END}')
        exit()
    #if args.action == 'example':
    #    me.print_examples()
    
    #-------------------------------
    variant = args.type.upper()
    action = args.action.upper()
    nowait = args.nowait
    overwrite = args.overwrite
    df = []
    formatdef = {}
    if args.format != None:
        df = args.format.split(',')
        for idx,pair in enumerate(df):
            key,vl = pair.split('=')
            try:
                val = int(vl,0)
            except:
                val = vl
            #print(f'{idx} {pair} {key} {val}')
            formatdef[key] = val
            #formatdef.append(int(df[idx],0))
    #for k,v in formatdef.items():
    #    print(f' {k} {v}')
   
    #-------------------------------
    input_files = []
    rootdir = os.getcwd()
    if action == 'EXAMPLE':
        me.main([], '', variant, action, formatdef, args.verbose)
        pass
    else:
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
            if ((os.path.isfile(args.file) != True) and (('CREATE' not in action) and 'MODIFY' not in action)):
                print(f'{me.RED}Image {args.file} not found!{me.END}')
                exit()
            input_files.append(str(os.path.join(rootdir, args.file)))
    
        for input_file in input_files:
            print(f'{input_file=}')
            print(f'{me.YEL}Gettting to work.{me.END}')
            print(f'{me.CYN}Variant: {variant}{me.END}')
            print(f'{me.CYN}Action: {action}{me.END}')
            print(f'{me.CYN}Filename: {input_file}{me.END}')
            print(f'{me.CYN}Format: {formatdef}{me.END}')
            print(f'{me.CYN}Overwrite: {overwrite}{me.END}')
            if nowait == False:
                input("Press any key to continue.") # Wait for User to read everything 
            #os.system('clear')
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
                else:
                    print(f'{me.YEL}Looking for files in: {DIRNAM}.{me.END}')
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
                me.check_hxcfe()
                print(f'{me.YEL}HFE Image found, converting to .img.{me.END}')
                img_file = fn + "_DITOOL.img"
                #------------------------------------------------------------
                # here we call the external program hxcfe to convert the image
                #------------------------------------------------------------
                cmd = f'./hxcfe -finput:"{input_file}" -foutput:"{img_file}" -conv:RAW_LOADER'
    
                exitcode, out, err = me.get_exitcode_stdout_stderr(cmd)
                if exitcode != 0:
                    print(f'{me.RED}Error in hxcfe!{me.END}')
                    print(f'Exitcode: {exitcode}')
                    print(f'Error: {self.err}')
                    exit()
                text = out.decode('ascii')
                print(text)
                print(f'{me.CYN}Output File is: {img_file}{me.END}')
                if ('CREATE' in action):
                    print(f'Create a .hfe Image is not supported!')
                    exit()
                input_file = img_file # New file is now input
            elif (ext.upper() == '.IMD'):
                me.check_hxcfe()
                print(f'{me.YEL}Imagedisk File found, converting to .img.{me.END}')
                img_file = fn + "_DITOOL.img"
                #------------------------------------------------------------
                # here we call the external program hxcfe to convert the image
                #------------------------------------------------------------
                cmd = f'./hxcfe -finput:"{input_file}" -foutput:"{img_file}" -conv:RAW_LOADER'
    
                exitcode, out, err = me.get_exitcode_stdout_stderr(cmd)
                if exitcode != 0:
                    print(f'{me.RED}Error in hxcfe!{me.END}')
                    print(f'Exitcode: {exitcode}')
                    print(f'Error: {self.err}')
                    exit()
                text = out.decode('ascii')
                print(text)
                print(f'{me.CYN}Output File is: {img_file}{me.END}')
                if ('CREATE' in action):
                    print(f'Create a .imd Image is not supported!')
                    exit()
                input_file = img_file # New file is now input
            else:              # Normal binary Image
                print(f'{me.YEL}Assuming {input_file} is a straight binary Image.{me.END}')
            
            if 'CREATE' in action or 'MODIFY' in action:
                f = []
            else:
                f = me.read_file(input_file, 'binary')
            
            if args.convert != True: # Convert to .img and process further
                me.main(f, fn, variant, action, formatdef, args.verbose)
        if args.simulate == True:
            print(f'Start exorsim.')
            if args.type == 'fdos':
                os.system(exorpath+'exor --swtpc --exbug '+exorpath+'swtbug.bin -x --facts '+exorpath+'facts -0 '+input_file)
            elif args.type == 'mdos':
                os.system(exorpath+'exor --exbug '+exorpath+'exbug.bin --facts '+exorpath+'facts')
