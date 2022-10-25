BITS 64
DEFAULT REL

GLOBAL main

EXTERN print

SECTION .data

 ds0  db "Hello world!", 13, 10, 0
git add .
SECTION .text

main:
 ; main :: ()
 
 ; fn prologue
 push rbp
 mov rbp, rsp
 
 ;print("hello world!\r\0");

 ; tmp var for string call arg 
 sub rsp, 16
 mov QWORD [rbp - 16], 15
 lea rax, [ds0]
 mov [rbp - 8], rax
 
 sub rsp, 32
 ; point to tmp string call arg
 lea rcx, [rbp - 16]

 call print
 add rsp, 32
 
 ; fn epilogue
 mov rsp, rbp
 pop rbp
 ret
