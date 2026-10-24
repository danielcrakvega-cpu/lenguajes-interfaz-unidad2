; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 03 - Comparacion y prueba
; Descripcion: ver como CMP y TEST cambian las banderas eflags en distintos casos

INCLUDE Irvine32.inc

.code
main PROC
    ; caso 1 dos numeros iguales
    mov eax, 10h
    cmp eax, 10h          ; como son iguales se activa la zero flag
    call DumpRegs            ; dumpregs muestra los registros y las banderas

    ; caso 2 numero negativo contra positivo
    mov eax, 0
    mov ebx, 0
    mov al, -5
    mov bl, 1
    cmp al, bl
    call DumpRegs

    ; caso 3 carry flag al comparar sin signo
    mov eax, 0
    mov ebx, 0
    mov al, 5
    mov bl, 10
    cmp al, bl               ; al es menor que bl entonces se  activa el cary flag
    call DumpRegs

    ; caso 4 overflow con signo
    mov eax, 0
    mov ebx, 0
    mov al, -128
    mov bl, 1
    cmp al, bl                  ; a qui se desborda el rango de un byte con signo
    call DumpRegs

    ; caso 5 test
    ; test hace un and por dentro pero no guarda el resultado solo mueve las  banderas
    mov eax, 5
    test eax, 1                   ; sirve para  saber si un numero es par o impar
    call DumpRegs

    ; 00000101   <- el 5
    ; 00000001   <- el 1
    ; --------
    ; 00000001   <- como no da puro cero la zero flag queda en 0 osea 5 es  impar

    exit
main ENDP
END main
