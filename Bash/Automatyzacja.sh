#!/bin/bash

#Sprawdzanie aktualności systemu
function systemUTD(){
#Pokazuje obecna werjse
echo "Obecna wersja to: "
uname -a

#Instaluje aktualizacje
sudo apt-get update
}

#Instalacja aplikacji
function installApp(){
sudo apt install thunderbird
}

#Dodanie nowego użytkownika
function addNewUser(){
#Pyta o nazwe dla usytkownika
echo "Jak nazwac nowego uzytkownika?: "
read name

#Tworzy uzytkownika o danej nazwie
sudo useradd $name
sudo passwd $name
}

#Utworzenie katalogów dla użytkownka
function addCatalogs(){
#Prmopt dla uzytkownika
echo "Jakiemu uzytkownikowi stworzyc nowy home directory: "
read user

#Tworzenie katalogu dla uzytkownika
sudo mkhomedir_helper $user
}

#Informacje o systemie
function showSysInfo(){
#Ustalanie zmiennych
Version=$(uname -a | awk '{print $1,$2,$3}')
IPv4=$(ifconfig eth0 | awk '/inet / {print $2}')
MAC=$(ifconfig eth0 | awk '/ether / {print $2}')

#Zwrot informacji
echo "Obecna wersja systemu to: $Version"
echo "Obecny adres IPv4 to: $IPv4"
echo "Obecny adres MAC to: $MAC"

}

#Funkcja main
function main(){
#Wypisanie menu opcji dla tego skryptu"
echo "Dostepne funkcje to:"
echo "[1] Aktualizacja systemu"
echo "[2] Istalacja Thunderbird"
echo "[3] Dodaj uzytkownika"
echo "[4] Stworz katalogi dla uzytkownika"
echo "[5] Pokaz informacje o systemie"
echo "[q] Anuluj"

#deklaracja flagi
flag="yes"

#while loop dla menu w przypadku wybrania zlej opcji
while [ $flag == "yes" ]; 
do
#Wybierz opcje z menu 
echo "Wybierz opcje: "
read mycase

##########################################################################
#Wybor opcji z przewidzanych lub nie
#W przypadku znanej odpala skrypt i konczy loop
# W przypadku anulowania (opcja [q]) konczy loop i sygnalizuje to printem
#W przypadku nieznanej funkcji loop kontynuuje do podania znanego wejscia
##########################################################################
case $mycase in
1) systemUTD
 break;;
2) installApp
 break;;
3) addNewUser 
break;;
4) addCatalogs 
break;;
5) showSysInfo 
break;;
q) echo "Konczenie skryptu..." 
break;;
*) echo "Nieznana komenda";;
esac
done
}

#Odpalenie funkcji main
main

