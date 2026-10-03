#!/bin/bash
# Opción 7: Archivo de log
. ./funciones.sh

num=1
while test "$num" == 1
do
	clear
	mostrar_encabezado
	echo "---------------------------------------------"
	echo " Archivo de log"
	echo "---------------------------------------------"
	echo "a) Mostrar registros entre dos fechas"
	echo "b) Mostrar registros de un tipo de acción"
	echo "c) Mostrar todas las acciones de un usuario"
	echo "d) Eliminar el log (usuario autorizado)"
	echo "0) Volver al menú principal"
	echo "---------------------------------------------"
	mostrar_pie
	read opcion
	case $opcion in
		a)
			if test -f "$LOG"
			then
				echo "Ingrese la fecha desde (aaaa-mm-dd):"
				read desde
				echo "Ingrese la fecha hasta (aaaa-mm-dd):"
				read hasta
				echo "Fecha | Hora | Usuario | Opción | Comando"
				echo "---------------------------------------------"
				encontrado=0
				while IFS="|" read fecha hora usuario opcionlog comando
				do
					if test "$fecha" \>= "$desde" -a "$fecha" \<= "$hasta"
					then
						echo "$fecha | $hora | $usuario | $opcionlog | $comando"
						encontrado=1
					fi
				done < "$LOG"
				if test "$encontrado" = 0
				then
					error_rojo "No hay registros entre esas fechas."
				fi
				registrar_log "7a" "filtrar log entre $desde y $hasta"
			else
				error_rojo "Todavía no existe el archivo de log."
			fi
			pausar;;
		b)
			if test -f "$LOG"
			then
				echo "Ingrese el tipo de acción (ejemplo: 1, 2a, 3e, 5b):"
				read tipo
				echo "Fecha | Hora | Usuario | Opción | Comando"
				echo "---------------------------------------------"
				encontrado=0
				while IFS="|" read fecha hora usuario opcionlog comando
				do
					if test "$opcionlog" = "$tipo"
					then
						echo "$fecha | $hora | $usuario | $opcionlog | $comando"
						encontrado=1
					fi
				done < "$LOG"
				if test "$encontrado" = 0
				then
					error_rojo "No hay registros de la acción $tipo."
				fi
				registrar_log "7b" "filtrar log por accion $tipo"
			else
				error_rojo "Todavía no existe el archivo de log."
			fi
			pausar;;
		c)
			if test -f "$LOG"
			then
				echo "Ingrese el usuario:"
				read usu
				echo "Fecha | Hora | Usuario | Opción | Comando"
				echo "---------------------------------------------"
				encontrado=0
				while IFS="|" read fecha hora usuario opcionlog comando
				do
					if test "$usuario" = "$usu"
					then
						echo "$fecha | $hora | $usuario | $opcionlog | $comando"
						encontrado=1
					fi
				done < "$LOG"
				if test "$encontrado" = 0
				then
					error_rojo "No hay registros del usuario $usu."
				fi
				registrar_log "7c" "filtrar log por usuario $usu"
			else
				error_rojo "Todavía no existe el archivo de log."
			fi
			pausar;;
		d)
			echo "Ingrese la contraseña de autorización:"
			read clave
			if test "$clave" = "$CLAVE_LOG"
			then
				if test -f "$LOG"
				then
					rm "$LOG"
					echo "El archivo de log fue eliminado."
				else
					error_rojo "No hay archivo de log para eliminar."
				fi
			else
				error_rojo "Contraseña incorrecta. No se eliminó el log."
				registrar_log "7d" "rm $LOG (contraseña incorrecta)"
			fi
			pausar;;
		0)
			num=0;;
		*)
			error_rojo "Opción inválida. Elija a, b, c, d o 0."
			pausar;;
	esac
done
