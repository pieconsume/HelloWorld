; https://en.wikipedia.org/wiki/Executable_and_Linkable_Format

defs:
 [BITS 64]     ; Use x86-64
 [DEFAULT REL] ; The executable is dynamic so use relative addressing
 [ORG 0]       ; The base address is 0 for the same reason
elf:
 dd 0x464C457F ; File identifier (0x7F, 'ELF')
 db 0x02       ; Executable format (0x01=32bit, 0x02=64bit)
 db 0x01       ; Endianness (0x01=little, 0x02=big)
 db 0x01       ; ELF Version
 db 0x00       ; Target ABI (0x00=System V)
 db 0x00       ; ABI version
 times 7 db 0  ; Unused/reserved
 dw 0x0003     ; Object type (0x0003=Dynamic)
 dw 0x003E     ; Target machine (0x003E=AMDx86-64)
 dd 0x00000001 ; ELF Version
 dq entry      ; Program entry point
 dq proghead   ; Program header table
 dq 0          ; Section header table
 dd 0          ; Flags
 dw 0x0040     ; Header size
 dw 0x0038     ; Program header entry size
 dw 0x0001     ; Program header entry count
 dw 0          ; Section header entry size
 dw 0          ; Section header entry count
 dw 0          ; Section header string table index
proghead:
 dd 0x00000001 ; Header type (0x01=Load)
 dd 0x00000007 ; Flags (0x01=Exec | 0x02=Write | 0x04=Read)
 dq 0          ; File offset
 dq 0          ; Virtual address
 dq 0          ; Physical address (usually ignored)
 dq progend    ; Size in file
 dq progend    ; Size in memory
 dq 0          ; Alignment
entry:
 ; Prints hello then exits using syscalls
 mov edi, 1       ; File descriptor to write to, 1 is stdout
 lea rsi, [hello] ; Address of the string to write
 mov edx, 7       ; Write 7 characters
 mov eax, 1       ; syscall 1, sys_write
 syscall
 mov eax, 60      ; syscall 60, sys_exit
 syscall
 hello db 'hello!', 10
progend: