; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 08 - Operaciones aritmeticas
; Descripcion: ejemplos de add sub mul imul div e idiv viendo como afectan a las banderas

; aqui vemos add sub mul imul div idiv y como se prenden cf y of

INCLUDE Irvine32.inc


.code 
main PROC
	; 01 add y sub normales

	mov eax, 50
	mov ebx, 20
	
	add eax, ebx
	sub eax, 15

	nop

	; 2 cf acarreo en una suma sin signo
	mov eax, 0
	mov al, 255

	add al, 1              ; aqui se pasa del rango y prende el carry flag

	; 3 of desbordamiento en una suma con signo

	mov eax, 0
	mov al, 127

	add al, 1              ; aqui se pasa del rango con signo y prende el overflow

	nop

	; 4 mul producto dentro de 32 bits

	mov eax, 65532
	mov ebx, 65532

	mul ebx                  ; multiplicacion sin signo

	; imul producto con signo

	mov eax, -5 

	imul eax, eax, 3            ; multiplicacion con signo de 3 operandos

	nop

	; div dividiendo valores pequeños sin signo
	
	mov eax, 125
	mov edx, 0                  ; edx se pone en 0 porque es sin signo
	mov ebx, 12
	div ebx
	nop

	; idiv y cdq division con signo
	mov eax, -125
	cdq                           ; cdq extiende el signo de eax hacia edx

	mov ebx, 12
	idiv ebx

	nop 

	exit
main ENDP
END main
