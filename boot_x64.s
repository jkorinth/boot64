%include "gdt64.s"
bits 32

stage_3_label: db "Boot64 Stage 3 (x64)",0

boot_x64:
	cli
	lgdt [gdt64.ptr]
	mov ax, gdt64.data
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	mov esi, stage_3_label
	mov ebx, 0xb8000 + 320
.loop:
	lodsb
	or al, al
	jz .start
	or eax, 0x0800
	mov word [ebx], ax
	add ebx, 2
	jmp .loop
.start:
	jmp gdt64.code:_main

bits 64
_main:
	cli
	hlt
