#!/bin/bash
# Opción 2: Acciones sobre archivos
. ./funciones.sh

var=1
while test "$var" == 1
do
	clear
	mostrar_encabezado
	echo "-------------------------"
	echo "	Menu de Archivos"
	echo "-------------------------"
	echo "a. Eliminar archivo"
	echo "b. Copiar archivo"
	echo "c. Mover archivo"
	echo "d. Mostrar permisos del archivo"
	echo "e. Mostrar listado de archivos"
	echo "0. Salir"
	echo "-------------------------"
	mostrar_pie
	read opcion

	case $opcion in
		a)
			echo "Ingrese el nombre del archivo a eliminar:"
			read nomEli
			if rm "$nomEli" 2> /dev/null
			then
				echo "El archivo fue eliminado exitosamente."
				registrar_log "2a" "rm $nomEli"
			else
				error_rojo "El archivo no existe o ya fue eliminado."
				registrar_log "2a" "rm $nomEli (error)"
			fi;;
		b)
			echo "Ingrese el nombre del archivo a copiar:"
			read nomCop
			echo "Ingrese el nombre del archivo destino:"
			read nomDest
			if cp "$nomCop" "$nomDest" 2> /dev/null
			then
				echo "El archivo fue copiado exitosamente."
				registrar_log "2b" "cp $nomCop $nomDest"
			else
				error_rojo "No se pudo copiar el archivo."
				error_rojo "Revise que el origen exista y tenga permisos."
				registrar_log "2b" "cp $nomCop $nomDest (error)"
			fi;;
		c)
			echo "¿Qué archivo quieres mover?"
			read archnom1
			echo "¿A qué directorio(carpeta) quieres mover ese archivo?"
			read dir1
			if mv "$archnom1" "$dir1" 2> /dev/null
			then
				echo "El archivo ha sido trasladado correctamente."
				registrar_log "2c" "mv $archnom1 $dir1"
			else
				error_rojo "No se pudo mover el archivo."
				error_rojo "Revise el nombre del archivo y el directorio destino."
				registrar_log "2c" "mv $archnom1 $dir1 (error)"
			fi;;
		d)
			echo "Ingrese la ruta del archivo que desea ver los permisos:"
			read rutArch
			if [ ! -e "$rutArch" ]
			then
				error_rojo "El archivo $rutArch no existe."
				registrar_log "2d" "ls permisos $rutArch (no existe)"
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
				registrar_log "2d" "comprobar permisos $rutArch"
			fi;;
		e)
			echo "¿Qué directorio quieres listar?(Utilizar ruta)"
			read ruta1
			if ls "$ruta1" 2> /dev/null
			then
				echo ""
				registrar_log "2e" "ls $ruta1"
			else
				error_rojo "No se pudo listar el directorio correctamente."
				error_rojo "Revise si ingresó bien la ruta del directorio deseado"
				registrar_log "2e" "ls $ruta1 (error)"
			fi;;
		0)
			var=0;;
		*)
			error_rojo "Opción inválida. Elija una letra entre a y e, o 0 para salir.";;
	esac

	if test "$var" == 1
	then
		pausar
	fi
done
