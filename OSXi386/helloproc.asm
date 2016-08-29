; =============================================================================
; helloproc.asm - procedural version of hello world assembly
; ; For OS X i386 archtecture
; Programmer : Julio Torres 
; Date       : 2016-08-29
; Source     : peter.michaux.ca 
; =============================================================================
; compile: nasm -f macho helloproc.asm
; linkedit: ld -o helloproc -e mystart -o helloproc.o 
; =============================================================================

SEGMENT .text 

global mystart									; make the main function externally visible 

; a procedure wrrapping the sys call to write 
mywrite: 
	mov eax,0x4									; sys call to write code 
	int 0x80 									; make sys call 
	ret 

; a procedure wrapping the sys call to exit 
myexit: 
	mov eax, 0x1 								; sys call to exit code 
	int 0x80 
	; no need to return 

mystart: 

; 1 print "hello world"

	; 1a prepare program arguments 
	push dword mylen 							; message length 
	push dword mymsg 							; message to write 
	push dword 1 								; file descriptor value 

	; 1b make call 
	call mywrite 

	; 1c clean up stack 
	add esp, 12 

;2 exit the program 
	
	; 2a prepare arguments 
	push dword 0 								; exit code 

	; 2b make call 
	call myexit 

	; 2c no need to clean up, because no code here would be executed. Already exited! 

SEGMENT .data 

		mymsg db "hello world procedural", 0xa	; string with carriage return 
		mylen equ $-mymsg 						; string length in bytes 
