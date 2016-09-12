; =============================================================================
; hellolibr.asm - hello world using library call to 'sys.asm', written before 
; For OS X i386 archtecture
; Programmer : Julio Torres 
; Date       : 2016-08-29
; Source     : peter.michaux.ca 
; =============================================================================
; compile: nasm -f macho sys.asm 
;          nasm -f macho hellolibr.asm 
; linkedit: ld -o hellolibr -e mystart sys.o hellolibr.o 
; =============================================================================

SEGMENT .text 

; tell the assembler about the library functions used and the linker will resolve them out
extern mywrite 
extern myexit 

global mystart 									; make the main function visible externally 

mystart: 

; 1 print hello world 

	; 1a prepare arguments 
	push dword mylen 							; message length 
	push dword mymsg 							; message to write 
	push dword 1 								; file descriptor value 

	; 1b make call 
	call mywrite 

	; 1c clean up stack 
	add esp, 12 								; 3 args * 4 bytes/arg = 12 bytes 

; 2 exit program 

	; 2a prepare arguments 
	push dword 0 								; exit code 

	; 2b make call 
	call myexit 

	; 2c no need to clean up, because no code here would be executed. Already exited. 

SEGMENT .data 

	mymsg db "hello world with lib", 0xa		; string with a carriage return 
	mylen equ $-mymsg
