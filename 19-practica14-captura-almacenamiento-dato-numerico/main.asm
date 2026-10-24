; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 14 - Captura y almacenamiento de dato numerico
; Descripcion: pide una cantidad del 1 al 99 valida que sean puros numeros y la suma a la existencia

INCLUDE Irvine32.inc

.data
    promptMsg         BYTE "Ingrese la cantidad recibida (1-99): ", 0
    errorMsg          BYTE "Error de entrada intente de nuevo", 0
    msgExistencia     BYTE "Existencia actual: ", 0

    buffer            BYTE 10 DUP(0)
    cantidadRecibida  DWORD ?
    existenciaInicial DWORD 25
    existenciaActual  DWORD ?
    outBuffer         BYTE 10 DUP(0)

.code
main PROC
PedirDatos:
    mov edx, OFFSET promptMsg
    call WriteString

    mov edx, OFFSET buffer
    mov ecx, SIZEOF buffer
    call ReadString

    ; eax trae cuantos caracteres leyo ReadString
    cmp eax, 0
    je ErrorEntrada
    cmp eax, 2
    ja ErrorEntrada             ; no dejamos meter mas de 2 digitos

    mov esi, OFFSET buffer
    mov ecx, eax                ; usamos exactamente los caracteres que se leyeron

ValidarCaracteres:
    mov al, [esi]
    cmp al, '0'                ; checamos que cada caracter sea un digito valido del 0 al 9
    jb ErrorEntrada
    cmp al, '9'
    ja ErrorEntrada
    inc esi
    loop ValidarCaracteres

    ; ahora convertimos el texto que escribio el usuario a un numero de verdad
    mov esi, OFFSET buffer
    mov eax, 0
    mov ebx, 10
    mov ecx, 2                    ; maximo 2 digitos

ConvertLoop:
    movzx edx, BYTE PTR [esi]
    cmp dl, 0
    je FinConversion
    cmp dl, 0Dh                      ; por si queda algun retorno de carro
    je FinConversion
    cmp dl, 0Ah                         ; por si queda un salto de linea
    je FinConversion
    sub dl, '0'                            ; quitamos el 48 para dejar el valor numerico real
    mul ebx                                   ; recorremos una posicion decimal
    add eax, edx
    inc esi
    loop ConvertLoop

FinConversion:
    cmp eax, 1                  ; validamos que la cantidad este en el rango permitido
    jb ErrorEntrada
    cmp eax, 99
    ja ErrorEntrada

    mov cantidadRecibida, eax
    mov ebx, existenciaInicial
    add eax, ebx
    mov existenciaActual, eax

    mov edx, OFFSET msgExistencia
    call WriteString

    mov eax, existenciaActual
    mov edi, OFFSET outBuffer
    call ConvDwordToString          ; convertimos el resultado de vuelta a texto para mostrarlo

    mov edx, OFFSET outBuffer
    call WriteString
    call Crlf
    jmp FinProg

ErrorEntrada:
    call Crlf
    mov edx, OFFSET errorMsg
    call WriteString
    call Crlf
    jmp PedirDatos               ; si hubo error se vuelve a pedir el dato

FinProg:
    exit
main ENDP

; ===================================================
; convierte el numero que trae eax a texto decimal
; entra: eax = numero   edi = donde se va a escribir el texto
; ===================================================
ConvDwordToString PROC
    pushad                   ; esto guarda todos los registros generales de un jalon

    mov ecx, 0
    mov ebx, 10
DivLoop:
    mov edx, 0
    div ebx
    add dl, '0'
    push edx
    inc ecx
    cmp eax, 0
    jne DivLoop

PopLoop:
    pop edx
    mov [edi], dl
    inc edi
    loop PopLoop

    mov BYTE PTR [edi], 0
    popad                        ; restauramos todos los registros en el orden inverso
    ret
ConvDwordToString ENDP

END main
