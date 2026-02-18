#!/bin/bash
#
IP=192.168.2.253
USR=rob
FILE=$1

ssh ${USR}@${IP} 'sudo umount /piusb.bin; sudo mount -a'
scp ${USR}@${IP}:/mnt/usb_share/${FILE} .