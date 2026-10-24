; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 13 - Obtencion de una cadena hexadecimal
; Descripcion: convierte un numero de 32 bits a su texto hexadecimal usando AND y SHR

INCLUDE Irvine32.inc

.data
bufferHex BYTE 9 DUP(0)     ; 8 digitos hexadecimales mas el terminador nulo
msgResultado BYTE "Numero en hexadecimal: ", 0

.code
main PROC
    mov eax, 2AB34CD0h       ; numero de prueba lo puedes cambiar
    mov esi, 7                 ; esi empieza en la posicion 7 osea el ultimo digito de la cadena
    mov ecx, 8                    ; un numero de 32 bits tiene 8 nibbles osea 8 digitos hex

L1:
    mov ebx, eax
    and ebx, 0Fh             ; nos quedamos solo con los ultimos 4 bits osea un digito

    cmp ebx, 10
    jl EsNumero
    add ebx, 7                   ; si es una letra le sumamos 7 extra para que caiga en la A-F

EsNumero:
    add ebx, '0'              ; convertimos a caracter ascii
    mov bufferHex[esi], bl       ; lo escribimos en su posicion dentro del buffer

    shr eax, 4                      ; recorremos el numero para dejar listo el siguiente digito

    dec esi                            ; retrocedemos una posicion en el buffer
    loop L1                               ; se repite 8 veces

    mov edx, OFFSET msgResultado
    call WriteString
    mov edx, OFFSET bufferHex
    call WriteString
    call Crlf

    call DumpRegs

    exit
main ENDP

END main
