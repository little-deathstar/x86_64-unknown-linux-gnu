system_success equ 0
system_failure equ 1
system_exit equ 60
system_output equ 1
system_write equ 1
section .rodata
	line_string db `\n`
section .text
	global system
	system:
		cmp word [rsp], 1
			jl exit_failure
		mov rsi, [rsp + 8]
		mov rdx, 0
		size:
			cmp byte [rsi + rdx], 0
				je write
			inc rdx
			jmp size
		write:
		mov rax, system_write
		mov rdi, system_output
		syscall ; ignore potential error in rax
		mov rax, system_write
		mov rsi, line_string
		mov rdx, 1
		syscall ; ignore potential error in rax
		jmp exit_success
		exit_failure:
		mov rdi, system_success
		jmp exit
		exit_success:
		mov rdi, system_failure
		exit:
		mov rax, system_exit
		syscall