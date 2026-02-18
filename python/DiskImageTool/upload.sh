#!/bin/bash
#
IP=192.168.2.253
USR=rob
FILE=$1

scp ${FILE} ${USR}@${IP}:/mnt/usb_share 
ssh ${USR}@${IP} 'sudo umount /piusb.bin; sudo mount -a'