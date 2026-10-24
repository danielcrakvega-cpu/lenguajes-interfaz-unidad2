; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 13 - Obtencion de una cadena hexadecimal
; Descripcion: convierte un numero de 32 bits a su texto hexadecimal usando AND y SHR

; nota el buffer bufferHex no estaba declarado en el original se agrego aqui

INCLUDE Irvine32.inc

.data
    bufferHex BYTE 9 DUP(0)        ; 8 digitos hex mas el terminador nulo

.code
main PROC
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0

   
   mov eax, 2ab34cd0h          ; numero de ejemplo que vamos a convertir
    mov esi, 7                    ; esi arranca en la posicion 7 del buffer
    mov ecx, 8                      ; vamos a sacar 8 digitos en total

L1:

    mov ebx, eax
    and ebx, 0Fh               ; nos quedamos solo con el nibble de abajo

    cmp ebx, 10
    jl EsNumero
    add ebx, 7                     ; si es de la a a la f le sumamos 7 extra

EsNumero:
    add ebx, '0'                      ; convertimos a su caracter ascii
    mov bufferHex[esi], bl             ; lo guardamos en la posicion actual
    shr eax, 4                           ; recorremos el numero para el siguiente nibble

    dec esi                                ; bajamos una posicion en el buffer
    loop L1

    mov edx, OFFSET bufferHex
    call WriteString
    call Crlf

    call DumpRegs
    

main ENDP

END main
