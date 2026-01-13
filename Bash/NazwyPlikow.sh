#!/bin/bash

#sprawdza czy istnieje
if [[ -e $1 ]]
then
echo "Ten plik istnieje"
else
echo "Ten plik nie istnieje"
fi
#sprawdza czy jest pusty
if ! [[ -s $1 ]]
then
echo "Ten plik jest pusty"
else
echo "Ten plik nie jest pusty"
fi
#sprawdza czy to dir
if [[ -d $1 ]]
then
echo "To jest katalogiem"
else
echo "To nie jest katalogiem"
fi

