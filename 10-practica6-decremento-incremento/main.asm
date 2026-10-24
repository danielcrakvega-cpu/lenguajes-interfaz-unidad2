; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 06 - Decremento e incremento
; Descripcion: control de acceso con pin usando dec para contar los intentos restantes

INCLUDE Irvine32.inc

.data
msgPIN      BYTE "Ingrese el PIN de acceso: ", 0
msgError    BYTE "***PIN INCORRECTO***", 0
msgAcceso   BYTE "ACCESO PERMITIDO.", 0
msgIntentos BYTE "Intentos restantes: ", 0
msgBloqueo  BYTE "Se bloqueo el sistema por exceso de intentos", 0

pinCorrecto = 1234

.code
main PROC
    mov ebx, 3          ; empezamos con 3 intentos 

inicio:
    mov edx, OFFSET msgPIN
    call WriteString
    call ReadInt
    call Crlf
    cmp eax, pinCorrecto

    je acceso                ; si el pin es correcto nos vamos directo a acceso

    DEC ebx                     ; si fallo le quitamos un intento
    mov edx, OFFSET msgError
    call WriteString
    call Crlf

    mov edx, OFFSET msgIntentos
    call WriteString
    mov eax, ebx
    call WriteDec
    call Crlf

    cmp ebx, 0
    je bloqueo             ; si ya no quedan intentos se bloquea
    jmp inicio                ; si todavia hay intentos volvemos a pedir el pin

acceso:
    mov edx, OFFSET msgAcceso
    call WriteString
    call Crlf
    exit

bloqueo:
    mov edx, OFFSET msgBloqueo
    call WriteString
    call Crlf
    exit

main ENDP
END main
