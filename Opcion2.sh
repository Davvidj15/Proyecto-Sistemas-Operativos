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
			a)
				echo "Ingrese el nombre del archivo a eliminar:"
                read nomEli
            	if rm $nomEli 2> /dev/null
                then
                        echo "El archivo fue eliminado exitosamente."
                else
                        echo "El archivo no existe o ya fue eliminado."
                fi;;
			b)
				echo "Ingrese el nombre del archivo a copiar:"
                read nomCop
                echo "Ingrese el nombre del archivo destino:"
                read nomDest
                if cp $nomCop $nomDest 2> /dev/null
                then
                        echo "El archivo fue copiado exitosamente."
                else
                        echo "El archivo no existe."
                fi;;
			c);;
			d);;
			e);;
			0)var=0;;
		esac
	done
fi
