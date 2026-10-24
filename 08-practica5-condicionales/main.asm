; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 05 - Condicionales
; Descripcion: pide una calificacion y dice si es reprobado regular o buena usando if y else

INCLUDE Irvine32.inc

.data
msgPedir    BYTE "Ingresa tu calificacion de 0 a 10: ", 0
msgRepro    BYTE "Estas reprobado", 0
msgRegular  BYTE "Vas regular todavia puedes subir", 0
msgBuena    BYTE "Vas muy bien sigue asi", 0

calif DWORD ?

.code
main PROC
    mov edx, OFFSET msgPedir
    call WriteString
    call ReadInt            ; el numero que escribe el usuario llega en eax
    mov calif, eax
    call Crlf

    mov eax, calif

    ; primer if calificacion menor a 6 es reprobado
    cmp eax, 6
    jl esReprobado

    ; segundo if calificacion entre 6 y 8 es regular
    cmp eax, 8
    jle esRegular

    ; si no cayo en ninguno de los anteriores entonces es buena
    jmp esBuena

esReprobado:
    mov edx, OFFSET msgRepro
    call WriteString
    jmp finPrograma

esRegular:
    mov edx, OFFSET msgRegular
    call WriteString
    jmp finPrograma

esBuena:
    mov edx, OFFSET msgBuena
    call WriteString

finPrograma:
    call Crlf
    exit
main ENDP
END main
