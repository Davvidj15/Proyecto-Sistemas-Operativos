# Proyecto-Sistemas-Operativos
Integrantes: Araque David, Rodríguez Ignacio

Programa de consola para Linux, hecho en Bash, que reúne en un solo menú las tareas más
comunes del sistema operativo: manejar carpetas y archivos, cambiar permisos, consultar la
fecha y el calendario, y llevar una pequeña agenda de personas. Todo lo que se hace queda
registrado en un archivo de historial (log).

Contenido:
1. Objetivo del proyecto
2. Requisitos
3. Cómo se usa
4. Cómo funciona
5. Funcionalidades en detalle
6. El archivo de historial (log)
7. Manejo de errores
8. Archivos del proyecto
9. Posibles mejoras
10. Conclusión

1. Objetivo del proyecto
La idea del proyecto es poner en práctica lo visto en Sistemas Operativos usando la terminal de Linux.
En lugar de escribir los comandos uno por uno, el programa los ofrece en un menú fácil de recorrer: el
usuario elige qué quiere hacer y el programa le va pidiendo los datos necesarios.
De esta forma, alguien que no conoce los comandos de Linux puede crear carpetas, copiar archivos o
cambiar permisos sin tener que memorizar nada. Al mismo tiempo, el programa guarda un registro de
todo lo que se hizo, para saber quién hizo qué y cuándo.

2. Requisitos
Una computadora o máquina virtual con Linux (por ejemplo Ubuntu o Debian).
La terminal Bash, que viene incluida en casi todas las distribuciones.
El comando cal para la opción del calendario. Si no está instalado, en Ubuntu/Debian se instala
con sudo apt install ncal .
No hace falta instalar nada más ni tener permisos de administrador para usar el programa.

3. Cómo se usa
  1. Descargar o clonar el proyecto en la máquina con Linux.
  2. Abrir una terminal dentro de la carpeta del proyecto.
  3. Ejecutar:
    bash Menu.sh
  4. Elegir una opción escribiendo su número y presionar Enter.
  5. Dentro de cada opción, elegir la acción escribiendo su letra.
  6. Para volver atrás o salir, escribir 0 .
  Es importante ejecutar el programa desde la carpeta del proyecto, porque ahí es donde busca sus otros
  archivos y donde guarda la agenda y el historial.

4. Cómo funciona
Al abrir el programa aparece el menú principal. Se ve más o menos así:

-------------------------------------------------------
usuario | Ubuntu 24.04 LTS | 25/10/2026 19:52:34
-------------------------------------------------------
Bienvenido al menú
-------------------------------------------------------
1) Crear o eliminar directorios
2) Acciones sobre archivos
3) Acciones sobre el contenido de un archivo
4) Cambiar permisos de un archivo o directorio
5) Mostrar fecha y/o hora del sistema operativo
6) Mostrar los meses del año ingresados(formato calendario)
7) Archivo de log
0) Salir
-------------------------------------------------------
Integrantes del grupo: Araque David, Rodríguez Ignacio
-------------------------------------------------------
Ingrese una opción:


Cada pantalla tiene la misma estructura:
Encabezado: muestra el usuario que está usando el programa, el nombre del sistema operativo y la
fecha y hora actuales.
Opciones: la lista de acciones disponibles en esa pantalla.
Pie: los nombres de los integrantes del grupo.
Cada opción del menú principal abre su propio submenú. Después de cada acción, el programa
muestra el resultado y espera a que se presione Enter antes de volver a mostrar el submenú, para que
haya tiempo de leer lo que pasó. El programa sigue funcionando hasta que el usuario elige 0 en el
menú principal.

5. Funcionalidades en detalle
Opción 1: Crear o eliminar directorios
  Crear un directorio: se escribe el nombre de la carpeta nueva y el programa la crea. Si ya existe una
  con ese nombre, avisa.
  Eliminar un directorio: se escribe el nombre de la carpeta y el programa la borra junto con todo lo
  que tenga adentro. Si la carpeta no existe, avisa.
