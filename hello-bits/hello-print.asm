BITS 64
DEFAULT REL

GLOBAL print

EXTERN WriteFile
EXTERN GetStdHandle
EXTERN STD_OUTPUT_HANDLE

SECTION .data
SECTION .text

print: 
 ; print :: (to_print: string)

 ; fn prologue
 ; store old rbp and set rbp to new base
 push rbp
 mov rbp, rsp
 ; store arg 1 in shadow
 mov [rbp + 16], rcx
 ; 36 bytes storage resvered for 5 local var: *void (8) * 4 + 1 u32 (4)
 sub rsp, 36
  
 ; handle := GetStdHandle(STD_OUTPUT_HANDLE);
 ; set shadow space, set 1 param (ECX) and call GetStdHandle
 sub rsp, 32
 mov ecx, STD_OUTPUT_HANDLE
 call GetStdHandle
 ; store var handle := ret val from call
 mov [rbp - 8], eax
 ; release shadow space for GetStdHandle proc call
 add rsp, 32
 
 ; to_write := cast(*void) to_print.data;
 mov rax, [rbp + 16]
 mov rcx, [rax + 8]
 mov [rbp - 16], rcx
; length := cast(u32) to_print.len
 mov rax, [rbp + 16]
 mov rcx, [rax]
 mov [rbp - 20], ecx
 ; bytes_written: *void = null;
 mov QWORD [rbp - 28], 0
 ; overlapped: *void = null;
 mov QWORD [rbp - 36], 0
 
 ; set shadow space, set 5 params (one on stack) and call WriteFile
 sub rsp, 40
 mov ecx, [rbp - 8]
 mov rdx, [rbp - 16]
 mov r8d, [rbp - 20]
 mov r9, [rbp - 28]
 mov r10, [rbp - 36]
 mov [rsp + 32], r10 
 call WriteFile
 add rsp, 40

 ; fn epilogue
 mov rsp, rbp
 pop rbp
 ret
