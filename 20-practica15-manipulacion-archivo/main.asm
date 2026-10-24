; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 15 - Manipulacion de archivo
; Descripcion: crea un archivo le escribe un texto lo cierra lo vuelve a abrir y muestra lo que tiene

INCLUDE Irvine32.inc

INVALID_HANDLE_VALUE EQU -1

.data
    nombreArchivo   BYTE "inventario.txt", 0
    texto           BYTE "125", 0
    archivoHandle   HANDLE ?
    mensajeExito    BYTE "Archivo Guardado", 0
    mensajeError    BYTE "No se pudo guardar el archivo", 0

.code
main PROC
    ; aqui creamos el archivo con el nombre que pusimos arriba
    mov edx, OFFSET nombreArchivo
    call CreateOutputFile
    cmp eax, INVALID_HANDLE_VALUE   ; revisamos si el handle salio mal
    je  Error                 
    mov archivoHandle, eax    ; si todo bien guardamos el handle en la variable

    ; ahora escribimos el texto dentro del archivo
    mov eax, archivoHandle
    mov edx, OFFSET texto
    mov ecx, SIZEOF texto - 1   ; el -1 es pa no contar el cero del final
    call WriteToFile
    
    jc  errorEscritura         ; si el CF se prendio algo fallo al escribir
    cmp eax, SIZEOF texto - 1   ; aqui checamos que si escribio todos los bytes
    jne errorEscritura          ; si no escribio lo mismo que pedimos hay error

    ; cerramos el archivo pa que guarde bien los cambios
    mov eax, archivoHandle
    call CloseFile
    test eax, eax   ; si CloseFile regresa 0 es que fallo el cierre
    je  Error                 

    ; si llegamos hasta aca ya todo salio bien
    mov edx, OFFSET mensajeExito
    call WriteString
    jmp fin

errorEscritura:
    mov eax, archivoHandle
    call CloseFile              ; cerramos el archivo aunque haya fallado arriba

Error:
    mov edx, OFFSET mensajeError   ; mostramos el mensaje de error
    call WriteString

fin:
    exit   ; aqui se termina el programa
main ENDP

END main
