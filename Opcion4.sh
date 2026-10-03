#!/bin/bash
# Opción 4: Cambiar permisos de un archivo o directorio
. ./funciones.sh

perm=1
while test "$perm" = 1
do
	clear
	mostrar_encabezado
	echo "---------------------------------------------"
	echo " Cambiar permisos de archivo o directorio"
	echo "---------------------------------------------"
	echo "a. Cambiar permisos en modo numérico (Ej: 755)"
	echo "b. Cambiar permisos en modo simbólico (Ej: u+x)"
	echo "0. Salir"
	echo "---------------------------------------------"
	mostrar_pie
	read opcion

	case $opcion in
		a)
			echo "Ingrese la ruta del archivo o directorio:"
			read ruta
			if [ ! -e "$ruta" ]
			then
				error_rojo "El archivo o directorio $ruta no existe."
				registrar_log "4a" "chmod $ruta (no existe)"
			else
				echo "Permisos actuales:"
				ls -ld "$ruta"
				echo "Ingrese los permisos en modo numérico (3 dígitos del 0 al 7):"
				read modo
				if echo "$modo" | grep -q "^[0-7][0-7][0-7]$"
				then
					if chmod "$modo" "$ruta" 2> /dev/null
					then
						echo "Los permisos fueron cambiados exitosamente."
						ls -ld "$ruta"
						registrar_log "4a" "chmod $modo $ruta"
					else
						error_rojo "No se pudieron cambiar los permisos."
						error_rojo "Revise que sea el dueño del archivo o directorio."
						registrar_log "4a" "chmod $modo $ruta (error)"
					fi
				else
					error_rojo "El modo $modo no es válido. Debe ingresar 3 dígitos del 0 al 7."
					registrar_log "4a" "chmod $modo $ruta (modo inválido)"
				fi
			fi;;
		b)
			echo "Ingrese la ruta del archivo o directorio:"
			read ruta
			if [ ! -e "$ruta" ]
			then
				error_rojo "El archivo o directorio $ruta no existe."
				registrar_log "4b" "chmod $ruta (no existe)"
			else
				echo "Permisos actuales:"
				ls -ld "$ruta"
				echo "¿A quién desea cambiarle los permisos?"
				echo "u) Usuario dueño"
				echo "g) Grupo"
				echo "o) Otros"
				echo "a) Todos"
				read quien
				case $quien in
					u|g|o|a) ;;
					*)
						error_rojo "Opción inválida, se aplicará a todos (a)."
						quien="a";;
				esac
				echo "¿Qué desea hacer?"
				echo "+) Agregar permiso"
				echo "-) Quitar permiso"
				echo "=) Asignar únicamente estos permisos"
				read accion
				case $accion in
					+|-|=) ;;
					*)
						error_rojo "Opción inválida, se agregarán los permisos (+)."
						accion="+";;
				esac
				echo "Ingrese los permisos (r lectura, w escritura, x ejecución):"
				echo "Puede combinarlos, por ejemplo: rw"
				read permisos
				if echo "$permisos" | grep -q "^[rwx][rwx]*$"
				then
					if chmod "$quien$accion$permisos" "$ruta" 2> /dev/null
					then
						echo "Los permisos fueron cambiados exitosamente."
						ls -ld "$ruta"
						registrar_log "4b" "chmod $quien$accion$permisos $ruta"
					else
						error_rojo "No se pudieron cambiar los permisos."
						error_rojo "Revise que sea el dueño del archivo o directorio."
						registrar_log "4b" "chmod $quien$accion$permisos $ruta (error)"
					fi
				else
					error_rojo "Los permisos $permisos no son válidos. Use solo r, w o x."
					registrar_log "4b" "chmod (permisos inválidos)"
				fi
			fi;;
		0)
			perm=0;;
		*)
			error_rojo "Opción inválida. Elija a, b o 0 para salir.";;
	esac

	if test "$perm" = 1
	then
		pausar
	fi
done
