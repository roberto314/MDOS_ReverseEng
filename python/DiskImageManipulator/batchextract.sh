#!/bin/bash

prog="./ditool.py fdos extract "

for f in `find . -type f -name '*.DSK' -o -name '*.dsk'`
do
    echo "---------------- converting:                 "$f
    $prog ${f} " nowait"
done