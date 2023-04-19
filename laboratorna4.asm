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
.data
_r DWORD 0.0 
_const0_12 DWORD 0.12 
borderLeft DWORD -1.0 
borderRight DWORD 1.0 
_title db "Laboratorna robota 4",0 
strbuf dw ?,0 
_text db "Student of KNEU IITE, Koval Anya", 10,
"Output result by MessageBox:", 10,
"Z = V-cosV+0.12   V<-1", 10,
"Z = arcSin(V)   -1.0<=V<=1.0", 10,
"Z = sqrt(V^3 + lg(V))   1.0<V", 10,
"Result: " 
_res db 10 DUP(0),10,13 

MsgBoxCaption db "Result of comparison",0
MsgBoxText_1 db "V<-1.0",0 
MsgBoxText_2 db "-1.0<=V<=1.0", 0 
MsgBoxText_3 db "1.0<V", 0 

.const 
NULL equ 0 
MB_OK equ 0 

.code 
_start: 

main proc 
LOCAL _V: DWORD 
mov _V, sval(input("Enter V: ")) 
finit 
fild _V 
fstp _V 
fld borderLeft
fld _V
fcompp
fstsw ax
sahf 
jb first
fld borderRight
fld _V
fcompp
fstsw ax
sahf
jbe second

;1.0<V
;Z=sqrt(V^3 + lg(V)) 
fld _V ;завантаження x у верхівку стеку
fstp st(2) ;збереження результату в st(2)
fldlg2 ;lg 2
fld st(2) ;load st(2) to the top of the stack
fyl2x ;lg 2 * log2 (V)
fld _V ;завантаження V у верхівку стеку 
fmul _V ;V^2
fmul _V ;V^3
fadd ; V^2 + lg(V)
fsqrt ; sqrt(V^2 + lg(V))
invoke MessageBoxA, NULL, ADDR MsgBoxText_3, ADDR MsgBoxCaption, MB_OK 
invoke FpuFLtoA, 0, 10, ADDR _res, SRC1_FPU or SRC2_DIMM
invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
invoke ExitProcess, 0 
jmp lexit 

first:
;V<-1.0
;Z=V-cosV+0.12
fld _V ;завантаження V у верхівку стеку 
fcos ;обчислення косинуса
fsubr _V ;відняти косинус від V
fadd _const0_12 ;додати 0.12
invoke MessageBoxA, NULL, ADDR MsgBoxText_1, ADDR MsgBoxCaption, MB_OK 
invoke FpuFLtoA, 0, 10, ADDR _res, SRC1_FPU or SRC2_DIMM
invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
invoke ExitProcess, 0 
jmp lexit 

second:
;-1.0<=V<=1.0
;Z=arcSin(V)
fld _V ;завантаження V у верхівку стеку 
fmul st, st ;x^2 
fld1 ;завантажуємо значення 1 в регістр
fsub st(1), st ;віднімаємо V^2 від 1 
fsqrt ;рахуємо sqrt(V^2 / (1 - V^2)) 
fld st ;рахуємо atan(sqrt(V^2 / (1 - V^2)))
fld1 ;завантажуємо значення 1 в регістр
fpatan ;обчислення atan
invoke MessageBoxA, NULL, ADDR MsgBoxText_2, ADDR MsgBoxCaption, MB_OK 
invoke FpuFLtoA, 0, 10, ADDR _res, SRC1_FPU or SRC2_DIMM
invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
invoke ExitProcess, 0 
jmp lexit 

lexit:
ret
main endp 
ret 
end _start 


