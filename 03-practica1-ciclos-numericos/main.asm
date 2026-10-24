; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 01 - Ciclos numericos
; Descripcion: repetir un mensaje varias veces usando un ciclo con loop

INCLUDE Irvine32.inc

.data
mensaje BYTE "Hola, mundo!", 0

.code
main PROC
    mov ecx, 5                 ; ecx es el contador del ciclo va a repetir 5 veces
    mov edx, OFFSET mensaje    ; edx apunta al mensaje que vamos a imprimir

ciclo:
    call WriteString       ; imprime el mensaje
    call Crlf              ; salto de linea
    loop ciclo              ; resta 1 a ecx y si no es 0 regresa a la etiqueta ciclo

    exit
main ENDP
END main