Opción 2: Acciones sobre archivos
  Eliminar archivo: borra el archivo indicado.
  Copiar archivo: pide el archivo original y el nombre de la copia.
  Mover archivo: pide el archivo y la carpeta a donde se quiere llevar.
  Mostrar permisos: indica si el usuario actual puede leer, modificar y ejecutar el archivo.
  Listar archivos: muestra lo que hay dentro de una carpeta.
Opción 3: Agenda de personas
  Funciona como una pequeña agenda que se guarda en el archivo DatosPersonales.txt . De cada
  persona se guardan su CI, nombre, apellido, teléfono, fecha de nacimiento y edad.
  Agregar una persona: se ingresan sus datos uno por uno. La fecha de nacimiento debe escribirse
  como dd/mm/aaaa . La edad se calcula sola, teniendo en cuenta si la persona ya cumplió años en
  el año actual o todavía no.
  Ver la agenda completa: muestra a todas las personas en forma de tabla.
  Ver algunas líneas: se indica desde qué línea hasta qué línea se quiere ver, útil cuando la agenda es
  grande.
  Buscar un dato por CI: se ingresa la CI de la persona y se elige qué dato mostrar (nombre, teléfono,
  edad, etc.).
  Eliminar una persona: la borra de la agenda usando su CI.
  Modificar el teléfono: cambia el teléfono de una persona buscándola por su CI.
  Así se ve la agenda al mostrarla:

  CI | Nombre | Apellido | Teléfono | Fecha nac. | Edad
  -----------------------------------------------------
  12345678 | Ana | Pérez | 099123456 | 14/03/2001 | 25

Opción 4: Cambiar permisos
  Permite decidir quién puede leer, modificar o ejecutar un archivo o carpeta. Antes y después del
  cambio se muestran los permisos, para comparar. Hay dos formas de hacerlo:
  Modo numérico: se escriben tres números del 0 al 7, por ejemplo 755 . Es la forma rápida para
  quien ya la conoce.
  Modo guiado (simbólico): el programa pregunta paso a paso:
  1. A quién se le cambian los permisos: al dueño, al grupo, a los demás o a todos.
  2. Qué se quiere hacer: agregar, quitar o dejar solamente ciertos permisos.
  3. Qué permisos: lectura ( r ), escritura ( w ) y/o ejecución ( x ).
Opción 5: Fecha y hora
  Ver la fecha como año/mes/día (ej. 2026/10/25 ).
  Ver la fecha en palabras (ej. "Hoy es 25 de octubre del año 2026").
  Ver cuántos días pasaron desde el comienzo del año.
  Ver la hora actual.
Opción 6: Calendario
  Se escriben uno o varios meses (del 1 al 12, separados por espacio) y el año, y el programa muestra el
  calendario de cada uno. Por ejemplo, escribiendo 1 2 3 y 2026 se ven enero, febrero y marzo de
  2026. Si algún mes no es válido, avisa y muestra igual los demás.
Opción 7: Archivo de log (historial)
  Registros entre dos fechas: muestra lo que se hizo en un período (fechas como aaaa-mm-dd ).
  Registros de un tipo de acción: por ejemplo, todas las veces que se creó un directorio.
  Acciones de un usuario: todo lo que hizo un usuario en particular.
  Eliminar el log: borra todo el historial. Solo se puede hacer ingresando la contraseña de
  autorización.

6. El archivo de historial (log)
Cada vez que alguien entra al menú o realiza una acción, el programa agrega una línea al archivo
acciones.log . Cada línea tiene cinco datos separados por | :

2026-10-25|19:52:34|usuario|1a|mkdir prueba

Dato | Qué significa
Fecha | El día en que se hizo la acción.
Hora | La hora exacta.
Usuario | Quién la hizo.
Acción | Un código formado por el número de la opción y la letra de la acción. Por
ejemplo, 1a es "crear directorio" y 3e es "eliminar persona de la agenda".
Comando Lo que se ejecutó. Si algo salió mal, se aclara entre paréntesis, por ejemplo
(error: ya existe).
Como se registran también los errores, el historial sirve no solo para ver lo que se hizo, sino también lo
que se intentó hacer y no funcionó.

