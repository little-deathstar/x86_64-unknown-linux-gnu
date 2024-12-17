system_write equ 1
system_exit equ 60
system_output equ 1
section .rodata
	value_string db `Hello, world!\n`
	value_size equ $ - value_string
section .text
	global system
	system:
		mov rax, system_write
		mov rdi, system_output
		mov rsi, value_string
		mov rdx, value_size
		syscall ; ignore potential error in rax
		mov rax, system_exit
		mov rdi, 0
		syscall