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
                if cp "$nomCop" "$nomDest" 2> /dev/null
                then
                        echo "El archivo fue copiado exitosamente."
                else
                        echo "El archivo no existe."
                fi;;
			c)
				echo "¿Qué archivo quieres mover?"
				read archnom1
				echo "¿A qué directorio quieres mover ese archivo?"
				read dir1
				mv "$archnom1" "$dir1"
				echo "El archivo ha sido trasladado correctamente";;
			d);;
			e)
				echo "¿Qué directorio quieres listar?(Utilizar ruta)"
				read ruta1
				if ls $ruta1 2> /dev/null
				then
        			echo ""
				else
        			echo "No se pudo listar el directorio correctamente."
        			echo "Revise si ingresó bien la ruta del directorio deseado"
				fi;;
			0)var=0;;
		esac
	done
fi
