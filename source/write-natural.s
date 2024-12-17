SYSTEM_WRITE equ 1
SYSTEM_EXIT equ 60
SYSTEM_FILE_OUTPUT equ 1
section .rodata
	line_string db `\n`
section .data
	; value db `54321`
	value times 20 db 0
section .text
	global system
	system:
		mov rax, 12345 ; binary value
		mov rcx, 0 ; decimal index
		mov rdx, 1 ; decimal size
		mov byte [value], `0`
		decrement:
			cmp rax, 0
				jmp write
				
			
			cmp byte [value + rcx], `9`
				jne 
			mov byte [value + rcx], `0`
			inc rcx
			; check for overflow
			

			je write
			; cmp 
			; mov byte [value + rcx], `0`
			; inc rcx
			; inc rdx
			; jmp overflow
			; jmp increment
			; inc byte [value + rcx]
			; jmp write
			; cmp byte [value + rcx]

			dec rax
			jmp decrement


		write:
		mov rbx, rdx
		mov rdx, 1
		mov rdi, SYSTEM_FILE_OUTPUT
		write_string:
			dec rbx
			mov rsi, value
			add rsi, rbx
			mov rax, SYSTEM_WRITE
			syscall
			cmp rsi, value
				je write_line
			jmp write_string
		write_line:
		mov rsi, line_string
		mov rax, SYSTEM_WRITE
		syscall
		exit:
		mov rax, SYSTEM_EXIT
		mov rdi, 0
		syscall

		; ; allocate register for decimal list pointer
		; mov rcx, decimal
		; mov rcx, [0]
		; increment:
		;     ; TODO: cmp byte [rcx], 9
		;     ; TODO: inc byte [rcx]
		;     cmp rax, 0
		;         je write
		;     dec rax
		;     jmp increment
		; write decimal list
		; string_size:
		;     cmp byte [rcx + rbx], 0
		;         je write
		;     inc rbx
		;     jmp string_size

		; write_string:
		; write_string_character:
		
		; TODO: add x, `0`
		; mov rbx, 0
		; size_string:
		;     cmp byte []
		;     mov rbx, 0
		;     jmp size_string
		; write_string:
		;     cmp byte []
		;     ; character:
		; mov rcx, rdx 

		; mov rdx, 1
		; mov rsi, value
		; mov rdi, SYSTEM_FILE_OUTPUT
		; mov rax, SYSTEM_WRITE
		; syscall


		; mov rbx, rdx ; string index
		; write_string:
		;     mov rdx, 1
		;     mov rsi, value
		;     add rsi, rbx
		;     mov rdi, SYSTEM_FILE_OUTPUT
		;     mov rax, SYSTEM_WRITE
		;     syscall
		;     dec rbx
		;     cmp rsi, value 
		;         jne exit
		;     jmp write_string

		;     write_character:
		;     mov rdx, 1
		;     mov rsi, rsi
		;     mov rdi, SYSTEM_FILE_OUTPUT
		;     mov rax, SYSTEM_WRITE
		;     syscall
		;     dec rbx
		;     mov rax, value
		;     add rax, rbx
		;     cmp rax, value 
		;         jne write_line
		; write_line:
		; mov rdx, 1
		; mov rsi, rsi
		; mov rdi, SYSTEM_FILE_OUTPUT
		; mov rax, SYSTEM_WRITE
		; syscall

