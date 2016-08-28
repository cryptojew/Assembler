; hello.asm - a hello world program using AMS 
; For OS X i386 archtecture
; compile: nasm -f macho hello.asm
; linkedit: ld -o hello -e mystart -o hello.o 

section .text

global mystart 								; make the main function externally visible 

mystart: 

; 1 print "hello world"

	;1a prepare the arguments for the system call to write 
		push dword mylen					; message length 
		push dword mymsg 					; message to write 
		push dword 1						; file descriptor value

	;1b make the system call to write 
		mov eax, 0x4 						; system call number for write 
		sub esp, 4 						; OS X (and BSD) system calls need extra space on stack 
		int 0x80 						; make the actual system call 

	;1c clean up the stack 
		add esp, 16						; 3 args * 4 bytes/arg + 4 bytes extra space = 16 bytes 

;2 exit the program 

	;2a prepare the argument for the sys call to exit 
		push dword 1 						; exit status returned to the operating system

	;2b make the call to sys exit
		mov eax, 0x1						; sys call number for exit 
		sub esp, 4 						; OS X (and BSD) system calls need extra space on stack 
		int 0x80 						; make the sys call 

	;2c no need to clean up because no code here would be executed... already exited! 

section .data 

	mymsg db "hello, world",0xa					; string with a carriage-return 
	mylen equ $-mymsg 						; string length in bytes
