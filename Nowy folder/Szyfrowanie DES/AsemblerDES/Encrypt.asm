.xmm
.model FLAT, STDCALL
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
	
	finalPermutationKey dword 14, 17, 11, 24,  1,  5,
							   3, 28, 15,  6, 21, 10,
							  23, 19, 12,  4, 26,  8,
							  16,  7, 27, 20, 13,  2,
							  41, 52, 31, 37, 47, 55,
							  30, 40, 51, 45, 33, 48,
							  44, 49, 39, 56, 34, 53,
							  46, 42, 50, 36, 29, 32
	
	key byte 4, 6, 23, 222, 16, 42, 5, 7
	
	newKey byte 0, 0, 0, 0, 0, 0, 0

	;Nowe klucze powsta³e w wyniku szesnastokrotnej permutacji
	subKeyCreate1a dword 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 ,
					    10, 11, 12, 13, 14, 15, 16, 17,
					    18, 19, 20, 21, 22, 23, 24, 25,
					    26, 27, 28, 1 , 30, 31, 32, 33
	subKeyCreate1b dword 34, 35, 36, 37, 38, 39, 40, 41,
					    42, 43, 44, 45, 46, 47, 48, 49,
					    50, 51, 52, 53, 54, 55, 56, 29
	subKeyCreate2a dword 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 ,
					    11, 12, 13, 14, 15, 16, 17, 18,
					    19, 20, 21, 22, 23, 24, 25, 26,
					    27, 28, 1,  2 , 31, 32, 33, 34
	subKeyCreate2b dword 35, 36, 37, 38, 39, 40, 41, 42,
					    43, 44, 45, 46, 47, 48, 49, 50,
					    51, 52, 53, 54, 55, 56, 29, 30

	subKey1  byte 0, 0, 0, 0, 0, 0, 0
	subKey2  byte 0, 0, 0, 0, 0, 0, 0
	subKey3  byte 0, 0, 0, 0, 0, 0, 0
	subKey4  byte 0, 0, 0, 0, 0, 0, 0
	subKey5  byte 0, 0, 0, 0, 0, 0, 0
	subKey6  byte 0, 0, 0, 0, 0, 0, 0
	subKey7  byte 0, 0, 0, 0, 0, 0, 0
	subKey8  byte 0, 0, 0, 0, 0, 0, 0
	subKey9  byte 0, 0, 0, 0, 0, 0, 0
	subKey10 byte 0, 0, 0, 0, 0, 0, 0
	subKey11 byte 0, 0, 0, 0, 0, 0, 0
	subKey12 byte 0, 0, 0, 0, 0, 0, 0
	subKey13 byte 0, 0, 0, 0, 0, 0, 0
	subKey14 byte 0, 0, 0, 0, 0, 0, 0
	subKey15 byte 0, 0, 0, 0, 0, 0, 0
	subKey16 byte 0, 0, 0, 0, 0, 0, 0

	finalSubKey1  byte 0, 0, 0, 0, 0, 0
	finalSubKey2  byte 0, 0, 0, 0, 0, 0
	finalSubKey3  byte 0, 0, 0, 0, 0, 0
	finalSubKey4  byte 0, 0, 0, 0, 0, 0
	finalSubKey5  byte 0, 0, 0, 0, 0, 0
	finalSubKey6  byte 0, 0, 0, 0, 0, 0
	finalSubKey7  byte 0, 0, 0, 0, 0, 0
	finalSubKey8  byte 0, 0, 0, 0, 0, 0
	finalSubKey9  byte 0, 0, 0, 0, 0, 0
	finalSubKey10 byte 0, 0, 0, 0, 0, 0
	finalSubKey11 byte 0, 0, 0, 0, 0, 0
	finalSubKey12 byte 0, 0, 0, 0, 0, 0
	finalSubKey13 byte 0, 0, 0, 0, 0, 0
	finalSubKey14 byte 0, 0, 0, 0, 0, 0
	finalSubKey15 byte 0, 0, 0, 0, 0, 0
	finalSubKey16 byte 0, 0, 0, 0, 0, 0
	
	arrayKeySize dword 8
	bitNewKeySize dword 56

	arrayKeyLSize dword 28

	constantStartValue dword 2

	PositionVariable dword 7

.code
;------------------------------------------------------------------------------------------------------------
; Zamiana wartoœci poszczególnych bitów, funkcja jest uniwersalna.
;------------------------------------------------------------------------------------------------------------
loopChangeBitValue proc
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
	ret
loopChangeBitValue endp
;------------------------------------------------------------------------------------------------------------
; Ustawianie wartoœci parametrów pocz¹tkowych
;------------------------------------------------------------------------------------------------------------
startParameters proc
	mov edi, 0
	mov esi, 0
	mov eax, 0
	movd mm2, eax	
	movd mm3, edi	
	ret
