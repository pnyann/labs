.486 
.model flat, stdcall 
option casemap :none 
include \masm32\include\windows.inc 
include \masm32\macros\macros.asm 
include \masm32\include\masm32.inc 
include \masm32\include\gdi32.inc 
include \masm32\include\fpu.inc 
include \masm32\include\user32.inc 
include \masm32\include\kernel32.inc
include c:\masm32\include\msvcrt.inc                
includelib c:\masm32\lib\msvcrt.lib  
includelib c:\masm32\lib\fpu.lib 
includelib \masm32\lib\masm32.lib 
includelib \masm32\lib\gdi32.lib 
includelib \masm32\lib\user32.lib 
includelib \masm32\lib\kernel32.lib 
uselib masm32, comctl32, ws2_32 

.data
_const_1 DWORD 1.0 
_const_7 DWORD 7.0 
_const_3 DWORD 3.0
_result DWORD 0.0 
_k dd 4 
_endVal dd 7 
_k1 DWORD 4.0 
_title db "Laboratorna robota 5",0 
strbuf dw ?,0 
_text db "Student of KNEU IITE, Koval Anya",10,
"Output result by MessageBox:",10, 
"S = j E(i=k) i(i + 1)/((i+7)(i+3))",10,
"Result: " 
_res1 db 14 DUP(0),10,13 

.code 
start:
mov edx, 1 
mov ebx, _endVal 
mov ecx, _k 
finit 

.WHILE edx == 1 
.IF ecx == 0
loop m1 
.ENDIF 
fld _k1 
fmul _k1 ;k1*k1
fadd _k1 ;(k1*k1)+k1
fld _k1 
fadd _const_7 ;k1+7
fld _k1 
fadd _const_3 ;k1+3
fmul ;(k1+7)(k1+3)
fdiv ;i(i + 1)/((i+7)(i+3))
fld _result 
fadd ; result += i(i + 1)/((i+7)(i+3))
fstp _result 
		
m1: 
add ecx,1
add _k,1
fld1
fld _k1                  
fadd             
fstp _k1


.IF ecx > ebx 
fld _result                  
.BREAK
.ENDIF
.ENDW

invoke FpuFLtoA, 0, 10, ADDR _res1, SRC1_FPU or SRC2_DIMM
invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
invoke ExitProcess, 0 
end start 
