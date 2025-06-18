#!/bin/bash
#

ASS=../bin/asl
P2B=../bin/p2bin
CPU=6800
#DIR="/home/rob/Projects/mc-6502_mini/"
PWD=`pwd`
#echo $PWD
#######################################################################
#
# Assemble everything here and convert it to binary and s19
#
#######################################################################
NAME=boot # BOOT is not needed since SWTBUG takes care of that (with the "D" command for Sector 0)
OFF=0x100
${ASS} -cpu ${CPU} -L ${NAME}.asm > out.txt
${P2B} ${NAME}.p ${NAME}.bin >> out.txt
rm ${NAME}.p
srec_cat ${NAME}.bin -binary -offset ${OFF} -o ${NAME}.s19 -Motorola -address_length=2 #-execution-start-address=0x0100
echo S9 >> ${NAME}.s19

NAME=fdos
OFF=0x2400
${ASS} -cpu ${CPU} -L ${NAME}.asm >> out.txt
${P2B} ${NAME}.p >> out.txt
rm ${NAME}.p
srec_cat ${NAME}.bin -binary -offset ${OFF} -o ${NAME}.s19 -Motorola -address_length=2 #-execution-start-address=0x0100
echo S9 >> ${NAME}.s19

NAME=swtpio
OFF=0x2600
${ASS} -cpu ${CPU} -L ${NAME}.asm >> out.txt
${P2B} ${NAME}.p >> out.txt
rm ${NAME}.p
srec_cat ${NAME}.bin -binary -offset ${OFF} -o ${NAME}.s19 -Motorola -address_length=2 #-execution-start-address=0x0100
echo S9 >> ${NAME}.s19

cat out.txt | grep errors   # Check for Errors
#######################################################################
#
# Make a configuration for Flashfloppy and an Imagefile
#
#######################################################################

# Disk Geometry for FDOS (pretty straightforward)
DISKNAME=FDOSMPS.dsk
SIDES=1
TRACKS=35
SECLEN=256
SECTORS=10
SIZE=$((SECTORS*SECLEN*TRACKS*SIDES))
echo Disk Size is: $SIZE Bytes
#echo One Track is: $((SECLEN*SECTORS)) Bytes
printf "Track one starts @ %#X\n" $((SECLEN*SECTORS))
dd if=/dev/zero of=$DISKNAME bs=1 count=$SIZE > /dev/null 2>&1
#</dev/zero head -c $SIZE | tr '\0' '\345' > $DISKNAME # Make a file wit 0xE5
# Mage configfile for Gotek
cat <<EOF > IMG.cfg
# FDOS Disk
[::$SIZE] 
cyls = $TRACKS 
heads = $SIDES
bps = $SECLEN
iam = no
secs = $SECTORS
mode = fm
rate = 125
rpm = 300
tracks = 0-34
  h = 0
  id = 0
EOF
# Unused Parameters
#interleave = 1

#Combine binary to disk image

# SWTPIO starts @ 0 on disk image
dd conv=notrunc bs=1 if=swtpio.bin of=$DISKNAME seek=0 > /dev/null 2>&1
# FDOS starts @ 200
dd conv=notrunc bs=1 if=fdos.bin of=$DISKNAME seek=$((0x200)) > /dev/null 2>&1

dd if=$DISKNAME of=\$DOS bs=1 count=$((0x1400)) > /dev/null 2>&1
srec_cat \$DOS -binary -offset $((0xA100)) -o DOS.S19 -Motorola -address_length=2 #-execution-start-address=0x0100
echo S9 >> DOS.S19

# Patch disk image
#echo "<0x20:0x11>" | xxd -r | dd of=test.bin bs=1 count=2 conv=notrunc seek=$((0x20))
# Patch the Directory
# Name and Password
echo "<0x24:0x44:0x4F:0x53:0x20:0x20:0x20:0x20:0x20:0x20:0x20:0x20:0x20:0x20:0x20:0x20>" | xxd -r | dd of=$DISKNAME bs=1 count=16 conv=notrunc seek=$((0x1400)) > /dev/null 2>&1
#     1.Tr |1.Sec|Sectors |Type|LoadAddr | EndAddr |StartAddr|?????????|-----spare----
echo "<0x00:0x00:0x00:0x14:0x00:0xA1:0x00:0xAC:0xFF:0xA3:0x00:0x00:0x00:0x99:0xBD:0x42>" | xxd -r | dd of=$DISKNAME bs=1 count=16 conv=notrunc seek=$((0x1410)) > /dev/null 2>&1
#echo "<0x00:0x00:0x00:0x14:0x00:0x24:0x00:0x2F:0xFF:0x26:0x00:0x38:0x24:0x99:0xBD:0x42>" | xxd -r | dd of=$DISKNAME bs=1 count=16 conv=notrunc seek=$((0x1410)) > /dev/null 2>&1
# Signal End of Directory
echo "<0xFF>" | xxd -r | dd of=$DISKNAME bs=1 count=1 conv=notrunc seek=$((0x1420)) > /dev/null 2>&1
# Next Free Track 3
echo "<0x03>" | xxd -r | dd of=$DISKNAME bs=1 count=1 conv=notrunc seek=$((0x1430)) > /dev/null 2>&1
# Next Free Sector 0
echo "<0x00>" | xxd -r | dd of=$DISKNAME bs=1 count=1 conv=notrunc seek=$((0x1431)) > /dev/null 2>&1
# Remaining Free Sectors (35-3)*10 = 320 = 0x140
echo "<0x01:0x40>" | xxd -r | dd of=$DISKNAME bs=1 count=2 conv=notrunc seek=$((0x1432)) > /dev/null 2>&1

# Must be zero!
#echo "<0x00:0x00:0x00:0x00:0x00:0x00:0x00:0x00>" | xxd -r | dd of=$DISKNAME bs=1 count=16 conv=notrunc seek=$((0x1F8))







#srec_cat ${NAME}.s199 -motorola -fill 0xff 0x0000 0x7fff -o ${NAME}.bin2 -binary # filled with FFs

#${ASS} ${NAME}.asm -l ${NAME}.lst -o ${NAME}.hex
#srec_cat ${NAME}.OBJ -intel -offset -0x2400 -fill 0xff 0x0000 0x100 -o ${NAME}.bin -binary # filled with FFs
#srec_cat ${NAME}.OBJ -intel -offset -0xA700 -o ${NAME}.bin -binary # 
#srec_cat ${NAME}.hex -intel -o ${NAME}.bin -binary # 

#rm ${NAME}.o
#srec_cat ${NAME}.bin -binary -offset 0x7800 -output ${NAME}.hex -Intel -address_length=2 
#srec_cat ${NAME}.s199 -motorola -offset -0x4800 -fill 0xff 0x0000 0x37ff -o ${NAME}.bin -binary # strip off the beginning

#cp -u ${NAME}.bin ../

#Compare
#xxd IMO100.bin > main.hex
#xxd main_reassembled.bin > main_reassembled.hex
#diff main.hex main_reassembled.hex

