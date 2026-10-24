; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 09 - Push y Pop
; Descripcion: mete numeros a la pila y los saca para ver el orden LIFO con call y ret

INCLUDE Irvine32.inc

.data
msgMeter BYTE "Metiendo a la pila en orden 1 2 3 4 ...", 0
msgSacar BYTE "Sacando de la pila (deberian salir al reves) ...", 0

.code

; ===================================================
; procedimiento que mete los 4 valores a la pila
; ===================================================
MeterValores PROC
    mov eax, 1
    push eax             ; pila: [1]

    mov eax, 2
    push eax                ; pila: [1,2]

    mov eax, 3
    push eax                  ; pila: [1,2,3]

    mov eax, 4
    push eax                    ; pila: [1,2,3,4]  el 4 queda hasta arriba

    ret                             ; regresa al lugar donde se llamo
MeterValores ENDP


; ===================================================
; procedimiento que saca los 4 valores y los imprime
; ===================================================
SacarValores PROC
    pop eax           ; saca el 4 que es el ultimo que entro osea LIFO
    call WriteDec
    call Crlf

    pop eax              ; saca el 3
    call WriteDec
    call Crlf

    pop eax                 ; saca el 2
    call WriteDec
    call Crlf

    pop eax                    ; saca el 1 el primero que entro sale al final
    call WriteDec
    call Crlf

    ret
SacarValores ENDP


main PROC
    mov edx, OFFSET msgMeter
    call WriteString
    call Crlf

    call MeterValores          ; aqui se meten los 4 numeros a la pila

    mov edx, OFFSET msgSacar
    call WriteString
    call Crlf

    call SacarValores             ; aqui se sacan en orden inverso 4 3 2 1

    exit
main ENDP
END main
