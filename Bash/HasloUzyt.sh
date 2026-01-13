#!/bin/bash

#deklaracja nazwy i hasla
echo "Utworz nazwe uzytkownika: "
read uzytkownik

echo "Utworz haslo: "
read haslo

#deklaracja flagi
flag=0

#poczatek loopa
while [ $flag -eq 0 ]
do
#info + pobranie nazwy
echo "Logowanie"
echo "Podaj nazwe uzytkownika: "
read temp1
	#chekpoint nazwy
	if [[ $uzytkownik == $temp1 ]]
	then
		#pomyslna nazwa + poczatek pobioru hasla
		echo "Podaj haslo: "
		read temp2
		#checkpoint hasla
		if [[ $haslo == $temp2 ]]
		then
			#pomyslne haslo
			echo "Udalo sie zalogowac!"
			#zmiana flagi do loopa
			flag=$(($flag + 1)) 
		fi
	else
		#nieudany komunikat -> dalszy loop
		echo "Logowanie nieudane. Sproboj jeszcze raz"
	fi
done
