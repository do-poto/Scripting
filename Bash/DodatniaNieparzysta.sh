#!/bin/bash

#input
echo "Sprawdz czy twoja liczba jest dodatnia i nieparzysta"
echo "Podaj liczbe: "
read input

#wyliczenie reszty
reszta=$(( $input % 2))

#warunki
if [[ $reszta -ne 0 && $input -gt 0 ]]
	then
		echo "Ta liczba jest dodatnia i nieparzysta"
	else
		echo "Ta liczba nie spelnia warunkow"
fi
