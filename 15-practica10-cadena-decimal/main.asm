; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 10 - Obtencion de una cadena decimal
; Descripcion: convierte un numero a su texto decimal usando div y la pila sin usar writedec
; aqui convertimos un numero a texto decimal usando nuestro propio
; procedimiento convertirDecimal en vez de WriteDec

INCLUDE Irvine32.inc

.data
    ; datos del problema del archivo
    tamArchivo DWORD 100000
    bloques DWORD 125
    tamBloque DWORD 512

    ; resultados
    descargados DWORD ?
    pendientes DWORD ?
    porcentaje DWORD ?
    grupos DWORD ?
    residuo DWORD ?

    ; mensajes
    msg1 BYTE "Bytes descargados: ",0
    msg2 BYTE "Bytes pendientes: ",0
    msg3 BYTE "Porcentaje de avance: ",0
    msg4 BYTE "Grupos completos de 1024: ",0
    msg5 BYTE "Residuo del agrupamiento: ",0
    salto BYTE 13,10,0

    ; buffer de 11 bytes para el texto convertido
    buffer BYTE 11 DUP(0)

.code

; convierte el numero en eax a texto decimal
; eax = numero
; esi = direccion del buffer

convertirDecimal PROC
    push eax
    push ebx
    push ecx
    push edx
    push edi

    mov edi, esi
    add edi, 10
    mov BYTE PTR [edi], 00h       ; ponemos el terminador nulo al final del buffer

    mov ebx, 10

    cmp eax, 0
    jne convertir

    dec edi
    mov BYTE PTR [edi], '0'       ; caso especial si el numero es 0
    jmp terminado

convertir:
    xor edx, edx
    div ebx                         ; eax/10 el cociente queda en eax y el residuo en edx

    add dl, '0'                       ; convertimos el digito a su caracter ascii
    dec edi
    mov [edi], dl

    cmp eax, 0
    jne convertir                       ; repetimos mientras el cociente no sea 0

terminado:
    ; aqui movemos los digitos al inicio del buffer
    mov esi, edi
    mov ecx, 0

contar:
    cmp BYTE PTR [esi+ecx], 0
    je copiarInicio
    inc ecx
    jmp contar

copiarInicio:
    mov edi, OFFSET buffer
    inc ecx
    cld
    rep movsb                          ; copia ecx bytes de esi a edi de un jalon

    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
convertirDecimal ENDP

main PROC

    ; 1 bytes descargados
    mov eax, bloques
    mul tamBloque
    mov descargados, eax

    ; 2 bytes pendientes
    mov eax, tamArchivo
    sub eax, descargados
    mov pendientes, eax

    ; 3 porcentaje entero
    mov eax, descargados
    mov ebx, 100
    mul ebx
    mov ebx, tamArchivo
    div ebx
    mov porcentaje, eax

    ; 4 grupos de 1024 y residuo
    mov eax, descargados
    xor edx, edx
    mov ebx, 1024
    div ebx
    mov grupos, eax
    mov residuo, edx

    ; mostrar bytes descargados
    mov edx, OFFSET msg1
    call WriteString
    mov eax, descargados
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; mostrar bytes pendientes
    mov edx, OFFSET msg2
    call WriteString
    mov eax, pendientes
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; mostrar porcentaje
    mov edx, OFFSET msg3
    call WriteString
    mov eax, porcentaje
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    mov edx, OFFSET salto
    call WriteString

    ; mostrar grupos completos
    mov edx, OFFSET msg4
    call WriteString
    mov eax, grupos
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; mostrar residuo
    mov edx, OFFSET msg5
    call WriteString
    mov eax, residuo
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    exit

main ENDP
END main
