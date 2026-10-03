#!/bin/bash
# Funciones compartidas: encabezado, errores en rojo y archivo de log

LOG="acciones.log"
ARCHIVO_AGENDA="DatosPersonales.txt"
INTEGRANTES="Integrantes del grupo: Araque David, Rodríguez Ignacio"
CLAVE_LOG="so2026"

mostrar_encabezado() {
	echo "-------------------------------------------------------"
	echo "${USUARIO:-$(whoami)} | $(. /etc/os-release && echo "$PRETTY_NAME") | $(date '+%d/%m/%Y %H:%M:%S')"
	echo "-------------------------------------------------------"
}

mostrar_pie() {
	echo "-------------------------------------------------------"
	echo "$INTEGRANTES"
	echo "-------------------------------------------------------"
}

error_rojo() {
	printf '\033[31m%s\033[0m\n' "$1"
}

registrar_log() {
	echo "$(date +%Y-%m-%d)|$(date +%H:%M:%S)|${USUARIO:-$(whoami)}|$1|$2" >> "$LOG"
}

pausar() {
	echo ""
	echo "Presione Enter para continuar..."
	read enter
}
