; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 04 - Saltos
; Descripcion: ejemplo de salto incondicional jmp y de salto condicional je por igualdad

INCLUDE Irvine32.inc

.data
msgIguales    BYTE "Los valores son iguales", 0
msgDiferentes BYTE "Los valores son diferentes", 0

.code
main PROC
    ; ---------------------------------
    ; parte 1 salto incondicional JMP
    ; ---------------------------------
    mov eax, 5
    jmp continuar          ; jmp siempre salta sin revisar nada
    mov eax, 10             ; esta linea nunca se ejecuta por el jmp de arriba

continuar:
    call DumpRegs              ; aqui eax todavia vale 5

    ; ---------------------------------
    ; parte 2 salto condicional por igualdad
    ; ---------------------------------
    mov eax, 4
    mov ebx, 2

    cmp eax, ebx          ; compara eax contra ebx se enciende la zero flag si son iguales

    je iguales                ; si eax es igual a ebx salta a iguales
    mov edx, OFFSET msgDiferentes
    call WriteString
    jmp fin

iguales:
    mov edx, OFFSET msgIguales
    call WriteString

fin:
    call Crlf
    exit
main ENDP
END main
