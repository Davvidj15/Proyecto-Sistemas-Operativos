#!/bin/bash
# Opción 1: Crear y eliminar directorios
. ./funciones.sh

num=1
while test "$num" == 1
do
	clear
	mostrar_encabezado
	echo "-----------------------------"
	echo " Acciones sobre directorios"
	echo "-----------------------------"
	echo "a) Crear un directorio"
	echo "b) Eliminar un directorio"
	echo "0) Volver al menú principal"
	echo "-----------------------------"
	mostrar_pie
	read opcion
	case $opcion in
		a)
			echo "Ingrese el nombre que desea poner al directorio:"
			read nomDir
			if mkdir "$nomDir" 2> /dev/null
			then
				echo "El directorio $nomDir ha sido creado exitosamente"
				registrar_log "1a" "mkdir $nomDir"
			else
				error_rojo "El directorio $nomDir ya existe"
				registrar_log "1a" "mkdir $nomDir (error: ya existe)"
			fi
			pausar;;
		b)
			echo "Ingrese el nombre del directorio a eliminar:"
			read eliDir
			if test -d "$eliDir"
			then
				if rm -r "$eliDir" 2> /dev/null
				then
					echo "El directorio $eliDir fue eliminado exitosamente"
					registrar_log "1b" "rm -r $eliDir"
				else
					error_rojo "El directorio $eliDir no ha sido eliminado"
					registrar_log "1b" "rm -r $eliDir (error)"
				fi
			else
				error_rojo "El directorio $eliDir no existe"
				registrar_log "1b" "rm -r $eliDir (no existe)"
			fi
			pausar;;
		0)
			num=0;;
		*)
			error_rojo "Opción inválida. Elija a, b o 0."
			pausar;;
	esac
done
