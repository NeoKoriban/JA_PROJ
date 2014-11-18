.xmm

.MODEL FLAT, STDCALL

OPTION CASEMAP:NONE

INCLUDE    \masm32\include\windows.inc
.data
	permutationPone dword 57, 49, 41, 33, 25, 17,  9,  1, 
						  58, 50, 42, 34, 26, 18, 10,  2,
						  59, 51, 43, 35, 27, 19, 11,  3, 
						  60, 52, 44, 36, 63, 55, 47, 39 
	permutationPtwo dword 31, 23, 15,  7, 62, 54, 46, 38, 
						  30, 22, 14,  6, 61, 53, 45, 37, 
						  29, 21, 13,  5, 28, 20, 12,  4 
	

	key byte 4, 6, 23, 222, 16, 42, 5, 7
	newKey byte 0, 0, 0, 0, 0, 0, 0
	arrayKeySize dword 8
	bitNewKeySize dword 56

	arrayKeyLSize dword 28

	constantStartValue dword 2

	PositionVariable dword 7

.code
	
Dodaj proc a:dword, b:dword
; permutacja P klucza
;; I czêœæ permutacji
	mov edi, 0
	mov esi, 0
	mov eax, 0
	mov ebx, b
	movd mm2, eax	; zapisanie do mm2 wartoœci pocz¹tkowej
	movd mm3, edi   ; zapisanie do mm3 wartoœci pocz¹tkowej			
	jmp loopByte1

loopByte1:
	mov edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia
	mov al, byte ptr[permutationPone+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize						; dzielenie przez rozmiar bajtu by dowiedzieæ siê z którego bajta pobraæ bit
	mov al, byte ptr[key+eax]				; pobranie bajtu klucza z danej pozycji
	movd mm0, edx							; zapisanie do mm0 wartoœci z edx
	mov edx, 8								; zapisanie do edx = 8
	movd mm1, edx							; zapisanie do mm1 = edx
	psubd mm1,mm0							; mm1-mm0
	movd edx,mm1							; edx = mm1
	mov ecx, edx							; ecx = edx
	shr al,cl								; przesuniêcie bitowe w prawo o tyle pozycji z której trzeba wyci¹gn¹æ wartoœæ bitu
	and al,1								; sprawdzanie czy bit 1
	mov ecx,7								; ecx = 7
	sub ecx,edi								; ecx = ecx - edi
	shl al,cl								; przesuniêcie bitowe w lewo o tyle pozycji ile podane w ecx
	movd edx,mm2							; edx = mm2
	or eax, edx								; sumowanie wartoœci bitów eax i edx
	movd mm2,eax							; zapisanie do mm2 wartoœci eax
	inc edi									
	inc esi
	cmp edi, 8
	jne loopByte1

loopChar1:
	movd edi, mm3							; edi = mm3
	mov byte ptr[newKey+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	inc edi
	movd mm3, edi							; mm3 = edi
	mov edi, 0
	movd mm2, edi							; mm2 = edi
	cmp esi, 32
	jne loopByte1

;Wykonywanie tej samej operacji dla drugiej tablicy
	mov edi, 0
	mov esi, 0
	mov eax, 0
	movd mm2, eax	
	movd mm3, edi			
	jmp loopByte2

loopByte2:
	mov edx, 0								
	mov al, byte ptr[permutationPtwo+esi*4] 
	div arrayKeySize						
	mov al, byte ptr[key+eax]				
	movd mm0, edx
	mov edx, 8
	movd mm1, edx
	psubd mm1,mm0
	movd edx,mm1
	mov ecx, edx
	shr al,cl
	and al,1
	mov ecx,7
	sub ecx,edi
	shl al,cl
	movd edx,mm2
	or eax, edx
	movd mm2,eax
	inc edi	
	inc esi
	cmp edi, 8
	jne loopByte2

loopChar2:
	movd edi, mm3
	mov byte ptr[newKey+edi+4], al
	inc edi
	movd mm3, edi
	mov edi, 0
	movd mm2, edi	
	cmp esi, 32
	jne loopByte2
	
	mov edi, 0
	jmp wpisanieDanych

wpisanieDanych:
	mov cl, byte ptr [newKey+edi]
	mov byte ptr [ebx+edi], cl
	inc edi
	cmp edi,7
	jne wpisanieDanych
	
	emms
	ret

Dodaj endp 

end 
