#!/bin/bash
# Opción 3: Acciones sobre el contenido de un archivo
. ./funciones.sh

num=1
while test "$num" == 1
do
	clear
	mostrar_encabezado
	echo "-----------------------------"
	echo "a) Crear un archivo con la siguiente información “CI:Nombre:Apellido:Teléfono:Fecha de Nacimiento:edad”."
	echo "b) Ver el contenido completo en formato listado."
	echo "c) Ver algunas líneas en particular."
	echo "d) Buscar y mostrar información de una persona ingresando la CI y campo a mostrar."
	echo "e) Eliminar una línea del archivo según la CI ingresada."
	echo "f) Permitir modificar el teléfono de una persona a través de su CI."
	echo "0) Salir."
	echo "-----------------------------"
	mostrar_pie
	read opcion
	case $opcion in
		a)
			echo "Ingrese su CI:"
			read CI
			echo "Ingrese su apellido:"
			read apellido
			echo "Ingrese su nombre:"
			read nombre
			echo "Ingrese su teléfono:"
			read telefono
			echo "Ingrese su fecha de nacimiento (dd/mm/aaaa):"
			read fnac
			if echo "$fnac" | grep -q "^[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]$"
			then
				dia=`echo "$fnac" | cut -d/ -f1 | sed 's/^0//'`
				mes=`echo "$fnac" | cut -d/ -f2 | sed 's/^0//'`
				anio=`echo "$fnac" | cut -d/ -f3`
				anio_act=`date +%Y`
				mes_act=`date +%m | sed 's/^0//'`
				dia_act=`date +%d | sed 's/^0//'`
				edad=`expr "$anio_act" - "$anio"`
				if test "$mes_act" -lt "$mes" -o "$mes_act" -eq "$mes" -a "$dia_act" -lt "$dia"
				then
					edad=`expr "$edad" - 1`
				fi
				echo "$CI:$nombre:$apellido:$telefono:$fnac:$edad" >> "$ARCHIVO_AGENDA"
				echo "El registro fue guardado exitosamente."
				registrar_log "3a" "echo $CI:$nombre:$apellido:$telefono:$fnac:$edad >> $ARCHIVO_AGENDA"
			else
				error_rojo "La fecha no es válida. Use el formato dd/mm/aaaa."
				registrar_log "3a" "alta agenda (fecha inválida)"
			fi
			pausar;;
		b)
			if test -f "$ARCHIVO_AGENDA"
			then
				echo "CI | Nombre | Apellido | Teléfono | Fecha de nacimiento | Edad"
				echo "--------------------------------------------------------------"
				while IFS=: read ci nom ape tel fecha edad
				do
					echo "$ci | $nom | $ape | $tel | $fecha | $edad"
				done < "$ARCHIVO_AGENDA"
				registrar_log "3b" "listar $ARCHIVO_AGENDA"
			else
				error_rojo "El archivo $ARCHIVO_AGENDA no existe. Cree un registro con la opción a."
				registrar_log "3b" "listar $ARCHIVO_AGENDA (no existe)"
			fi
			pausar;;
		c)
			if test -f "$ARCHIVO_AGENDA"
			then
				echo "¿Qué línea/s desea ver? (ejemplo: 3 o 3,4)"
				read linea
				sed -n "${linea}p" "$ARCHIVO_AGENDA"
				registrar_log "3c" "sed -n ${linea}p $ARCHIVO_AGENDA"
			else
				error_rojo "Cree el archivo para utilizar esta opción"
				registrar_log "3c" "sed -n (archivo no existe)"
			fi
			pausar;;
		d)
			if test -f "$ARCHIVO_AGENDA"
			then
				echo "Ingrese la CI de la persona:"
				read CI
				echo "¿Qué campo desea mostrar?"
				echo "1) CI"
				echo "2) Nombre"
				echo "3) Apellido"
				echo "4) Teléfono"
				echo "5) Fecha de nacimiento"
				echo "6) Edad"
				read campo
				linea=`grep "^${CI}:" "$ARCHIVO_AGENDA"`
				if test -z "$linea"
				then
					error_rojo "No se encontró una persona con la CI $CI"
					registrar_log "3d" "grep ^$CI: $ARCHIVO_AGENDA (no encontrado)"
				else
					case $campo in
						1|2|3|4|5|6)
							echo "$linea" | cut -d: -f"$campo"
							registrar_log "3d" "cut -d: -f$campo (CI $CI)";;
						*)
							error_rojo "Campo inválido. Debe ser un número del 1 al 6."
							registrar_log "3d" "busqueda CI $CI (campo inválido)";;
					esac
				fi
			else
				error_rojo "Cree el archivo para utilizar esta opción"
				registrar_log "3d" "buscar (archivo no existe)"
			fi
			pausar;;
		e)
			if test -f "$ARCHIVO_AGENDA"
			then
				echo "Ingrese su CI:"
				read CI
				if grep "^${CI}:" "$ARCHIVO_AGENDA" > /dev/null
				then
					grep -v "^${CI}:" "$ARCHIVO_AGENDA" > agenda.tmp
					mv agenda.tmp "$ARCHIVO_AGENDA"
					echo "Se ha borrado la línea exitosamente"
					registrar_log "3e" "grep -v ^$CI: $ARCHIVO_AGENDA"
				else
					error_rojo "La línea ya ha sido borrada o no existe"
					registrar_log "3e" "eliminar CI $CI (no existe)"
				fi
			else
				error_rojo "Cree el archivo para utilizar esta opción"
				registrar_log "3e" "eliminar (archivo no existe)"
			fi
			pausar;;
		f)
			if test -f "$ARCHIVO_AGENDA"
			then
				echo "Ingrese su CI:"
				read CI
				if grep "^${CI}:" "$ARCHIVO_AGENDA" > /dev/null
				then
					echo "Ingrese su nuevo número de teléfono:"
					read newTelefono
					while IFS=: read ci nom ape tel fecha edad
					do
						if test "$ci" = "$CI"
						then
							echo "$ci:$nom:$ape:$newTelefono:$fecha:$edad"
						else
							echo "$ci:$nom:$ape:$tel:$fecha:$edad"
						fi
					done < "$ARCHIVO_AGENDA" > agenda.tmp
					mv agenda.tmp "$ARCHIVO_AGENDA"
					echo "El teléfono fue modificado exitosamente."
					registrar_log "3f" "modificar telefono CI $CI"
				else
					error_rojo "No se encontró una persona con la CI $CI"
					registrar_log "3f" "modificar telefono CI $CI (no existe)"
				fi
			else
				error_rojo "Cree el archivo para utilizar esta opción"
				registrar_log "3f" "modificar telefono (archivo no existe)"
			fi
			pausar;;
		0)
			num=0;;
		*)
			error_rojo "Opción inválida. Elija una letra entre a y f, o 0 para salir."
			pausar;;
	esac
done