startParameters endp
;------------------------------------------------------------------------------------------------------------
; Zapisywanie wartoœci edi
;------------------------------------------------------------------------------------------------------------
ediSet proc
	inc edi
	movd mm3, edi							; mm3 = edi
	mov edi, 0
	movd mm2, edi							; mm2 = edi
	ret
ediSet endp

Dodaj proc a:dword, b:dword
;------------------------------------------------------------------------------------------------------------
; Wykonywanie P-permutacji by utworzyæ klucz 56 bitowy
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopPermutationPone:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[permutationPone+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize						; dzielenie przez rozmiar bajtu by dowiedzieæ siê z którego bajta pobraæ bit
	mov al, byte ptr[key+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopPermutationPone

	movd edi, mm3							; edi = mm3
	mov byte ptr[newKey+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopPermutationPone
	
	call startParameters
			
loopPermutationPtwo:
	mov edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[permutationPtwo+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize						; dzielenie przez rozmiar bajtu by dowiedzieæ siê z którego bajta pobraæ bit
	mov al, byte ptr[key+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopPermutationPtwo

	movd edi, mm3
	mov byte ptr[newKey+edi+4], al
	call ediSet
	cmp esi, 32
	jne loopPermutationPtwo
;------------------------------------------------------------------------------------------------------------
; Utworzenie pierwszego podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey1a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate1a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize			
	cmp edx,0
	jne continueSubKey1a
	mov edx,8
	cmp eax,0
	je continueSubKey1a
	dec eax

continueSubKey1a:			
	mov al, byte ptr[newKey+eax]				
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey1a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey1+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey1a

	call startParameters

loopCreateSubKey1b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate1b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey1b
	mov edx,8
	cmp eax,0
	je continueSubKey1b
	dec eax

continueSubKey1b:
	mov al, byte ptr[newKey+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey1b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey1+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey1b
;------------------------------------------------------------------------------------------------------------
; Utworzenie drugiego podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey2a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate1a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey2a
	mov edx,8
	cmp eax,0
	je continueSubKey2a
	dec eax

continueSubKey2a:						
	mov al, byte ptr[subKey1+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey2a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey2+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey2a

	call startParameters

loopCreateSubKey2b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate1b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize	
	cmp edx,0
	jne continueSubKey2b
	mov edx,8
	cmp eax,0
	je continueSubKey2b
	dec eax

continueSubKey2b:				
	mov al, byte ptr[subKey1+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey2b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey2+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey2b
;------------------------------------------------------------------------------------------------------------
; Utworzenie trzeciego podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey3a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey3a
	mov edx,8
	cmp eax,0
	je continueSubKey3a
	dec eax

continueSubKey3a:						
	mov al, byte ptr[subKey2+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey3a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey3+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey3a

	call startParameters

loopCreateSubKey3b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey3b
	mov edx,8
	cmp eax,0
	je continueSubKey3b
	dec eax
continueSubKey3b:				 
	mov al, byte ptr[subKey2+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey3b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey3+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey3b
;------------------------------------------------------------------------------------------------------------
; Utworzenie czwartego podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey4a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey4a
	mov edx,8
	cmp eax,0
	je continueSubKey4a
	dec eax

continueSubKey4a:						
	mov al, byte ptr[subKey3+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey4a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey4+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey4a

	call startParameters

loopCreateSubKey4b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey4b
	mov edx,8
	cmp eax,0
	je continueSubKey4b
	dec eax

continueSubKey4b:				 
	mov al, byte ptr[subKey3+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey4b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey4+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey4b
;------------------------------------------------------------------------------------------------------------
; Utworzenie pi¹tego podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey5a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey5a
	mov edx,8
	cmp eax,0
	je continueSubKey5a
	dec eax

continueSubKey5a:						
	mov al, byte ptr[subKey4+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey5a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey5+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey5a

	call startParameters

loopCreateSubKey5b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey5b
	mov edx,8
	cmp eax,0
	je continueSubKey5b
	dec eax

continueSubKey5b:				 
	mov al, byte ptr[subKey4+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey5b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey5+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey5b
;------------------------------------------------------------------------------------------------------------
; Utworzenie szóstego podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey6a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey6a
	mov edx,8
	cmp eax,0
	je continueSubKey6a
	dec eax

continueSubKey6a:						
	mov al, byte ptr[subKey5+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey6a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey6+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey6a

	call startParameters

loopCreateSubKey6b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey6b
	mov edx,8
	cmp eax,0
	je continueSubKey6b
	dec eax

continueSubKey6b:				 
	mov al, byte ptr[subKey5+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey6b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey6+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey6b
;------------------------------------------------------------------------------------------------------------
; Utworzenie siódmego podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey7a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey7a
	mov edx,8
	cmp eax,0
	je continueSubKey7a
	dec eax

continueSubKey7a:						
	mov al, byte ptr[subKey6+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey7a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey7+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey7a

	call startParameters

loopCreateSubKey7b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey7b
	mov edx,8
	cmp eax,0
	je continueSubKey7b
	dec eax

continueSubKey7b:				 
	mov al, byte ptr[subKey6+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey7b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey7+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey7b
;------------------------------------------------------------------------------------------------------------
; Utworzenie ósmy podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey8a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey8a
	mov edx,8
	cmp eax,0
	je continueSubKey8a
	dec eax

continueSubKey8a:						
	mov al, byte ptr[subKey7+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey8a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey8+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey8a

	call startParameters

loopCreateSubKey8b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey8b
	mov edx,8
	cmp eax,0
	je continueSubKey8b
	dec eax

continueSubKey8b:				 
	mov al, byte ptr[subKey7+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey8b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey8+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey8b
;------------------------------------------------------------------------------------------------------------
; Utworzenie dziewi¹ty podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey9a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate1a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey9a
	mov edx,8
	cmp eax,0
	je continueSubKey9a
	dec eax

continueSubKey9a:						
	mov al, byte ptr[subKey8+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey9a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey9+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey9a

	call startParameters

loopCreateSubKey9b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate1b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey9b
	mov edx,8
	cmp eax,0
	je continueSubKey9b
	dec eax

continueSubKey9b:				 
	mov al, byte ptr[subKey8+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey9b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey9+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey9b
;------------------------------------------------------------------------------------------------------------
; Utworzenie dziesi¹tego podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey10a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey10a
	mov edx,8
	cmp eax,0
	je continueSubKey10a
	dec eax

continueSubKey10a:						
	mov al, byte ptr[subKey9+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey10a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey10+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey10a

	call startParameters

loopCreateSubKey10b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey10b
	mov edx,8
	cmp eax,0
	je continueSubKey10b
	dec eax

continueSubKey10b:				 
	mov al, byte ptr[subKey9+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey10b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey10+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey10b
;------------------------------------------------------------------------------------------------------------
; Utworzenie jedenastego podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey11a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey11a
	mov edx,8
	cmp eax,0
	je continueSubKey11a
	dec eax

continueSubKey11a:						
	mov al, byte ptr[subKey10+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey11a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey11+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey11a

	call startParameters

loopCreateSubKey11b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey11b
	mov edx,8
	cmp eax,0
	je continueSubKey11b
	dec eax

continueSubKey11b:				 
	mov al, byte ptr[subKey10+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey11b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey11+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey11b
;------------------------------------------------------------------------------------------------------------
; Utworzenie dwunastego podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey12a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey12a
	mov edx,8
	cmp eax,0
	je continueSubKey12a
	dec eax

continueSubKey12a:						
	mov al, byte ptr[subKey11+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey12a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey12+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey12a

	call startParameters

loopCreateSubKey12b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey12b
	mov edx,8
	cmp eax,0
	je continueSubKey12b
	dec eax

continueSubKey12b:				 
	mov al, byte ptr[subKey11+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey12b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey12+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey12b
;------------------------------------------------------------------------------------------------------------
; Utworzenie trzynastego podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey13a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey13a
	mov edx,8
	cmp eax,0
	je continueSubKey13a
	dec eax

continueSubKey13a:						
	mov al, byte ptr[subKey12+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey13a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey13+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey13a

	call startParameters

loopCreateSubKey13b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey13b
	mov edx,8
	cmp eax,0
	je continueSubKey13b
	dec eax

continueSubKey13b:				 
	mov al, byte ptr[subKey12+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey13b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey13+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey13b
;------------------------------------------------------------------------------------------------------------
; Utworzenie czternastego podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey14a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey14a
	mov edx,8
	cmp eax,0
	je continueSubKey14a
	dec eax

continueSubKey14a:						
	mov al, byte ptr[subKey13+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey14a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey14+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey14a

	call startParameters

loopCreateSubKey14b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey14b
	mov edx,8
	cmp eax,0
	je continueSubKey14b
	dec eax

continueSubKey14b:				 
	mov al, byte ptr[subKey13+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey14b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey14+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey14b
;------------------------------------------------------------------------------------------------------------
; Utworzenie piêtnastego podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey15a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey15a
	mov edx,8
	cmp eax,0
	je continueSubKey15a
	dec eax

continueSubKey15a:						
	mov al, byte ptr[subKey14+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey15a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey15+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey15a

	call startParameters

loopCreateSubKey15b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate2b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey15b
	mov edx,8
	cmp eax,0
	je continueSubKey15b
	dec eax

continueSubKey15b:				 
	mov al, byte ptr[subKey14+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey15b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey15+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey15b
;-----------------------------------------------------------------------------------
; Utworzenie szesnastego podklucza w wyniku przesuniêcia bitowego
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopCreateSubKey16a:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate1a+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey16a
	mov edx,8
	cmp eax,0
	je continueSubKey16a
	dec eax

continueSubKey16a:						
	mov al, byte ptr[subKey15+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey16a

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey16+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey16a

	call startParameters

loopCreateSubKey16b:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[subKeyCreate1b+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueSubKey16b
	mov edx,8
	cmp eax,0
	je continueSubKey16b
	dec eax

continueSubKey16b:				 
	mov al, byte ptr[subKey15+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopCreateSubKey16b

	movd edi, mm3							; edi = mm3
	mov byte ptr[subKey16+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne loopCreateSubKey16b
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 1 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute1:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm1
	mov edx,8
	cmp eax,0
	je continuePerm1
	dec eax

continuePerm1:						
	mov al, byte ptr[subKey1+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute1

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey1+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute1
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 2 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute2:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm2
	mov edx,8
	cmp eax,0
	je continuePerm2
	dec eax

continuePerm2:						
	mov al, byte ptr[subKey2+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute2

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey2+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute2
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 3 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute3:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm3
	mov edx,8
	cmp eax,0
	je continuePerm3
	dec eax

continuePerm3:						
	mov al, byte ptr[subKey3+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute3

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey3+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute3
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 4 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute4:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm4
	mov edx,8
	cmp eax,0
	je continuePerm4
	dec eax

continuePerm4:						
	mov al, byte ptr[subKey4+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute4

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey4+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute4
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 5 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute5:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm5
	mov edx,8
	cmp eax,0
	je continuePerm5
	dec eax

continuePerm5:						
	mov al, byte ptr[subKey5+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute5

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey5+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute5
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 6 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute6:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm6
	mov edx,8
	cmp eax,0
	je continuePerm6
	dec eax

continuePerm6:						
	mov al, byte ptr[subKey6+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute6

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey6+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute6
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 7 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute7:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm7
	mov edx,8
	cmp eax,0
	je continuePerm7
	dec eax

continuePerm7:						
	mov al, byte ptr[subKey7+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute7

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey6+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute7
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 8 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute8:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm8
	mov edx,8
	cmp eax,0
	je continuePerm8
	dec eax

continuePerm8:						
	mov al, byte ptr[subKey8+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute8

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey8+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute8
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 9 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute9:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm9
	mov edx,8
	cmp eax,0
	je continuePerm9
	dec eax

continuePerm9:						
	mov al, byte ptr[subKey9+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute9

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey9+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute9
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 10 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute10:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm10
	mov edx,8
	cmp eax,0
	je continuePerm10
	dec eax

continuePerm10:						
	mov al, byte ptr[subKey10+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute10

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey10+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute10
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 11 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute11:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm11
	mov edx,8
	cmp eax,0
	je continuePerm11
	dec eax

continuePerm11:						
	mov al, byte ptr[subKey11+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute11

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey11+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute11
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 12 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute12:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm12
	mov edx,8
	cmp eax,0
	je continuePerm12
	dec eax

continuePerm12:						
	mov al, byte ptr[subKey12+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute12

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey12+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute12
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 13 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute13:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm13
	mov edx,8
	cmp eax,0
	je continuePerm13
	dec eax

continuePerm13:						
	mov al, byte ptr[subKey13+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute13

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey13+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute13
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 14 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute14:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm14
	mov edx,8
	cmp eax,0
	je continuePerm14
	dec eax

continuePerm14:						
	mov al, byte ptr[subKey14+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute14

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey14+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute14
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 15 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute15:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm15
	mov edx,8
	cmp eax,0
	je continuePerm15
	dec eax

continuePerm15:						
	mov al, byte ptr[subKey15+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute15

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey15+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute15
;------------------------------------------------------------------------------------------------------------
; Permutowanie koñcowe 16 z 16 podklucza.
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopLastPermute16:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalPermutationKey+esi*4] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm16
	mov edx,8
	cmp eax,0
	je continuePerm16
	dec eax

continuePerm16:						
	mov al, byte ptr[subKey16+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne loopLastPermute16

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalSubKey16+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 48
	jne loopLastPermute16

wpisanieDanych:
	mov ebx, b
	mov cl, byte ptr [finalSubKey14+edi]
	mov byte ptr [ebx+edi], cl
	inc edi
	cmp edi,7
	jne wpisanieDanych
	emms
	ret
Dodaj endp 

end 
