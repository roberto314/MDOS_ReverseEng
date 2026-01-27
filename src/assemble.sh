#!/bin/bash
#

ASL=../bin/asl
A68=../bin/a68
AS0=../bin/as0
AS1=../bin/as1
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
## Use as0
#${AS0} ${NAME}.asm -L CRE C S > ${NAME}.lst 

NAME=floppy_commented
## Use asl
${ASL} -cpu ${CPU} -L ${NAME}.asm > out.txt
${P2B} ${NAME}.p ${NAME}_b.bin >> out.txt
rm ${NAME}.p
cat out.txt | grep rror   # Check for Errors
#######################################################################
NAME=floppy2_commented
## Use asl
${ASL} -cpu ${CPU} -L ${NAME}.asm > out.txt
${P2B} ${NAME}.p ${NAME}_b.bin >> out.txt
rm ${NAME}.p
cat out.txt | grep rror   # Check for Errors
#######################################################################
NAME=bootloader_commented
## Use asl
${ASL} -cpu ${CPU} -L ${NAME}.asm > out.txt
${P2B} ${NAME}.p ${NAME}_b.bin >> out.txt
rm ${NAME}.p
cat out.txt | grep rror   # Check for Errors
#######################################################################
NAME=exbug12_commented
## Use asl
${ASL} -cpu ${CPU} -L ${NAME}.asm > out.txt
${P2B} ${NAME}.p ${NAME}_b.bin >> out.txt
rm ${NAME}.p
cat out.txt | grep rror   # Check for Errors
#######################################################################
NAME=exbug11_commented
## Use asl
${ASL} -cpu ${CPU} -L ${NAME}.asm > out.txt
${P2B} ${NAME}.p ${NAME}_b.bin >> out.txt
rm ${NAME}.p
cat out.txt | grep rror   # Check for Errors
#######################################################################
NAME=mdoser_commented
## Use asl
${ASL} -cpu ${CPU} -L ${NAME}.asm > out.txt
${P2B} ${NAME}.p ${NAME}_b.bin >> out.txt
rm ${NAME}.p
cat out.txt | grep rror   # Check for Errors
#######################################################################
NAME=CIOEX
## Use asl
${ASL} -cpu ${CPU} -L ${NAME}.asm > out.txt
${P2B} ${NAME}.p ${NAME}_b.bin >> out.txt
rm ${NAME}.p
cat out.txt | grep rror   # Check for Errors
OFF=0x2000
srec_cat ${NAME}_b.bin -binary -offset ${OFF} -o ${NAME}.s19 -Motorola -address_length=2 #-execution-start-address=0x0100
echo S9 >> ${NAME}.s19
#######################################################################
NAME=format_commented
## Use asl
${ASL} -cpu ${CPU} -L ${NAME}.asm > out.txt
${P2B} ${NAME}.p ${NAME}_b.bin >> out.txt
rm ${NAME}.p
cat out.txt | grep rror   # Check for Errors
#######################################################################
NAME=dir_commented
## Use asl
${ASL} -cpu ${CPU} -L ${NAME}.asm > out.txt
${P2B} ${NAME}.p ${NAME}_b.bin >> out.txt
rm ${NAME}.p
cat out.txt | grep rror   # Check for Errors






#srec_cat ${NAME}.s19 -motorola -offset -${OFF} -o ${NAME}_b.bin -binary # strip off the beginning
#srec_cat ${NAME}.s19 -motorola -offset -${OFF} -fill 0xff 0x0000 0x37ff -o ${NAME}.bin -binary # strip off the beginning

#srec_cat ${NAME}.s199 -motorola -fill 0xff 0x0000 0x7fff -o ${NAME}.bin2 -binary # filled with FFs

#${ASS} ${NAME}.asm -l ${NAME}.lst -o ${NAME}.hex
#srec_cat ${NAME}.OBJ -intel -offset -0x2400 -fill 0xff 0x0000 0x100 -o ${NAME}.bin -binary # filled with FFs
#srec_cat ${NAME}.OBJ -intel -offset -0xA700 -o ${NAME}.bin -binary # 
#srec_cat ${NAME}.hex -intel -o ${NAME}.bin -binary # 

#rm ${NAME}.o
#srec_cat ${NAME}.bin -binary -offset 0x7800 -output ${NAME}.hex -Intel -address_length=2 

#cp -u ${NAME}.bin ../

#Compare
#xxd IMO100.bin > main.hex
#xxd main_reassembled.bin > main_reassembled.hex
#diff main.hex main_reassembled.hex

