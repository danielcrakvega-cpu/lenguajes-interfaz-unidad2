; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 02 - Captura y desplegado de mensaje
; Descripcion: pide al usuario su nombre lo guarda y luego lo muestra en pantalla

INCLUDE Irvine32.inc

.data
mensajeEntrada     BYTE "Escribe tu nombre: ", 0
nombre             BYTE 30 DUP(0)              ; buffer donde se va a guardar lo que escriba el usuario
msgCaracteres      BYTE "Numero de caracteres escritos: ", 0
msgSaludo          BYTE "Mucho gusto, ", 0

.code
main PROC
    ; pedimos el nombre
    mov edx, OFFSET mensajeEntrada
    call WriteString

    mov edx, OFFSET nombre        ; edx apunta al buffer donde se va a guardar
    mov ecx, SIZEOF nombre           ; ecx le dice a ReadString cuanto espacio tiene el buffer
    call ReadString                     ; lee lo que escribe el usuario desde el teclado

    ; ReadString regresa en eax cuantos caracteres se escribieron de verdad
    mov edx, OFFSET msgCaracteres
    call WriteString
    call WriteDec               ; imprime el valor de eax osea los caracteres leidos
    call Crlf
    call Crlf

    ; mostramos el nombre que capturamos
    mov edx, OFFSET msgSaludo
    call WriteString
    mov edx, OFFSET nombre
    call WriteString
    call Crlf

    exit
main ENDP
END main
