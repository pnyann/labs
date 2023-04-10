.486                                    
.model flat, stdcall                    
option casemap :none                   
include \masm32\include\windows.inc     
include \masm32\macros\macros.asm      
include \masm32\include\masm32.inc
include \masm32\include\gdi32.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
.data	
_temp1 dd ?,0
_temp2 dd ?,0
_const1 dd 3
_const2 dd 12
_const3 dd 13
_a dd 4 
_b dd 3 
_c dd 2
_d dd 1
_title db "Laboratorna robota є2",0
strbuf dw ?,0
_text db "Masm32. Output the result through MessageBox:",0ah,
"y=3b-12c/d d>a",0ah,
"y= cb/3a-13a d<=a ",0ah,
"–езультат: %d Ч whole part",0ah, 0ah,
"Student KNEU, IITE, Koval Anya",0
MsgBoxCaption  db "An example of a message window",0 
MsgBoxText_1     db "porivnyannya  _d >_a",0 
MsgBoxText_2     db "porivnyannya  _d<=_a",0 
.const 
   NULL        equ  0 
   MB_OK       equ  0 
.code	
_start:	

main proc
 mov _a, sval(input("Vvedite a = "))
 mov _b, sval(input("Vvedite b = "))
 mov _c, sval(input("Vvedite c = "))
 mov _d, sval(input("Vvedite d = "))

mov ebx, _d
mov eax, _a 
 
    
; sub ebx, eax   
; jle zero


cmp ebx, eax
jbe zero 
; zero 
;y=3b-12c/d d>a

mov eax,_const1      
mul _b               
mov _temp1, eax     
mov eax, _const2     
mul _c               
div _d               
sub _temp1 , eax     

INVOKE    MessageBoxA, 0, ADDR MsgBoxText_1, ADDR MsgBoxCaption, MB_OK 
invoke wsprintf, ADDR strbuf, ADDR _text, _temp1
invoke MessageBox, NULL, addr strbuf, addr _title, MB_ICONINFORMATION
invoke ExitProcess, 0

jmp lexit 
 
zero:
; cb/3a-13a d<=a
mov eax, _c          
mul _b               
div _const1          
mul _a               
mov _temp2, eax      
mov eax, _const3     
mul _a              
sub _temp2, eax      

INVOKE    MessageBoxA, NULL, ADDR MsgBoxText_2, ADDR MsgBoxCaption, MB_OK 
invoke wsprintf, ADDR strbuf, ADDR _text, _temp2
invoke MessageBox, NULL, addr strbuf, addr _title, MB_ICONINFORMATION
invoke ExitProcess, 0

lexit:
ret
main endp
ret                
end _start          

