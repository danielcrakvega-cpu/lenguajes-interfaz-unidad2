; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 11 - Operaciones logicas
; Descripcion: simula un estado de un dispositivo con bits usando AND OR XOR NOT y TEST

INCLUDE Irvine32.inc

.code
main PROC

    ; bit 0 - encendido
    ; bit 1 - alarma
    ; bit 2 - conectada
    ; estado inicial 00000101 eso significa encendido = 1 y conectada = 1

    ; 1 - AND sirve para extraer un bit especifico osea apagar todo lo demas
    mov eax, 0
    mov ebx, 0
    mov al, 00000101b
    mov bl, al
    and bl, 00000001b          ; nos quedamos solo con el bit de encendido
    call DumpRegs
    nop

    ; 2 - OR sirve para prender un bit sin tocar los demas
    mov al, 00000101b
    or al, 00000010b              ; prendemos la alarma sin apagar lo que ya estaba
    call DumpRegs
    nop

    ; 3 - XOR sirve para invertir un bit especifico
    mov al, 00000101b
    xor al, 00000100b                ; invierte el bit de conectada
    call DumpRegs
    nop

    ; 4 - NOT invierte todos los bits del registro
    mov al, 00000101b
    not al                               ; voltea todos los bits al mismo tiempo
    call DumpRegs
    nop

    ; 5 - TEST sirve para revisar un bit sin modificar el valor original
    mov al, 00000101b
    test al, 00000010b                       ; revisamos si el bit de alarma esta prendido
    call DumpRegs                                ; como dio puro cero la zero flag se activa

    exit
main ENDP

END main
