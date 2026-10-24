; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 06.1 - Control de ocupacion de un estacionamiento
; Descripcion: simula un estacionamiento donde se pueden meter y sacar autos usando inc y dec

INCLUDE Irvine32.inc

.data
msgInicial         BYTE "BIENVENIDO AL SISTEMA GESTOR DEL ESTACIONAMIENTO", 0
msgEspaciosLibres  BYTE "Cantidad de espacios libres actualmente: ", 0
msgLleno           BYTE "NO SE PUEDE INGRESAR EL ESTACIONAMIENTO ESTA LLENO", 0
msgCerrar          BYTE "El programa se cerrara gracias por usar el sistema", 0
msgInstruccion     BYTE "Ingresa 1 para meter un auto 2 para sacar un auto y 0 para salir", 0
msgVacio           BYTE "NO PUEDE SACAR MAS AUTOS EL ESTACIONAMIENTO ESTA VACIO", 0

espaciosMaximos = 10
espaciosLibres DWORD ?

.code
main PROC
    mov espaciosLibres, espaciosMaximos     ; al inicio todos los espacios estan libres

    mov edx, OFFSET msgInicial
    call WriteString
    call Crlf

Ciclo:
    mov edx, OFFSET msgEspaciosLibres
    call WriteString
    mov eax, espaciosLibres
    call WriteDec
    call Crlf

    mov edx, OFFSET msgInstruccion
    call WriteString
    call Crlf
    call ReadInt

    cmp eax, 1
    je Agregar
    cmp eax, 2
    je Quitar
    jmp Salir                 ; cualquier otra cosa que no sea 1 o 2 cierra el programa

Agregar:
    cmp espaciosLibres, 0
    je Lleno
    DEC espaciosLibres          ; entra un auto entonces baja el contador
    jmp Ciclo

Lleno:
    mov edx, OFFSET msgLleno
    call WriteString
    call Crlf
    jmp Ciclo

Vacio:
    mov edx, OFFSET msgVacio
    call WriteString
    call Crlf
    jmp Ciclo

Quitar:
    cmp espaciosLibres, espaciosMaximos
    je Vacio
    INC espaciosLibres              ; sale un auto entonces sube el contador
    jmp Ciclo

Salir:
    mov edx, OFFSET msgCerrar
    call WriteString
    call Crlf
    exit

main ENDP
END main
