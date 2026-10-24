; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 02 - Hola mundo con Visual Studio 2022 e Irvine32
; Descripcion: hola mundo clasico usando la libreria irvine32

INCLUDE Irvine32.inc

.data
mensaje BYTE "Hola, Mundo!", 0     ; texto que se va a mostrar en consola

.code
main PROC
    mov edx, OFFSET mensaje    ; edx tiene que apuntar al texto que quiero imprimir
    call WriteString              ; esta funcion de irvine imprime lo que apunta edx
    call Crlf                        ; salto de linea

    exit                                 ; termina el programa 
main ENDP
END main
