.686
.model flat, stdcall 
option casemap:none
include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc 
include C:\masm32\include\fpu.inc 
includelib C:\masm32\lib\kernel32.lib 
includelib C:\masm32\lib\user32.lib 
includelib C:\masm32\lib\fpu.lib 
.data 
CrLf equ 0A0Dh 
_x DWORD 2.0
step DWORD 3.5
min_digits DWORD 15.0
const_1 DWORD 0.3
const_2 DWORD 7.0
Y dq ?
no_res db "No results"
info db "Student of KNEU IITE, Koval Anya",10,10,
"Find first value of the argument of function Y = 7(x + 0.3) at which the lowest integer digits of the result of the function are 15(x varies from 2 in 3.5 steps)",10,10,
"x = " 
_res1 db 14 DUP(0),10,13 
titl db "Laboratorna robota 3",0 
.code
start:
finit
fld _x 
fadd const_1 ;x + 0.3 
fmul const_2 ;7(x + 0.3) 
fistp Y 
fild Y 
mov eax, dword ptr [Y+3] 
cmp eax, min_digits 
fld _x
fadd step
fistp _x
jne not_found 
jmp quit
not_found:
invoke FpuFLtoA,offset no_res,10,offset _res1,SRC1_REAL or SRC2_DIMM 
mov word ptr _res1 + 14, CrLf 
invoke MessageBox, 0, offset info, offset titl, MB_ICONINFORMATION 
invoke ExitProcess, 0 

quit:
invoke FpuFLtoA,offset _x,10,offset _res1,SRC1_REAL or SRC2_DIMM 
mov word ptr _res1 + 14, CrLf 
invoke MessageBox, 0, offset info, offset titl, MB_ICONINFORMATION 
invoke ExitProcess, 0 
END start