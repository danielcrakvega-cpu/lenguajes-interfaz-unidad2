; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 12 - Desplazamiento y rotacion
; Descripcion: ejemplos de SHL SHR SAR y las 4 rotaciones ROL ROR RCL RCR

INCLUDE Irvine32.inc

.code
main PROC
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0

    ; 1 - SHL desplazar una posicion a la izquierda
    mov al, 10000000b
    shl al, 1              ; el bit que se sale por la izquierda se pierde
    call DumpRegs
    call WriteBin

    ; 2 - SHR desplazar una posicion a la derecha
    mov al, 00001101b
    shr al, 1
    call DumpRegs
    call WriteBin

    ; 3 - SAR conserva el signo al desplazar a la derecha
    mov al, -8
    sar al, 1              ; a diferencia de shr sar respeta el bit de signo
    call DumpRegs
    call WriteBin

    ; 4 - SAR con una operacion que no es exacta
    mov al, -9
    sar al, 1
    call DumpRegs
    call WriteBin

    ; 5 - desplazar 2 bits a la izquierda de un jalon
    mov al, 00001111b
    shl al, 2
    call WriteBin
    call DumpRegs

    ; 6 - desplazar usando CL como cantidad de bits
    mov al, 00001111b
    mov cl, 2
    shr al, cl
    call WriteBin
    call DumpRegs

    ; 7 - rotaciones ROL ROR RCL y RCR

    ; ROL rota a la izquierda el bit que sale entra por el otro lado
    mov al, 10010001b
    rol al, 1
    call WriteBin
    call DumpRegs

    ; ROR rota a la derecha el bit que sale entra por el otro lado
    mov al, 10010001b
    ror al, 1
    call WriteBin
    call DumpRegs

    ; RCL rota a la izquierda pero incluyendo el carry flag en la rotacion
    clc                      ; limpiamos el carry antes de empezar para que no traiga basura
    mov al, 10010001b
    rcl al, 1
    call WriteBin
    call DumpRegs

    ; RCR rota a la derecha pero incluyendo el carry flag en la rotacion
    clc
    mov al, 10010001b
    rcr al, 1
    call WriteBin
    call DumpRegs

    exit
main ENDP

END main
