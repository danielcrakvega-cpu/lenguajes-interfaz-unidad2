; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 01 - Hola mundo sin Irvine32
; Descripcion: hola mundo usando solo la api de windows sin usar la libreria irvine32

.386
.model flat, stdcall
option casemap:none

include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib

; aqui declaro las funciones de windows que voy a usar
; esto es como un prototipo para que el ensamblador sepa que parametros reciben
GetStdHandle  PROTO, nStdHandle:DWORD
WriteConsoleA PROTO, hConsoleOutput:DWORD, lpBuffer:PTR BYTE, nNumberOfCharsToWrite:DWORD, lpNumberOfCharsWritten:PTR DWORD, lpReserved:DWORD
ExitProcess   PROTO, uExitCode:DWORD

STD_OUTPUT_HANDLE equ -11      ; constante que pide windows para la salida estandar osea la consola

.data
mensaje       BYTE "Hola, Mundo!", 0    ; el texto que voy a mostrar
handleConsola DWORD ?                      ; aqui se guarda el handle que me regresa windows
bytesEscritos DWORD ?                         ; windows necesita un lugar donde anotar cuantos bytes escribio

.code
main PROC
    ; pido a windows el handle de la consola para poder escribir en ella
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov handleConsola, eax

    ; escribo el mensaje directo en la consola usando WriteConsoleA
    ; SIZEOF mensaje - 1 es para no mandar el byte 0 final osea el terminador
    INVOKE WriteConsoleA, handleConsola, ADDR mensaje, SIZEOF mensaje - 1, ADDR bytesEscritos, 0

    ; cierro el programa de forma correcta
    INVOKE ExitProcess, 0
main ENDP
END main
