; first stage bootloader:
; called directly from BIOS
bits 16
org 0x7c00

%define STAGE1	boot_x16

_start:
	mov [_disk], bl		; save disk id from BIOS
	mov ax, 0x03
	int 0x10
	mov ax, 0x0100
	mov cx, 0x0706		; invisible cursor
	int 0x10
	mov ax, 0x0000
	mov es, ax
	mov ax, STAGE1
	mov bx, ax		; write to 0000:1000h
	mov ah, 0x02		; read from disk
	mov al, 0x08		; N sectors
	mov ch, 0x00		; cylinder 0
	mov cl, 2		; from sector 2
	mov dh, 0		; head 0
	mov dl, [_disk]		; disk id
	int 0x13
	jmp STAGE1
	cli
	hlt

_disk: db 0

times 510 - ($ - $$) db 0
dw 0xaa55

%include "boot_x16.s"
%include "boot_x32.s"
%include "boot_x64.s"
