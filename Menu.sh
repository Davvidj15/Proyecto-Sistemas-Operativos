#!/bin/bash
# Menú principal del sistema
. ./funciones.sh

echo "Ingrese su nombre de usuario:"
read USUARIO
export USUARIO
registrar_log "login" "ingreso al sistema"

vRespuesta=1
while test "$vRespuesta" == 1
do
	clear
	mostrar_encabezado
	echo "	Bienvenido al menú"
	echo "-------------------------------------------------------"
	echo "1) Crear o eliminar directorios"
	echo "2) Acciones sobre archivos"
	echo "3) Acciones sobre el contenido de un archivo"
	echo "4) Cambiar permisos de un archivo o directorio"
	echo "5) Mostrar fecha y/o hora del sistema operativo"
	echo "6) Mostrar los meses del año ingresados(formato calendario)"
	echo "7) Archivo de log"
	echo "0) Salir"
	echo "-------------------------------------------------------"
	echo "Pedido de datos, muestra de información, listados, etc"
	echo "-------------------------------------------------------"
	mostrar_pie
	read opcion
	case $opcion in
		1)
			registrar_log "1" "bash Opcion1.sh"
			bash Opcion1.sh;;
		2)
			registrar_log "2" "bash Opcion2.sh"
			bash Opcion2.sh;;
		3)
			registrar_log "3" "bash Opcion3.sh"
			bash Opcion3.sh;;
		4)
			registrar_log "4" "bash Opcion4.sh"
			bash Opcion4.sh;;
		5)
			registrar_log "5" "bash Opcion5.sh"
			bash Opcion5.sh;;
		6)
			registrar_log "6" "bash Opcion6.sh"
			bash Opcion6.sh;;
		7)
			registrar_log "7" "bash Opcion7.sh"
			bash Opcion7.sh;;
		0)
			registrar_log "0" "salir del menu principal"
			vRespuesta=0;;
		*)
			error_rojo "Opción inválida. Elija un número entre 0 y 7."
			pausar;;
	esac
done
