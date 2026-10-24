; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 07 - Validacion de formato
; Descripcion: valida que una cadena tenga el formato ABC-123 tres letras guion y tres numeros

INCLUDE Irvine32.inc

.data
codigo      BYTE 8 DUP(0)
msgError    BYTE "CADENA INVALIDA INTENTE DE NUEVO", 0
msgInicial  BYTE "Ingrese un codigo de 7 caracteres ejemplo ABC-123", 0
msgValido   BYTE "SU CADENA ES VALIDA", 0

.code
main PROC
ciclar:
    mov ESI, 0                     ; esi es el indice que recorre la cadena
    mov edx, OFFSET msgInicial
    call WriteString
    call Crlf
    mov edx, OFFSET codigo
    mov ecx, SIZEOF codigo
    call ReadString

validacion:
    mov AL, codigo[ESI]       ; tomamos el caracter en la posicion actual

    ; posiciones 0 1 2 deben ser letras
    cmp ESI, 3
    jl letras
    je guion                    ; posicion 3 debe ser el guion
    cmp ESI, 6
    jg fin                          ; si ya llegamos a la posicion 7 terminamos bien
    jmp digitos                       ; posiciones 4 5 6 deben ser numeros

letras:
    cmp al, 65            ; 65 es la A en ascii
    jl error
    cmp al, 90               ; 90 es la Z en ascii
    jg error
    INC ESI
    jmp validacion

guion:
    cmp al, 45              ; 45 es el guion en ascii
    jne error
    INC ESI
    jmp validacion

digitos:
    cmp al, 48           ; 48 es el 0 en ascii
    jl error
    cmp al, 57              ; 57 es el 9 en ascii
    jg error
    INC ESI
    jmp validacion

error:
    mov edx, OFFSET msgError
    call WriteString
    call Crlf
    jmp ciclar

fin:
    mov edx, OFFSET msgValido
    call WriteString
    call Crlf
    exit

main ENDP
END main
