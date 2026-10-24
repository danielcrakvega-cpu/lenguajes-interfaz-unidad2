; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 05 - Condicionales
; dos contadores que van subiendo hasta llegar a un limite muy grande

INCLUDE Irvine32.inc
.code 
main PROC

	mov ebx, 1
    

ciclo:

	cmp eax, 999999999       ; mientras eax no llegue a este numero sigue

	jg ciclo2
;	call WriteDec
;	call Crlf

	inc eax                    ; le sumamos 1 a eax en cada vuelta

	jmp ciclo
	
ciclo2:
	mov eax, ebx
	call WriteDec              ; mostramos el valor de ebx
	call Crlf
	mov eax, 1
	cmp ebx, 999999999
	jg fin
	inc ebx                       ; le sumamos 1 a ebx
	jmp ciclo

fin:

	exit

main ENDP
END main
