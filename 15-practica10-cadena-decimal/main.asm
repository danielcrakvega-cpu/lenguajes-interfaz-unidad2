; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 10 - Obtencion de una cadena decimal
; Descripcion: convierte un numero a su texto decimal usando div y la pila sin usar writedec

INCLUDE Irvine32.inc

.data
msgResultado BYTE "El numero convertido a texto es: ", 0
buffer       BYTE 11 DUP(0)     ; 10 digitos como maximo mas el terminador nulo

.code
main PROC
    mov eax, 64000           ; numero de prueba lo puedes cambiar
    mov esi, OFFSET buffer

    call convertirDecimal

    mov edx, OFFSET msgResultado
    call WriteString
    mov edx, OFFSET buffer
    call WriteString              ; aqui mostramos el texto ya convertido sin usar writedec
    call Crlf

    exit
main ENDP


; ===================================================
; convertirDecimal convierte el numero que trae eax en texto
; entra:  eax = numero   esi = direccion del buffer destino
; usa:    div residuos y la pila con push pop
; ===================================================
convertirDecimal PROC
    push eax
    push ebx
    push ecx
    push edx
    push edi

    mov ebx, 10          ; vamos a dividir el numero entre 10 cada vuelta
    mov ecx, 0              ; aqui contamos cuantos digitos vamos sacando

dividir:
    mov edx, 0
    div ebx                 ; eax/10 -> eax queda con el cociente y edx con el residuo
    add edx, 48                ; el residuo es un numero del 0 al 9 le sumamos 48 para volverlo caracter ascii
    push edx                     ; guardamos ese caracter en la pila
    inc ecx                        ; contamos un digito mas
    cmp eax, 0
    jnz dividir                      ; si el cociente no es 0 todavia faltan digitos

    mov edi, esi         ; edi va a apuntar donde se va escribiendo el texto final
sacar:
    pop edx                 ; sacamos el ultimo que entro como es LIFO sale en el orden correcto
    mov [edi], dl
    inc edi
    loop sacar                 ; se repite ecx veces osea los mismos digitos que contamos arriba

    mov BYTE PTR [edi], 0    ; terminador nulo al final del texto

    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
convertirDecimal ENDP

END main
