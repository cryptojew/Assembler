; =============================================================================
; sys.asm - system call wrapper procedures 
; For OS X i386 archtecture
; Programmer : Julio Torres 
; Date       : 2016-08-29
; Source     : peter.michaux.ca 
; =============================================================================

SEGMENT .text 

; make the library API externally visible 
global mywrite 
global myexit 

mywrite: 
	mov eax, 0x4 								; sys call to write code 
	int 0x80 									; makes the call 
	ret 										; returns the control to caller 

myexit: 
	mov eax, 0x1								; sys call to exit code 
	int 0x80 									; make the system call
