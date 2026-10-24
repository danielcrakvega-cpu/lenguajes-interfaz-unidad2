; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 05.1 - Repetir hasta que el usuario ingrese cero
; Descripcion: pide numeros uno por uno y los va sumando hasta que el usuario meta un 0

INCLUDE Irvine32.inc

.data
msgPedir BYTE "Dame un numero (ingresa 0 para terminar): ", 0
msgTotal BYTE "La suma total de todos los numeros fue: ", 0

suma DWORD 0      ; aqui vamos guardando el acumulado

.code
main PROC

pedirNumero:
    mov edx, OFFSET msgPedir
    call WriteString
    call ReadInt              ; el numero capturado llega en eax
    call Crlf

    cmp eax, 0                   ; si el usuario metio 0 ya terminamos el ciclo
    je terminarCiclo

    add suma, eax                  ; si no es 0 lo sumamos al acumulado
    jmp pedirNumero                   ; y volvemos a pedir otro numero

terminarCiclo:
    mov edx, OFFSET msgTotal
    call WriteString
    mov eax, suma
    call WriteDec
    call Crlf

    exit
main ENDP
END main
