#!/bin/bash
#Opcion 4

perm=1
while test "$perm" = 1
do
	echo "---------------------------------------------"
	echo " Cambiar permisos de archivo o directorio"
	echo "---------------------------------------------"
	echo "a. Cambiar permisos en modo numérico (Ej: 755)"
	echo "b. Cambiar permisos en modo simbólico (Ej: u+x)"
	echo "0. Salir"
	echo "---------------------------------------------"
	read opcion

	case $opcion in
		a)
			echo "Ingrese la ruta del archivo o directorio:"
			read ruta
			if [ ! -e "$ruta" ]
			then
				echo "El archivo o directorio $ruta no existe."
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
					else
						echo "No se pudieron cambiar los permisos."
						echo "Revise que sea el dueño del archivo o directorio."
					fi
				else
					echo "El modo $modo no es válido. Debe ingresar 3 dígitos del 0 al 7."
				fi
			fi;;
		b)
			echo "Ingrese la ruta del archivo o directorio:"
			read ruta
			if [ ! -e "$ruta" ]
			then
				echo "El archivo o directorio $ruta no existe."
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
						echo "Opción inválida, se aplicará a todos (a)."
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
						echo "Opción inválida, se agregarán los permisos (+)."
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
					else
						echo "No se pudieron cambiar los permisos."
						echo "Revise que sea el dueño del archivo o directorio."
					fi
				else
					echo "Los permisos $permisos no son válidos. Use solo r, w o x."
				fi
			fi;;
		0)
			perm=0;;
		*)
			echo "Opción inválida. Elija a, b o 0 para salir.";;
	esac

	if test "$perm" = 1
	then
		echo ""
		echo "Presione Enter para continuar..."
		read enter
	fi
done
