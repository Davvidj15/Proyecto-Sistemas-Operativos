# no terminado
#!/bin/bash
num=1
while test "$num" == 1
do	
	echo "-----------------------------"
	echo "a) Crear un archivo con la siguiente información “CI:Nombre:Apellido:Teléfono:Fecha de Nacimiento:edad”."
	echo "b) Ver el contenido completo en formato listado."
	echo "c) Ver algunas líneas en particular."
	echo "d) Buscar y mostrar información de una persona ingresando la CI y campo a mostrar."
	echo "e) Eliminar una línea del archivo según la CI ingresada."
	echo "f) Permitir modificar el teléfono de una persona a través de su CI."
	echo "0) Salir."
	echo "-----------------------------"
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
			echo "Ingrese su edad:"
			read edad
			if echo "$CI:$apellido:$nombre:$telefono:$fnac:$edad." >> DatosPersonales.txt
			then
				echo "El archivo fue creado exitosamente."
			else
				echo "El archivo no fue creado, puede ya existir."
			fi;;
		b);;
		c)
			echo "¡AVISO!, para usar esta opción debe estar creado el archivo DatosPersonales.txt"
			echo "¿Éste está creado?"
			read var
			if test "$var" == "Si" -o "$var" == "si" 2> /dev/null
			then
				echo "¿Qué línea/s desea ver?"
				read linea
				sed -n "${linea}p" DatosPersonales.txt
			else
				echo "Cree el archivo para utilizar esta opción"
			fi;;
		d);;
		e)
			echo "Ingrese su CI:"
			read CI
			if test sed -i "/${CI}/d" DatosPersonales.txt
			then
					echo "Se ha borrado la línea exitosamente"
			else
					echo "La línea ya ha sido borrada o no existe"
			fi;;
		f)
			echo "Ingrese su CI:"
			read CI
			echo "Ingrese su nuevo número de teléfono:"
			read newTelefono
			sed -i "" DatosPersonales.txt
			;;
		0)num=0;;
	esac
done	
