; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 04.1 - Mayor menor o igual con entrada del usuario
; Descripcion: pide dos numeros al usuario y dice cual es mayor menor o si son iguales

INCLUDE Irvine32.inc

.data
mensajeNum1 BYTE "Ingrese el num1: ", 0
mensajeNum2 BYTE "Ingrese el num2: ", 0
msgmayor    BYTE "El num1 es mayor", 0
msgmenor    BYTE "El num1 es menor", 0
msgigual    BYTE "Los numeros son iguales", 0

num1 DWORD ?
num2 DWORD ?

.code
main PROC
    ; pedimos el primer numero
    mov edx, OFFSET mensajeNum1
    call WriteString
    call ReadInt           ; readint regresa el numero capturado en eax
    mov num1, eax
    call Crlf

    ; pedimos el segundo numero
    mov edx, OFFSET mensajeNum2
    call WriteString
    call ReadInt
    mov num2, eax
    call Crlf

    mov eax, num1
    mov ebx, num2

    cmp eax, ebx       ; comparamos num1 contra num2

    jg mayor               ; si num1 > num2
    jl menor                ; si num1 < num2
    je igual                 ; si num1 = num2

mayor:
    mov edx, OFFSET msgmayor
    call WriteString
    jmp fin

menor:
    mov edx, OFFSET msgmenor
    call WriteString
    jmp fin

igual:
    mov edx, OFFSET msgigual
    call WriteString
    jmp fin

fin:
    call Crlf
    exit
main ENDP
END main
