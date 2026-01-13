#!/bin/bash


#Podanie lokalizacji pliku
echo "SPRAWDZANIE SUMY KONTROLNEJ"
echo "Podaj lokalizacje programu do sprawdzenia: "
read nazwa


#Wyszukanie programu w usr/bin i obliczenie sumy kontrolnej
sum=$(sha256sum $nazwa | awk '{print $1}')

#Podanie sumy do api i przekazaniae wyniku do pliku tesktowego
curl --request GET \
     --url https://www.virustotal.com/api/v3/files/$sum \
     --header 'accept: application/json' \
     --header 'x-apikey: ' >> ResultText.txt

#Pokazanie wyniku'
echo "Ten jest plik ma reputacje w skali 0-96: "
cat ResultText.txt | tr , "\n" | grep 'reputation'

#Czyszczenie pliku uzywajac /dev/null w celu posiadania czystego pliku na nastepy raz
cat /dev/null > ResultText.txt
