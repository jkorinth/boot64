%include "gdt.s"

gdt32:
.null:	equ $ - gdt32
	dq 0x0
.code:	equ $ - gdt32
	dw 0xffff				; limit
	dw 0x0					; base
	db 0x0					; base
	db PRESENT | NOT_SYS | EXEC | RW	; access flags
	db GRAN_4K | SZ_32 | 0xF		; flags & 4b limit
	db 0					; base
.data:	equ $ - gdt32
	dw 0xffff				; limit
	dw 0x0					; base
	db 0x0					; base
	db PRESENT | NOT_SYS | RW		; access flags
	db GRAN_4K | SZ_32 | 0xF		; flags & 4b limit
	db 0					; base
.ptr:
	dw $ - gdt32 - 1 ;gdt32.end - gdt32
	dd gdt32
