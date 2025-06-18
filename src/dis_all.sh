#!/bin/bash

../bin/dasmfw -dasm=6800 -info mdos.info > mdos.asm
../bin/dasmfw -dasm=6800 -info bootloader.info > bootloader.asm
../bin/dasmfw -dasm=6800 -info exbug11.info > exbug11.asm
../bin/dasmfw -dasm=6800 -info exbug12.info > exbug12.asm
../bin/dasmfw -dasm=6800 -info floppy.info > floppy.asm
../bin/dasmfw -dasm=6800 -info mdosov0.info > mdosov0.asm
../bin/dasmfw -dasm=6800 -info mdosov1.info > mdosov1.asm
../bin/dasmfw -dasm=6800 -info mdosov2.info > mdosov2.asm
../bin/dasmfw -dasm=6800 -info mdosov3.info > mdosov3.asm
../bin/dasmfw -dasm=6800 -info mdosov4.info > mdosov4.asm
../bin/dasmfw -dasm=6800 -info mdosov5.info > mdosov5.asm
../bin/dasmfw -dasm=6800 -info mdosov6.info > mdosov6.asm
../bin/dasmfw -dasm=6800 -info mdoser.info > mdoser.asm
