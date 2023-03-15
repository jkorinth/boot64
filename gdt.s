%ifndef GDT_FLAGS
%define GDT_FLAGS

; access bits of GDT entries
PRESENT 	equ 1 << 7
NOT_SYS		equ 1 << 4 
EXEC		equ 1 << 3
DC		equ 1 << 2
RW		equ 1 << 1
ACCESSED	equ 1 << 0

; flags
GRAN_4K		equ 1 << 7
SZ_32		equ 1 << 6
LONG_MODE 	equ 1 << 5

%endif
