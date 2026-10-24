; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 15 - Manipulacion de archivo
; Descripcion: crea un archivo le escribe un texto lo cierra lo vuelve a abrir y muestra lo que tiene

INCLUDE Irvine32.inc

.data
nombreArchivo  BYTE "miarchivo.txt", 0
texto          BYTE "Hola este es un archivo de prueba", 0
buffer         BYTE 100 DUP(0)     ; aqui se va a guardar lo que leamos del archivo

.code
main PROC

    ; creamos el archivo osea si ya existia lo sobreescribe
    mov edx, OFFSET nombreArchivo
    call CreateOutputFile       ; esto regresa el handle en eax
    mov ebx, eax                   ; guardamos el handle en ebx para no perderlo

    ; escribimos el texto adentro del archivo
    mov eax, ebx
    mov edx, OFFSET texto
    mov ecx, SIZEOF texto - 1
    call WriteToFile

    ; cerramos el archivo siempre hay que cerrar despues de escribir
    mov eax, ebx
    call CloseFile

    ; ahora lo abrimos de nuevo pero para leerlo
    mov edx, OFFSET nombreArchivo
    call OpenInputFile          ; tambien regresa el handle en eax
    mov ebx, eax

    ; leemos el contenido hacia el buffer
    mov eax, ebx
    mov edx, OFFSET buffer
    mov ecx, SIZEOF buffer - 1
    call ReadFromFile               ; eax regresa cuantos bytes se leyeron de verdad

    mov edi, OFFSET buffer         ; le ponemos el terminador nulo justo despues de lo leido
    add edi, eax
    mov BYTE PTR [edi], 0

    ; mostramos lo que leimos
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; cerramos el archivo al terminar
    mov eax, ebx
    call CloseFile

    exit
main ENDP
END main
