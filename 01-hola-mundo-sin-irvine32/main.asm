; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 01 - Hola mundo sin Irvine32
; Descripcion: hola mundo usando solo la api de windows sin usar la libreria irvine32

; practica hola mundo sin usar la libreria Irvine32
; aqui usamos funciones de windows directo (kernel32)

.386
.model flat, stdcall
option casemap:none

include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib

; declaramos las funciones de windows que vamos a usar
GetStdHandle  PROTO, nStdHandle:DWORD
WriteConsoleA PROTO, hConsoleOutput:DWORD, lpBuffer:PTR BYTE, nNumberOfCharsToWrite:DWORD, lpNumberOfCharsWritten:PTR DWORD, lpReserved:DWORD
ExitProcess   PROTO, uExitCode:DWORD

STD_OUTPUT_HANDLE equ -11

.data
mensaje       BYTE "Hola Mundo!", 0
handleConsola DWORD ?
bytesEscritos DWORD ?

.code
main PROC
    ; pedimos el handle de la consola a windows
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov handleConsola, eax

    ; escribimos el mensaje directo en consola sin usar WriteString
    INVOKE WriteConsoleA, handleConsola, ADDR mensaje, SIZEOF mensaje - 1, ADDR bytesEscritos, 0

    ; cerramos el programa
    INVOKE ExitProcess, 0
main ENDP
END main
