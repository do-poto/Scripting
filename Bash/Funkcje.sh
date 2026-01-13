#!/bin/bash

#deklaracja nazwy komputera
nazwaCmptr=$(hostname)

#funkcja podajaca aktualna date
function aktualnaData() {
data=$(date)
echo "Aktualna data na $1 to $data"
}

#funkcja podajaca aktualna wersje linuxa
function wersjaLinux() {
ver=$(grep -E "VERSION=" /etc/os-release )
echo "Aktualna wersja linux na $1 to $ver"
}

#funkcja podajaca aktualnego uzytkownika
function currUsr() {
usr=$(whoami)
echo "Aktualny użytkownik na $1 to $usr"
}

#funkcja podajaca adres ip
function ipAdr() {
IP=$(hostname -I)
echo "Aktualny adres IP na $1 to $IP"
}

#wywolanie funkcji
aktualnaData $nazwaCmptr
wersjaLinux $nazwaCmptr
currUsr $nazwaCmptr
ipAdr $nazwaCmptr
