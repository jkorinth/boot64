%include "gdt.s"

gdt64:
.null:	equ $ - gdt64
	dq 0
.code:	equ $ - gdt64
	dd 0xffff				; limit
	db 0					; base
	db PRESENT | NOT_SYS | EXEC | RW	; access flags
	db GRAN_4K | LONG_MODE | 0xf		; flags & 4b limit	
	db 0					; base
.data:	equ $ - gdt64
	dd 0xffff				; limit
	db 0					; base
	db PRESENT | NOT_SYS | RW		; access flags
	db GRAN_4K | SZ_32 | 0xf		; flags & 4b limit
.tss:	equ $ - gdt64
	dd 0x00000068
	dd 0x00cf8900
.ptr:
	dw $ - gdt64 - 1
	dq gdt64
	

