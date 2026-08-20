echo "¿Desea crear un directorio? (Si o No)"
read vRespuesta
if test $vRespuesta == "Si" -o $vRespuesta == "si"
then
        echo "Ingrese el nombre que desea poner al directorio:"
        read nomDir
        if mkdir $nomDir 2> /dev/null
        then
                echo "El directorio $nomDir ha sido creado exitosamente"
        else
                echo "El directorio $nomDir ya existe"
        fi
else
        echo "¿Qué directorio desea eliminar?"
        read eliDir
        if rm -r $eliDir 2> /dev/null
        then
                echo "El diretorio $eliDir fue eliminado exitosamente"
        else
                echo "El directorio $eliDir no ha sido eliminado"
        fi
fi
