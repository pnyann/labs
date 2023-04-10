.686 
.model flat, stdcall 
option casemap:none 
include \masm32\include\windows.inc  
include \masm32\include\kernel32.inc 
include \masm32\include\user32.inc 
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib

firstfunc PROTO _const1:DWORD,_d1:DWORD,_const2:DWORD,_b1:DWORD,
_const3:DWORD,_c1:DWORD
.data  
const1 dd 2
d1 dd 9
const2 dd 3
b1 dd 3
const3 dd 11
c1 dd 1
_temp1 dd ?,0
_title db "Laboratorna robota ¹1",0
strbuf dw ?,0
_text db "Masm32. Student KNEU, IITE, Koval Anya",0ah,
"Result output 2d/3b – 11c by MessageBox:",0ah, 
"const1*d1/const2*b1-const3*c1",0ah,
"2*9/3*3-11*1",0ah,
"Result: %d — whole part",0ah, 0ah,0
.code
firstfunc proc _const1:DWORD,_d1:DWORD,_const2:DWORD,_b1:DWORD, _const3:DWORD,_c1:DWORD
; const1*d1/const2*b1-const3*c1
; 2*9/3*3-11*1
mov eax, _const1    
mul _d1             
div _const2         
mul _b1             
mov _temp1, eax      
mov eax, _const3     
mul _c1             
sub _temp1, eax     
ret 
firstfunc endp

start:
invoke firstfunc, const1,d1,const2,b1,const3,c1
invoke wsprintf, ADDR strbuf, ADDR _text, _temp1
invoke MessageBox, NULL, addr strbuf, addr _title, MB_ICONINFORMATION
invoke ExitProcess, 0 
END start 
