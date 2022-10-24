BITS 64
DEFAULT REL

GLOBAL main

EXTERN print

SECTION .data

 ds0  db "Hello world!", 13, 10, 0

SECTION .text

main:
 ; fn prologue
 push rbp
 mov rbp, rsp
 
 ; tmp var for string call arg 
 sub rsp, 16
 mov [rbp - 8], DWORD 15
 lea rax, [ds0]
 mov [rbp - 16], rax
 
 sub rsp, 32
 ; point to tmp string call arg
 lea rcx, [rbp - 16]
 call print
 add rsp, 32
 
 ; fn epilogue
 mov rsp, rbp
 pop rbp
 ret
