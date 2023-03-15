bits 32
	stage_2_label: db "Boot64 Stage 2 (x32)",0

boot_x32:
	mov esi, stage_2_label
	mov ebx, 0xb8000 + 160
.loop:
	lodsb
	or al, al
	jz .next
	or eax, 0x0f00
	mov word [ebx], ax
	add ebx, 2
	jmp .loop
.next:
	; busy wait
	mov ecx, 0x0fffffff
.busy:	
	loop .busy
	jmp gdt32.code:boot_x64

.halt:
	cli
	hlt
