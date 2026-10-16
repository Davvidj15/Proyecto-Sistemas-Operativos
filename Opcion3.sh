#!/bin/bash
# Opción 3: Acciones sobre el contenido de un archivo tipo agenda
# Formato de cada línea: CI:Nombre:Apellido:Teléfono:FechaNacimiento:Edad
# test -f verifica si el expresión existe
# test -z verifica que el tamaño del string sea cero
. ./funciones.sh

num=1
while test "$num" == 1
do
	clear
	mostrar_encabezado
	echo " Acciones sobre un archivo"
	echo "-----------------------------"
	echo "a) Agregar una persona a la agenda"
	echo "b) Ver la agenda completa"
	echo "c) Ver algunas líneas"
	echo "d) Buscar un dato de una persona por CI"
	echo "e) Eliminar una persona por CI"
	echo "f) Modificar el teléfono de una persona"
	echo "0) Salir"
	mostrar_pie
	read -p "Ingrese una opción: " opcion

	case $opcion in
	a)
		echo "Ingrese la CI:"
		read ci
		echo "Ingrese el apellido:"
		read apellido
		echo "Ingrese el nombre:"
		read nombre
		echo "Ingrese el teléfono:"
		read telefono
		echo "Ingrese la fecha de nacimiento (dd/mm/aaaa):"
		read fnac

		# Comprobamos que la fecha tenga el formato dd/mm/aaaa
		if echo "$fnac" | grep -q "^[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]$"
		then
			# Separamos día, mes y año usando "/" como separador
			dia=$(echo "$fnac" | cut -d/ -f1)
			mes=$(echo "$fnac" | cut -d/ -f2)
			anio=$(echo "$fnac" | cut -d/ -f3)

			# Edad = año actual - año de nacimiento
			anio_actual=$(date +%Y)
			edad=$((año_actual - año))

			# Si todavía no cumplió años este año, le restamos 1.
			# Comparamos mes y día juntos como un número.
			# Ejemplo: hoy 14/10 es 1014 y un cumpleaños el 25/12 es 1225
			hoy=$(date +%m%d)
			cumple="$mes$dia"
			if test "$hoy" -lt "$cumple"
			then
				edad=$((edad - 1))
			fi

			echo "$ci:$nombre:$apellido:$telefono:$fnac:$edad" >> "$ARCHIVO_AGENDA"
			echo "Persona agregada correctamente."
			registrar_log "3a" "echo $ci:$nombre:$apellido:$telefono:$fnac:$edad >> $ARCHIVO_AGENDA"
		else
			error_rojo "Fecha inválida. Use el formato dd/mm/aaaa."
			registrar_log "3a" "agregar persona (fecha inválida)"
		fi;;

	b)
		if test -f "$ARCHIVO_AGENDA"
		then
			echo "CI | Nombre | Apellido | Teléfono | Fecha nac. | Edad"
			echo "-----------------------------------------------------"
			# Leemos el archivo línea por línea.
			# IFS=: indica que cada campo está separado por ":"
			while IFS=: read ci nombre apellido telefono fnac edad
			do
				echo "$ci | $nombre | $apellido | $telefono | $fnac | $edad"
			done < "$ARCHIVO_AGENDA"
			registrar_log "3b" "listar $ARCHIVO_AGENDA"
		else
			error_rojo "La agenda no existe. Agregue una persona con la opción a."
			registrar_log "3b" "listar (archivo no existe)"
		fi;;

	c)
		if test -f "$ARCHIVO_AGENDA"
		then
			echo "Ver desde la línea:"
			read desde
			echo "Hasta la línea:"
			read hasta
			# sed -n "3,4p" muestra solo las líneas de la 3 a la 4
			sed -n "${desde},${hasta}p" "$ARCHIVO_AGENDA"
			registrar_log "3c" "sed -n ${desde},${hasta}p $ARCHIVO_AGENDA"
		else
			error_rojo "La agenda no existe. Agregue una persona con la opción a."
			registrar_log "3c" "ver líneas (archivo no existe)"
		fi;;

	d)
		if test -f "$ARCHIVO_AGENDA"
		then
			echo "Ingrese la CI de la persona:"
			read ci
			echo "¿Qué campo desea mostrar?"
			echo "1) CI"
			echo "2) Nombre"
			echo "3) Apellido"
			echo "4) Teléfono"
			echo "5) Fecha de nacimiento"
			echo "6) Edad"
			read campo

			# Buscamos la línea que empieza con esa CI
			linea=$(grep "^$ci:" "$ARCHIVO_AGENDA")

			if test -z "$linea"
			then
				error_rojo "No existe una persona con la CI $ci"
				registrar_log "3d" "grep ^$ci: $ARCHIVO_AGENDA (no encontrado)"
			else
				case $campo in
				1|2|3|4|5|6)
					echo "$linea" | cut -d: -f"$campo"
					registrar_log "3d" "cut -d: -f$campo (CI $ci)";;
				*)
					error_rojo "Campo inválido. Debe ser un número del 1 al 6."
					registrar_log "3d" "buscar CI $ci (campo inválido)";;
				esac
			fi
		else
			error_rojo "La agenda no existe. Agregue una persona con la opción a."
			registrar_log "3d" "buscar (archivo no existe)"
		fi;;

	e)
		if test -f "$ARCHIVO_AGENDA"
		then
			echo "Ingrese la CI de la persona a eliminar:"
			read ci
			if grep -q "^$ci:" "$ARCHIVO_AGENDA"
			then
				# Copiamos todas las líneas MENOS la de esa CI a un archivo temporal
				grep -v "^$ci:" "$ARCHIVO_AGENDA" > agenda.tmp
				# El temporal pasa a ser la agenda nueva
				mv agenda.tmp "$ARCHIVO_AGENDA"
				echo "Persona eliminada correctamente."
				registrar_log "3e" "grep -v ^$ci: $ARCHIVO_AGENDA"
			else
				error_rojo "No existe una persona con la CI $ci"
				registrar_log "3e" "eliminar CI $ci (no existe)"
			fi
		else
			error_rojo "La agenda no existe. Agregue una persona con la opción a."
			registrar_log "3e" "eliminar (archivo no existe)"
		fi;;

	f)
		if test -f "$ARCHIVO_AGENDA"
		then
			echo "Ingrese la CI de la persona:"
			read ci
			if grep -q "^$ci:" "$ARCHIVO_AGENDA"
			then
				echo "Ingrese el nuevo teléfono:"
				read nuevo_telefono

				# Recorremos la agenda línea por línea y la copiamos a un temporal.
				# Si la CI coincide, escribimos la línea con el teléfono nuevo.
				# "< agenda" es de donde se lee y "> agenda.tmp" es donde se escribe.
				while IFS=: read ci_actual nombre apellido telefono fnac edad
				do
					if test "$ci_actual" = "$ci"
					then
						telefono="$nuevo_telefono"
					fi
					echo "$ci_actual:$nombre:$apellido:$telefono:$fnac:$edad"
				done < "$ARCHIVO_AGENDA" > agenda.tmp

				# El temporal pasa a ser la agenda nueva
				mv agenda.tmp "$ARCHIVO_AGENDA"
				echo "Teléfono modificado correctamente."
				registrar_log "3f" "modificar teléfono CI $ci a $nuevo_telefono"
			else
				error_rojo "No existe una persona con la CI $ci"
				registrar_log "3f" "modificar teléfono CI $ci (no existe)"
			fi
		else
			error_rojo "La agenda no existe. Agregue una persona con la opción a."
			registrar_log "3f" "modificar teléfono (archivo no existe)"
		fi;;

	0)
		num=0;;

	*)
		error_rojo "Opción inválida. Elija una letra de la a a la f, o 0 para salir.";;
	esac
	
	if test "$num" = 1
	then
		pausar
	fi
done
