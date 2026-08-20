echo "¿Desea ver el menú?(Si o No)"
read vRespuesta
if test "$vRespuesta" == "Si" -o "$vRespuesta" == "si"
then
	while test "$vRespuesta" == "Si" -o "$vRespuesta" == "si"
	do
		echo "------------------------------------------"
		echo "	Bienvenido al menú"
		echo ".........................................."
		echo "1) Crear o eliminar directorios"
		echo "2) Acciones sobre archivos"
		echo "3) Acciones sobre el contenido de un archivo"
		echo "4) Cambiar permisos de un archivo o directorio"
		echo "5) Mostrar fecha y/o hora del sistema operativo"
		echo "6) Mostrar los meses del año ingresados(formato calendario)"
		echo "7) Archivo de log"
		echo "8) Salir"
		echo "------------------------------------------"
		read opcion
		case $opcion in
			1) sh Opcion1.sh;;
			2) sh Opcion2.sh;;
			3) sh Opcion3.sh;;
			4) sh Opcion4.sh;;
			5) sh Opcion5.sh;;
			6) sh Opcion6.sh;;
			7) sh Opcion7.sh;;
			8) vRespuesta=No;;
		esac
		
	done
else
	echo "Ok, espero vernos pronto :)"
fi
