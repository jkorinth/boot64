bits 32
	stage_2_label: db "Boot64 Stage 2 (x32)",0

boot_x32:
	mov esi, stage_2_label
	mov ebx, 0xb8000 + 160
.loop:
	lodsb
	or al, al
	jz .halt
	or eax, 0x0f00
	mov word [ebx], ax
	add ebx, 2
	jmp .loop
.halt:
	cli
	hlt
