; Materia: Lenguajes de Interfaz
; Alumno: Angel Daniel Vega Hernandez - No. Control 24170767
; Horario: 9-10
; Docente: Dr. Jose Luis Medina Jimenez
; Practica: 02 - Captura y desplegado de mensaje
; Descripcion: pide al usuario su nombre lo guarda y luego lo muestra en pantalla

INCLUDE Irvine32.inc

.data

mensajeEntrada BYTE "Escribe tu nombre: ", 0
nombre BYTE 10 DUP(0)                       ; aqui se va a guardar lo que escriba el usuario
caracteresEscritos BYTE "Numero de caracteres: ", 0
experimento BYTE 50 DUP("a") ,"b",0          ; esto nomas para ver el tamaño de una cadena larga

.code 
main PROC
	mov edx, OFFSET mensajeEntrada
	call WriteString             ; pedimos el nombre
	mov edx, OFFSET nombre
	mov ecx, SIZEOF nombre       ; le decimos cuanto espacio tiene el buffer

	call ReadString               ; lee lo que el usuario teclea
	
	mov edx, OFFSET nombre
	call WriteString              ; mostramos el nombre que metio
	call Crlf

	mov edx, OFFSET caracteresEscritos
	call WriteString
	call WriteDec                   ; eax trae cuantos caracteres leyo ReadString
	call Crlf
	mov edx, OFFSET	experimento
	call WriteString
	mov eax, SIZEOF experimento      ; probamos el tamaño del arreglo experimento
	call Crlf
	call WriteDec

	exit
main ENDP
END main