7. Manejo de errores
El programa está pensado para que el usuario no se encuentre con mensajes confusos del sistema.
Antes de hacer una acción revisa que todo esté bien, y si algo falla muestra un mensaje claro en color
rojo. Algunos ejemplos:
Elegir una opción que no existe en el menú.
Querer crear una carpeta que ya existe, o borrar una que no existe.
Copiar o mover un archivo que no existe, o a un lugar donde no se tiene permiso.
Escribir una fecha de nacimiento con un formato incorrecto.
Buscar o eliminar a una persona con una CI que no está en la agenda.
Escribir permisos inválidos (por ejemplo 899 o letras que no sean r , w o x ).
Ingresar un mes que no esté entre 1 y 12.
Poner mal la contraseña para borrar el historial.
En ningún caso el programa se cierra por un error: muestra el aviso y deja volver a intentarlo.

9. Archivos del proyecto
Archivo Para qué sirve
Menu.sh El menú principal. Es el archivo que se ejecuta para iniciar el programa.
Opcion1.sh a Opcion7.sh Cada una de las siete opciones del menú, con su propio submenú.
funciones.sh Las partes que comparten todas las opciones: el encabezado, el pie, los
mensajes de error en rojo, la pausa y el registro en el log.
DatosPersonales.txt La agenda de personas. Se crea sola la primera vez que se agrega a alguien.
acciones.log El historial de acciones. Se crea solo la primera vez que se usa el programa.
Separar cada opción en su propio archivo hace que el programa sea más ordenado y fácil de mantener:
si hay que cambiar algo de la agenda, solo se toca el archivo de la opción 3.

11. Posibles mejoras
Seguridad
Pedir confirmación antes de eliminar una carpeta, un archivo o una persona de la agenda, para
evitar borrados por error. Esto es especialmente importante al borrar carpetas, ya que se elimina
todo su contenido.
Ocultar la contraseña mientras se escribe y guardarla fuera del código, para que no la pueda ver
cualquiera que abra los archivos.
Permitir borrar el historial solo a ciertos usuarios, además de pedir la contraseña.
Agenda
Evitar personas duplicadas: que no se pueda cargar dos veces la misma CI.
Validar mejor los datos: que la CI y el teléfono tengan solo números, y que la fecha de nacimiento
exista de verdad (hoy se acepta, por ejemplo, un 31/02).
Edad siempre actualizada: hoy la edad se calcula al cargar a la persona y queda fija. Podría
calcularse cada vez que se muestra la agenda.
Permitir modificar otros datos además del teléfono, y buscar personas por nombre o apellido.
Ordenar la agenda alfabéticamente o por edad.
Historial
Registrar también el borrado del log, para que quede constancia de quién lo borró y cuándo.
Registrar también cuando se elige una opción que no existe en los menús, que hoy no queda
guardado.
Revisar que las fechas ingresadas al filtrar el historial tengan el formato correcto.
Guardar una copia del historial antes de borrarlo.
Uso general
Poder ejecutarlo desde cualquier carpeta, no solo desde la del proyecto.
Mostrar un aviso cuando se elige una opción inválida en el calendario (hoy no muestra nada) y
validar el año ingresado.
Usar colores también para los mensajes de éxito (por ejemplo en verde), para que se distingan de
un vistazo.
Agregar más funciones, como buscar archivos por nombre, ver el espacio libre en disco o ver qué
programas se están ejecutando.

11. Conclusión
El proyecto reúne en un solo programa muchas de las tareas básicas de un sistema operativo Linux: el
manejo de carpetas, archivos y permisos, la consulta de la fecha y el calendario, y el trabajo con el
contenido de un archivo a través de la agenda. Todo se hace desde un menú simple, con mensajes
claros cuando algo sale mal y con un historial que registra cada acción.
Además de cumplir con lo pedido, el programa está organizado en partes separadas, lo que facilita
agregarle las mejoras mencionadas en el futuro.
