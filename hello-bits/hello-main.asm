BITS 64
DEFAULT REL

GLOBAL main

EXTERN print

SECTION .data

 ds0  db "Hello world!", 10, 0
 ds14  dq 14
      dq ds0  
SECTION .text

main:
 ; main :: ()
 
 ; fn prologue
 push rbp
 mov rbp, rsp
 
 ;print("hello world!\r\0");

 sub rsp, 32
 ; point to tmp string call arg
 lea rcx, [ds14]

 call print
 add rsp, 32
 
 ; fn epilogue
 mov rsp, rbp
 pop rbp
 ret
