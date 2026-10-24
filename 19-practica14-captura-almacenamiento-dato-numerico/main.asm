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
    
    ; eax trae cuantos caracteres leyo readstring
    cmp eax, 0
    je ErrorEntrada
    cmp eax, 2
    ja ErrorEntrada             ; si metio mas de 2 digitos es invalido

    mov esi, OFFSET buffer
    mov ecx, eax            ; usamos exactamente la cantidad de caracteres leidos
ValidarCaracteres:
    mov al, [esi]
    cmp al, '0'
    jb ErrorEntrada
    cmp al, '9'
    ja ErrorEntrada               ; checamos que cada caracter sea un digito
    inc esi
    loop ValidarCaracteres

    mov esi, OFFSET buffer
    mov eax, 0
    mov ebx, 10
    mov ecx, 2              ; maximo 2 digitos
ConvertLoop:
    movzx edx, BYTE PTR [esi]
    cmp dl, 0
    je FinConversion
    cmp dl, 0Dh             ; ignoramos retorno de carro
    je FinConversion
    cmp dl, 0Ah             ; ignoramos salto de linea
    je FinConversion
    sub dl, '0'
    mul ebx
    add eax, edx
    inc esi
    loop ConvertLoop

FinConversion:
    cmp eax, 1
    jb ErrorEntrada
    cmp eax, 99
    ja ErrorEntrada                ; el numero tiene que estar entre 1 y 99

    mov cantidadRecibida, eax
    mov ebx, existenciaInicial
    add eax, ebx                      ; sumamos lo recibido a la existencia inicial
    mov existenciaActual, eax

    mov edx, OFFSET msgExistencia
    call WriteString

    mov eax, existenciaActual
    mov edi, OFFSET outBuffer
    call ConvDwordToString               ; convertimos el resultado a texto

    mov edx, OFFSET outBuffer
    call WriteString
    call Crlf
    jmp FinProg

ErrorEntrada:
    call Crlf
    mov edx, OFFSET errorMsg
    call WriteString
    call Crlf
    jmp PedirDatos                          ; si hubo error volvemos a pedir el dato

FinProg:
    exit
main ENDP

; convierte un dword a su texto decimal
ConvDwordToString PROC
    pushad                     ; guarda todos los registros de un jalon
    mov ecx, 0
    mov ebx, 10
DivLoop:
    mov edx, 0
    div ebx
    add dl, '0'
    push edx                      ; metemos cada digito a la pila
    inc ecx
    cmp eax, 0
    jne DivLoop
PopLoop:
    pop edx                         ; sacamos en orden correcto por el lifo
    mov [edi], dl
    inc edi
    loop PopLoop
    mov BYTE PTR [edi], 0
    popad                              ; regresa todos los registros
    ret
ConvDwordToString ENDP

END main
