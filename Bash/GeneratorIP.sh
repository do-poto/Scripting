#!/bin/bash

#petla
for i in {0..9}
do
#losowanie liczby w zakresie
randomNbr=$(shuf -i 0-255 -n 1)

#drukowanie adresu
echo "192.168.1.$randomNbr"
done

