#!/bin/bash

miejsce=$1

rok=$2

obecnyrok=$(date +"%Y")
wiek=$((obecnyrok-$rok))

echo "Twoje miejsce urodzenia to $miejsce" 
echo "Twoj wiek to $wiek"
