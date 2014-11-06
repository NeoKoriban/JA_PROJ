.xmm

.MODEL FLAT, STDCALL

OPTION CASEMAP:NONE

INCLUDE    \masm32\include\windows.inc
.data
	
	;tab dword 4,5,1
	permutationPart1 dword 57, 49, 41, 33, 25, 17,  9,  1, 58, 50, 42, 34, 26, 18,
						   10,  2, 59, 51, 43, 35, 27, 19, 11,  3, 60, 52, 44, 36
	permutationPart2 dword 63, 55, 47, 39, 31, 23, 15,  7, 62, 54, 46, 38, 30, 22,
						   14,  6, 61, 53, 45, 37, 29, 21, 13,  5, 28, 20, 12,  4 

.code
	

Dodaj proc a:dWORD, b:dWORD

	mov eax, 0
	mov ecx, 28
	mov edx, 0
	mov esi, 0
	jmp petla

petla:
	
	add edx,permutationPart1[ecx*4-4]	
	loop petla

mov ecx, 28
jmp petla2

petla2:
	add edx,permutationPart2[ecx*4-4]
	loop petla2

mov eax,edx
ret




Dodaj endp 

end 
