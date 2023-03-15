%macro wait_for_key 0
	xor ax, ax
	int 0x16
%endmacro

boot_x16:
	mov si, stage_1_label
.print:
	lodsb
	or al, al
	jz .wait
	mov ah, 0x0e
	int 0x10
	jmp .print
.wait:
	wait_for_key

	mov ax, 0x2401		; activate A20 line
	int 0x15
	cli

	lgdt [gdt32.ptr]
	mov eax, cr0
	or eax, 0x1		; enable protected mode
	mov cr0, eax

	mov ax, gdt32.data
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
	jmp gdt32.code:boot_x32

	cli
	hlt

stage_1_label: db "Boot64 Stage 1 (x16)",0

%include "gdt32.s"
