#!/bin/bash
# Opción 6: Mostrar los meses del año ingresados(formato calendario)
. ./funciones.sh

clear
mostrar_encabezado
echo "Ingrese el o los meses que desea ver (1-12), separados por espacio:"
read meses
echo "Ingrese el año de esos meses:"
read year

error=0
for mes in $meses
do
	if echo "$mes" | grep -q "^[1-9]$" || echo "$mes" | grep -q "^1[0-2]$"
	then
		cal "$mes" "$year"
		registrar_log "6" "cal $mes $year"
	else
		error_rojo "El mes $mes no es válido. Debe estar entre 1 y 12."
		error=1
	fi
done

if test "$error" = 1
then
	registrar_log "6" "cal (mes inválido)"
fi
mostrar_pie
pausar
