#!/bin/bash
# Opción 5: Mostrar fecha y/o hora del sistema operativo
. ./funciones.sh

num=1
while test "$num" == 1
do
	clear
	mostrar_encabezado
	echo "---------------------------------------------"
	echo " Fecha y/o hora del sistema"
	echo "---------------------------------------------"
	echo "a) año/mes/día"
	echo "b) Hoy es día de mes del año"
	echo "c) Días transcurridos desde el comienzo del año"
	echo "d) Hora actual"
	echo "0) Volver al menú principal"
	echo "---------------------------------------------"
	mostrar_pie
	read opcion
	case $opcion in
		a)
			date +%Y/%m/%d
			registrar_log "5a" "date +%Y/%m/%d"
			pausar;;
		b)
			mesn=`date +%m`
			case $mesn in
				01) mesnom="enero";;
				02) mesnom="febrero";;
				03) mesnom="marzo";;
				04) mesnom="abril";;
				05) mesnom="mayo";;
				06) mesnom="junio";;
				07) mesnom="julio";;
				08) mesnom="agosto";;
				09) mesnom="septiembre";;
				10) mesnom="octubre";;
				11) mesnom="noviembre";;
				12) mesnom="diciembre";;
			esac
			echo "Hoy es $(date +%d) de $mesnom del año $(date +%Y)"
			registrar_log "5b" "date formato texto"
			pausar;;
		c)
			echo "Han pasado $(date +%j) días desde el comienzo del año"
			registrar_log "5c" "date +%j"
			pausar;;
		d)
			date +%H:%M:%S
			registrar_log "5d" "date +%H:%M:%S"
			pausar;;
		0)
			num=0;;
		*)
			error_rojo "Opción inválida. Elija a, b, c, d o 0."
			pausar;;
	esac
done
