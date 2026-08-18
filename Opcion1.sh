echo "¿Desea crear un directorio? (Si o No)"
read vRespuesta
if ($vRespuesta)
then
	echo "Ingrese el nombre que desea poner al directorio:"
	read nomDir
	if mkdir $nomDir 2> /dev/null
	then
		echo "El directorio ha sido creado exitosamente"
	else
		echo "El directorio ya existe"
else
	echo "¿Qué directorio desea eliminar?"
	read eliDir
	if rmdir $eliDir 2> /dev/null
	then
		echo "El diretorio fue eliminado exitosamente"
	else
		echo "El directorio no ha sido eliminado"
		echo "El error puede deberse a que el directorio $eliDir tiene algún archivo dentro"
fi
