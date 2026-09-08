#!/bin/bash
var=1
if test "$var" == 1
then
	while test "$var" == 1
	do
		echo "-------------------------"
		echo "	Menu de Archivos"
		echo "-------------------------"
		echo "a. Eliminar archivo"
		echo "b. Copiar archivo"
		echo "c. Mover archivo"
		echo "d. Mostrar permisos del archivo"
		echo "e. Mostrar listado de archivos"
		echo "0. Salir"
		read opcion

		case $opcion in
			1)
				echo "";;
		esac
	done
else
fi
