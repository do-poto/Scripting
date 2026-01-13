#!/bin/bash

#przypisanie zmiennych
echo "Podaj nazwe uzytkownika: "
read obecny
flag=$(id $obecny | grep -q "sudo")

#warunki
if [[ $flag -eq 0 ]]
then
echo "$obecny"
echo "To jest konto admina"
else
echo "$obecny"
echo "To nie jest konto admina" 
fi

