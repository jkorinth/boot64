%include "gdt64.s"
bits 32

stage_3_label: db "Boot64 Stage 3 (x64 compat)",0
stage_4_label: db "Boot64 Stage 4 (x64)",0

boot_x64:
	mov esi, stage_3_label
	mov ebx, 0xb8000 + 320
	xor eax, eax
.print:
	lodsb
	or al, al
	jz .c
	mov ah, 0x2f
	mov word [ebx], ax
	add ebx, 2
	jmp .print
.c:
	; delay
	mov ecx, 0x3fffffff
.bw:
	loop .bw

	; disable paging
	mov eax, cr0
	and eax, 0x7ffffff
	mov cr0, eax

	; setup the page tables
	;mov edi, _page_tables
	mov edi, 0x1000
	mov cr3, edi
	xor eax, eax
	mov ecx, 4096
	rep stosd
	mov edi, cr3

	mov dword [edi], 0x2003 ;_pdpt + 3
	add edi, 0x1000
	mov dword [edi], 0x3003 ;_pdt + 3
	add edi, 0x1000
	mov dword [edi], 0x4003 ;_pt + 3
	add edi, 0x1000

	; identity map first two MiB
	mov ebx, 3
	mov ecx, 512
.set_e:
	mov dword [edi], ebx
	add ebx, 0x1000
	add edi, 8
	loop .set_e

	; enable PAE paging
	mov eax, cr4
	or eax, 1 << 5
	mov cr4, eax

	; switch to long mode
	mov ecx, 0xc0000080
	rdmsr
	or eax, 1 << 8
	wrmsr

	; enable paging
	mov eax, cr0
	or eax, 1 << 31
	mov cr0, eax
	; done - now we're in compatiblity mode

	; now enter 64b submode
	cli
	lgdt [gdt64.ptr]
	jmp gdt64.code:_main


bits 64
_main:
	mov ax, gdt64.data
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	mov esi, stage_4_label
	mov ebx, 0xb8000 + 480
.loop:
	lodsb
	or al, al
	jz .halt
	or eax, 0x4f00
	mov word [ebx], ax
	add ebx, 2
	jmp .loop

.halt:
	mov ecx, 0x1fffffff
.loop2:
	loop .loop2
	
	mov edi, 0xb8000
	mov rax, 0x1f201f201f201f20
	mov ecx, 500
	rep stosq
	cli
	hlt


align 64
_page_tables:
_pml4t:
	times 4096 resb 0
_pdpt:
	times 4096 resb 0
_pdt:
	times 4096 resb 0
_pt:
	times 4096 resb 0

