; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 09 - Push y Pop
; aqui vemos como funciona la pila con push pop y tambien call y ret

INCLUDE Irvine32.inc

.data

.code
main PROC
	; bloque 1 push y pop basico

	mov eax, 500

	push eax           ; metemos 500 a la pila
	nop

	mov ebx, 0
	pop ebx              ; sacamos de la pila y lo guardamos en ebx

	nop

	; bloque 2 orden lifo
	mov eax, 10
	push eax             ; pila: 10

	mov eax, 20
	push eax               ; pila: 10 20

	mov eax, 30
	push eax                 ; pila: 10 20 30 (30 queda hasta arriba)

	nop

	pop eax           ; saca 30 el ultimo que entro
	pop ebx              ; saca 20
	pop ecx                ; saca 10
	
	nop

	; bloque 3 conservar registros
	; aqui guardamos eax y ebx antes de cambiarlos para no perder su valor

	mov eax, 100
	mov ebx, 200

	push eax
	push ebx

	mov eax, 999
	mov ebx, 888

	pop ebx             ; ojo el orden es al reves del push
	pop eax

	nop

	; bloque 4 call y ret
	mov eax, 50
	mov ebx, 666

	call aumentarDiez       ; llamamos al procedimiento que le suma 10 a eax

	nop

	exit

main ENDP

aumentarDiez PROC
	nop
	push ebx             ; guardamos ebx antes de usarlo

	nop

	mov ebx, 10
	add eax, ebx            ; aqui eax queda en 60

	nop

	pop ebx                  ; regresamos ebx a como estaba

	nop

	ret
aumentarDiez ENDP
END main
