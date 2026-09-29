#!/bin/bash
#Opcion 2

var=1
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
			if rm "$nomEli" 2> /dev/null
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
				echo "No se pudo copiar el archivo."
				echo "Revise que el origen exista y tenga permisos."
			fi;;
		c)
			echo "¿Qué archivo quieres mover?"
			read archnom1
			echo "¿A qué directorio quieres mover ese archivo?"
			read dir1
			if mv "$archnom1" "$dir1" 2> /dev/null
			then
				echo "El archivo ha sido trasladado correctamente."
			else
				echo "No se pudo mover el archivo."
				echo "Revise el nombre del archivo y el directorio destino."
			fi;;
		d)
			echo "Ingrese la ruta del archivo que desea ver los permisos:"
			read rutArch
			if [ ! -e "$rutArch" ]
			then
				echo "El archivo $rutArch no existe."
			else
				if [ -r "$rutArch" ]
				then
					echo "El archivo $rutArch tiene permiso de lectura"
				else
					echo "El archivo $rutArch no tiene permiso de lectura"
				fi
				if [ -w "$rutArch" ]
				then
					echo "El archivo $rutArch tiene permiso de escritura"
				else
					echo "El archivo $rutArch no tiene permiso de escritura"
				fi
				if [ -x "$rutArch" ]
				then
					echo "El archivo $rutArch tiene permiso de ejecución"
				else
					echo "El archivo $rutArch no tiene permiso de ejecución"
				fi
			fi;;
		e)
			echo "¿Qué directorio quieres listar?(Utilizar ruta)"
			read ruta1
			if ls "$ruta1" 2> /dev/null
			then
				echo ""
			else
				echo "No se pudo listar el directorio correctamente."
				echo "Revise si ingresó bien la ruta del directorio deseado"
			fi;;
		0)
			var=0;;
		*)
			echo "Opción inválida. Elija una letra entre a y e, o 0 para salir.";;
	esac

	if test "$var" == 1
	then
		echo ""
		echo "Presione Enter para continuar..."
		read
	fi
done
