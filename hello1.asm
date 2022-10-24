BITS 64
DEFAULT REL

GLOBAL main

EXTERN WriteFile
EXTERN GetStdHandle

STD_OUTPUT_HANDLE   EQU -11

SECTION .data

 ds0  db "Hello world!", 13, 10, 0

SECTION .text

print: 
 ; fn prologue
 ; store old rbp and set rbp to new base
 push rbp
 mov rbp, rsp
 ; store args 1 and 2 in shadow
 mov [rbp + 16], rcx
 mov [rbp + 24], edx
 ;8 for 1 local var
 sub rsp, 8
  
 ; set shadow space, set 1 param (ECX) and call GetStdHandle
 sub rsp, 32
 mov ecx, STD_OUTPUT_HANDLE
 call GetStdHandle
 add rsp, 32
 ; store var handle := ret val from call
 mov [rbp - 8], eax

 ; set shadow space, set 5 params (one on stack) and call WriteFile
 sub rsp, 40
 mov ecx, [rbp - 8]
 mov rdx, [rbp + 16]
 mov r8d, [rbp + 24]
 xor r9, r9
 mov QWORD [rsp + 32], 0 
 call WriteFile
 add rsp, 40
 
 ; fn epilogue
 mov rsp, rbp
 pop rbp
 ret

main:
 ; fn prologue
 push rbp
 mov rbp, rsp
 
 sub rsp, 32
 lea rcx, [ds0]
 mov edx, DWORD 15
 call print
 add rsp, 32
 
 ; fn epilogue
 mov rsp, rbp
 pop rbp
 ret
