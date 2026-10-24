; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 04 - Saltos
; Descripcion: ejemplo de salto incondicional jmp y de salto condicional je por igualdad

; ejemplo 1 salto incondicional jmp

INCLUDE Irvine32.inc

.code 
main PROC
	mov eax, 5
	jmp continuar       ; este jmp siempre salta sin revisar nada
	mov eax, 10          ; no se va ejecutar por el jmp de arriba
	

continuar:
	call DumpRegs           ;  eax es  5
	exit

main ENDP
END main



; ejemplo 2 salto condicional por igualdad je

INCLUDE Irvine32.inc

.data
	msgIguales BYTE "Los valores son iguales", 0
	msgDiferentes BYTE "Los valores son diferentes", 0

.code 
main PROC
	mov eax, 4
	mov ebx, 2
	
	cmp eax, ebx            ; aqui se prende el zero flag si son iguales

	je iguales                 ; si zero flag esta en 1 brinca a iguales
	mov edx, OFFSET msgDiferentes
	call WriteString
	
	jmp fin

iguales:
	mov edx, OFFSET msgIguales
	call WriteString 
	jmp fin

fin:
	call Crlf
	exit
main ENDP
END main
