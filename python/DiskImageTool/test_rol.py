#!/usr/bin/env python3

import sys



def as_rol(nr, carry):
    c = 0
    out = (nr << 1) | carry
    if out > 0xFF:
        c = 1
    return (out&0xFF),c
#----------------------------------
def as_ror(nr, carry):
    c = 0
    out = (nr >> 1) | carry << 7
    if nr & 1:
        c = 1
    return (out&0xFF),c
#----------------------------------
def main(number, carry):
	for i in range(9):
		number,carry = as_ror(number, carry)
		print(f' {carry} {number:08b} {number:02X}')

if __name__ == '__main__':
	number = int(sys.argv[1],0)
	carry = 0
	print(f'Got Number: {number:08b}')
	main(number, carry)
