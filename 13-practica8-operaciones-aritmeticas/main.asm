; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 08 - Operaciones aritmeticas
; Descripcion: ejemplos de add sub mul imul div e idiv viendo como afectan a las banderas

INCLUDE Irvine32.inc

.data
msg1 BYTE "ADD y SUB resultado: ", 0
msg2 BYTE "Suma que genera carry flag: ", 0
msg3 BYTE "Suma que genera overflow: ", 0
msg4 BYTE "MUL producto dentro de 32 bits: ", 0
msg5 BYTE "IMUL producto con signo: ", 0
msg6 BYTE "DIV cociente sin signo: ", 0
msg7 BYTE "IDIV cociente con signo: ", 0

.code
main PROC
    ; 1 - ADD y SUB
    mov eax, 50
    mov ebx, 20
    add eax, ebx
    sub eax, 15          ; eax = 50+20-15 = 55
    mov edx, OFFSET msg1
    call WriteString
    call WriteDec
    call Crlf

    ; 2 - CF acarreo en una suma sin signo
    mov eax, 0
    mov al, 255
    add al, 1              ; se pasa del limite de un byte asi que se activa el carry flag
    mov edx, OFFSET msg2
    call WriteString
    call WriteDec
    call Crlf
    call DumpRegs

    ; 3 - OF desbordamiento en una suma con signo
    mov eax, 0
    mov al, 127
    add al, 1                ; se pasa del maximo positivo con signo de un byte asi que se activa overflow
    mov edx, OFFSET msg3
    call WriteString
    call WriteInt             ; writeint porque el resultado puede verse como negativo
    call Crlf
    call DumpRegs

    ; 4 - MUL producto dentro de 32 bits
    mov eax, 65532
    mov ebx, 65532
    mul ebx                    ; el resultado se guarda en EDX:EAX
    mov edx, OFFSET msg4
    call WriteString
    call WriteDec
    call Crlf

    ; IMUL producto con signo
    mov eax, -5
    imul eax, eax, 3
    mov edx, OFFSET msg5
    call WriteString
    call WriteInt
    call Crlf

    ; 5 - DIV dividiendo valores pequeños sin signo
    mov eax, 125
    mov edx, 0            ; edx en 0 porque es division sin signo
    mov ebx, 12
    div ebx                   ; eax = cociente edx = residuo
    mov ecx, eax           ; guardamos el cociente antes de usar edx para imprimir
    mov edx, OFFSET msg6
    call WriteString
    mov eax, ecx
    call WriteDec
    call Crlf

    ; 6 - IDIV y CDQ division con signo
    mov eax, -125
    cdq                    ; extiende el signo de eax hacia edx antes de dividir
    mov ebx, 12
    idiv ebx                  ; eax = cociente con signo
    mov edx, OFFSET msg7
    call WriteString
    call WriteInt
    call Crlf

    exit
main ENDP
END main
