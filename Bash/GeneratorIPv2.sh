#!/bin/bash

#deklaracja flagi
flag=0

#petla
while [ $flag -lt 10 ]
do
#losowa liczba z zakresu
random=$(shuf -i 0-255 -n 1)

echo "192.168.1.$random"

#iteracja flagi
flag=$(( $flag + 1 ))
done
