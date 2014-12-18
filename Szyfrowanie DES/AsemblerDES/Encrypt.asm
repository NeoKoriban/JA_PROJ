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

	dataStartPermutation1 dword 58,	50,	42,	34,	26,	18,	10,	2,
								60,	52,	44,	36,	28,	20,	12,	4,
								62,	54,	46,	38,	30,	22,	14,	6,
								64,	56,	48,	40,	32,	24,	16,	8
	dataStartPermutation2 dword 57,	49,	41,	33,	25,	17,	9,	1,
								59,	51,	43, 35,	27,	19,	11,	3,
								61,	53,	45,	37,	29,	21,	13,	5,
								63,	55,	47,	39,	31,	23,	15,	7

	dataEPermutation1 dword		32,	1 ,	2 ,	3 ,	4 ,	5 ,
								4 ,	5 ,	6 ,	7 ,	8 ,	9 ,
								8 ,	9 ,	10,	11,	12,	13,
								12,	13,	14,	15,	16,	17
	dataEPermutation2 dword		16,	17,	18,	19,	20,	21,
								20,	21,	22,	23,	24,	25,
								24,	25,	26,	27,	28,	29,
								28,	29,	30,	31,	32,	1

	finalPermutationKey dword 14, 17, 11, 24,  1,  5,
							   3, 28, 15,  6, 21, 10,
							  23, 19, 12,  4, 26,  8,
							  16,  7, 27, 20, 13,  2,
							  41, 52, 31, 37, 47, 55,
							  30, 40, 51, 45, 33, 48,
							  44, 49, 39, 56, 34, 53,
							  46, 42, 50, 36, 29, 32
	
	key byte 4, 6, 23, 222, 16, 42, 5, 7
	
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
	
	newKey byte 0, 0, 0, 0, 0, 0, 0

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

	leftSide	  byte 0, 0, 0, 0
	rightSide     byte 0, 0, 0, 0
	newrightSide  byte 0, 0, 0, 0
	oldrightSide  byte 0, 0, 0, 0
	rightEPermRes byte 0, 0, 0, 0, 0, 0
	
	S1_00 dword	14,	 4, 13,  1,  2, 15, 11,  8,  3, 10,  6,	12,  5,  9,  0,  7
	S1_01 byte   0,	15,	 7,	 4,	14,	 2,	13,	 1,	10,	 6,	12,	11,	 9,	 5,	 3,	 8
	S1_10 byte   4,	 1,	14,	 8,	13,	 6,	 2,	11,	15,	12,	 9,	 7,	 3,	10,	 5,	 0
	S1_11 byte  15,	12,	 8,	 2,	 4,	 9,	 1,	 7,	 5,	11,	 3,	14,	10,	 0,	 6,	13
	S2_00 byte	15,	 1,	 8,	14,	 6,	11,	 3,	 4,	 9,	 7,	 2,	13,	12,	 0,	 5,	10
	S2_01 byte   3,	13,	 4,	 7,	15,	 2,	 8,	14,	12,	 0,	 1,	10,	 6,	 9,	11,	 5
	S2_10 byte   0,	14,	 7,	11,	10,	 4,	13,	 1,	 5,	 8,	12,	 6,	 9,	 3,	 2,	15
	S2_11 byte  13,	 8,	10,	 1,	 3,	15,	 4,	 2,	11,	 6,	 7,	12,	 0,	 5,	14,	 9
	S3_00 byte	10,	 0,	 9,	14,	 6,	 3,	15,	 5,	 1,	13,	12,	 7,	11,	 4,	 2,	 8
	S3_01 byte  13,	 7,	 0,	 9,  3,	 4,	 6,	10,	 2,	 8,	 5,	14,	12,	11,	15,	 1
	S3_10 byte  13,	 6,	 4,	 9,	 8,	15,	 3,	 0,	11,	 1,	 2,	12,	 5,	10,	14,	 7
	S3_11 byte   1,	10,	13,	 0,	 6,	 9,	 8,	 7,	 4,	15,	14,	 3,	11,	 5,	 2,	12
	S4_00 byte	 7,	13,	14,	 3,	 0,	 6,	 9,	10,	 1,	 2,	 8,	 5,	11,	12,	 4,	15
	S4_01 byte  13,	 8,	11,	 5,	 6,	15,	 0,  3,	 4,	 7,	 2,	12,	 1,	10,	14,	 9
	S4_10 byte  10,	 6,	 9,	 0,	12,	11,	 7,	13,	15,	 1,	 3,	14,	 5,	 2,	 8,	 4
	S4_11 byte   3,	15,	 0,	 6,	10,	 1,	13,	 8,	 9,	 4,	 5,	11,	12,	 7,	 2,	14
	S5_00 byte	 2,	12,	 4,	 1,	 7,	10,	11,	 6,	 8,	 5,	 3,	15,	13,	 0,	14,	 9
	S5_01 byte  14,	11,	 2,	12,	 4,	 7,	13,	 1,	 5,	 0,	15,	10,	 3,	 9,	 8,	 6
	S5_10 byte   4,	 2,	 1,	11,	10,	13,	 7,	 8,	15,	 9,	12,	 5,	 6,	 3,	 0,	14
	S5_11 byte  11,	 8,	12,	 7,	 1,	14,	 2,	13,	 6,	15,	 0,	 9,	10,	 4,	 5,	 3
	S6_00 byte	12,	 1,	10,	15,	 9,	 2,	 6,	 8,	 0,	13,	 3,	 4,	14,	 7,	 5,	11
	S6_01 byte  10,	15,	 4,	 2,  7,	12,	 9,	 5,	 6,	 1,	13,	14,	 0,	11,	 3,	 8
	S6_10 byte   9,	14,	15,	 5,	 2,	 8,	12,	 3,	 7,	 0,	 4,	10,	 1,	13,	11,	 6
	S6_11 byte   4,	 3,	 2,	12,	 9,	 5,	15,	10,	11,	14,	 1,	 7,	 6,	 0,	 8,	13
	S7_00 byte	 4,	11,	 2,	14,	15,	 0,	 8,	13,	 3,	12,	 9,	 7,	 5,	10,	 6,	 1
	S7_01 byte  13,	 0,	11,	 7,	 4,	 9,	 1,	10,	14,	 3,	 5,	12,	 2,	15,	 8,	 6
	S7_10 byte   1,	 4,	11,	13,	12,	 3,	 7,	14,	10,	15,	 6,	 8,	 0,	 5,	 9,	 2
	S7_11 byte   6,	11,	13,	 8,	 1,	 4,	10,	 7,	 9,	 5,	 0,	15,	14,	 2,	 3,	12
	S8_00 byte	13,	 2,	 8,	 4,	 6,	15,	11,	 1,	10,	 9,	 3,	14,	 5,	 0,	12,	 7
	S8_01 byte   1,	15,	13,	 8,	10,	 3,	 7,	 4,	12,	 5,	 6,	11,	 0,	14,	 9,	 2
	S8_10 byte   7,	11,	 4,	 1,	 9,	12,	14,	 2,	 0,	 6,	10,	13,	15,	 3,	 5,	 8
	S8_11 byte   2,	 1,	14,	 7,	 4,	10,	 8,	13,	15,	12,	 9,	 0,	 3,	 5,	 6,	11

	SPom_1_1 byte 128, 64,  32,  17,   8,   4
	SPom_1_2 byte   2,  1, 128,  64,  32,  16
	SPom_2_1 byte   8,  4,   2,   1, 128,  64
	SPom_2_2 byte  32,  16,  8,   4,   2,   1

	sboxedPerm byte 16,	 7,	20,	21, 29,	12,	28,	17,
					 1,	15,	23,	26,  5,	18,	31,	10,
					 2,	 8,	24,	14, 32,	27,	 3,	 9,
					19,	13,	30,	 6, 22,	11,	 4,	25

	finalDataPermutation1 byte	40,	 8,	48,	16,	56,	24,	64,	32,
								39,	 7,	47,	15,	55,	23,	63,	31,
								38,	 6,	46,	14,	54,	22,	62,	30,
								37,	 5,	45,	13,	53,	21,	61,	29
	finalDataPermutation2 byte	36,	 4,	44,	12,	52,	20,	60,	28,
								35,	 3,	43,	11,	51,	19,	59,	27,
								34,	 2,	42,	10,	50,	18,	58,	26,
								33,	 1,	41,  9,	49,	17,	57,	25
	newData byte	0, 0, 0, 0, 0, 0, 0, 0
	finalData byte	0, 0, 0, 0, 0, 0, 0, 0
	arrayKeySize dword 8
	bitNewKeySize dword 56

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

PrzygotowanieKlucza proc
;------------------------------------------------------------------------------------------------------------
; Wykonywanie P-permutacji by utworzyæ klucz 56 bitowy
;------------------------------------------------------------------------------------------------------------
	call startParameters

loopPermutationPone:
	mov al, byte ptr[permutationPone+esi*4] ; pobranie wartoœci który bajt
	mov	edx, 0							    ; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
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


	emms
	ret
PrzygotowanieKlucza endp 
;------------------------------------------------------------------------------------------------------------
; Dodawanie odpowiedniej wartoœci w celu wybrania na póŸniejszym etapie odpowiedniego indeksu tablicy oraz odpowiedniej tablicy.
;------------------------------------------------------------------------------------------------------------
AddValue proc
	cmp esi, 0
	je firstValue
	cmp esi, 1
	je secondValue
	cmp esi, 2
	je thirdValue
	cmp esi, 3
	je fourthValue
	cmp esi, 4
	je fifthValue
	cmp esi, 5
	je sixthValue

firstValue:
	and al, cl
	cmp al, cl
	je dodaj2p
	jmp koniec

secondValue:
	and al, cl
	cmp al, cl
	je dodaj8s
	jmp koniec

thirdValue:
	and al, cl
	cmp al, cl
	je dodaj4s
	jmp koniec

fourthValue:
	and al, cl	
	cmp al, cl
	je dodaj2s
	jmp koniec

fifthValue:
	and al, cl	
	cmp al, cl
	je dodaj1s
	jmp koniec

sixthValue:
	and al, cl	
	cmp al, cl
	je dodaj1p
	jmp koniec

dodaj2p:
	add edx, 2
	jmp koniec

dodaj1p:
	add edx, 1
	jmp koniec


dodaj8s:
	add ebx, 8
	jmp koniec

dodaj4s:
	add ebx, 4
	jmp koniec

dodaj2s:
	add ebx, 2
	jmp koniec

dodaj1s:
	add ebx, 1
	jmp koniec

koniec:
	inc esi
	ret

AddValue endp
;------------------------------------------------------------------------------------------------------------------------------------
; Wprowadzenie odpowiedniej wartoœci do prawej strony cz1
;------------------------------------------------------------------------------------------------------------------------------------
InsertValueRightSide1 proc
	shl al, 4
	movd edi,mm5
	mov byte ptr [rightSide+edi], 0
	mov byte ptr [rightSide+edi], al
	movd mm5, edi
	call startParameters
	mov edx,0
	mov ebx,0
	
	ret
InsertValueRightSide1 endp
;------------------------------------------------------------------------------------------------------------------------------------
; Wprowadzenie odpowiedniej wartoœci do prawej strony cz2
;------------------------------------------------------------------------------------------------------------------------------------
InsertValueRightSide2 proc
	movd mm0, eax
	movd edi, mm5
	mov al, byte ptr [rightSide+edi]
	movd mm1, eax
	por mm0, mm1
	movd eax, mm0
	mov byte ptr [rightSide+edi], al
	inc edi
	movd mm5, edi
	call startParameters
		mov edx,0
	mov ebx,0
	ret
InsertValueRightSide2 endp
;------------------------------------------------------------------------------------------------------------------------------------
; Pocz¹tek iteracji.
;------------------------------------------------------------------------------------------------------------------------------------
siteration proc
	call startParameters
	
oldequalsright:
	mov cl, byte ptr [rightSide+edi]
	mov byte ptr [oldrightSide+edi], cl
	inc edi
	cmp edi,4
	jne oldequalsright
	call startParameters
	mov esi, 0
	mov edi, 0

EpermutationLoop1:
	mov	edx, 0								
	mov al, byte ptr[dataEPermutation1+esi*4]
	div arrayKeySize
	cmp edx,0
	jne continueEPermutation1					
	mov edx,8
	cmp eax,0
	je continueEPermutation1				
	dec eax

continueEPermutation1:						
	mov al, byte ptr[rightSide+eax]			
	call loopChangeBitValue
	cmp edi, 8
	jne EpermutationLoop1
	movd edi, mm3							
	mov byte ptr[rightEPermRes+edi], al		
	call ediSet
	cmp esi, 24
	jne EpermutationLoop1
	call startParameters

EpermutationLoop2:
	mov	edx, 0								
	mov al, byte ptr[dataEPermutation2+esi*4]
	div arrayKeySize
	cmp edx,0
	jne continueEPermutation2					
	mov edx,8
	cmp eax,0
	je continueEPermutation2				
	dec eax

continueEPermutation2:						
	mov al, byte ptr[rightSide+eax]			
	call loopChangeBitValue
	cmp edi, 8
	jne EpermutationLoop2
	movd edi, mm3							
	mov byte ptr[rightEPermRes+edi+3], al		
	call ediSet
	cmp esi, 24
	jne EpermutationLoop2
	call startParameters
	ret
siteration endp
;------------------------------------------------------------------------------------------------------------------------------------
; Koniec iteracji.
;------------------------------------------------------------------------------------------------------------------------------------
cditeration proc
	call startParameters
	mov edx, 0
	mov esi, 0
	mov ebx, 0
	mov edi, 0
	movd mm5, edi
	
podpetla1Value:
	mov al, byte ptr [rightEPermRes+0]
	mov cl, byte ptr [SPom_1_1+esi]
	call AddValue
	cmp esi,6
	jne podpetla1Value
	mov esi, 0								; wyzerowanie esi
											; sprawdzenie która tablica ma zostaæ wziêta pod uwagê
	cmp dl, 0
	je sb1_00
	cmp dl, 1
	je sb1_01
	cmp dl, 2
	je sb1_10
	cmp dl, 3
	je sb1_11
next11:
	call InsertValueRightSide1
	jmp podpetla2aValue

sb1_00:
	mov al, byte ptr [S1_00+ebx]
	jmp next11
sb1_01:
	mov al, byte ptr [S1_01+ebx]
	jmp next11
sb1_10:
	mov al, byte ptr [S1_10+ebx]
	jmp next11
sb1_11:
	mov al, byte ptr [S1_11+ebx]
	jmp next11
	
podpetla2aValue:
	mov al, byte ptr [rightEPermRes+0]
	mov cl, byte ptr [SPom_1_2+esi]
	call AddValue
	cmp esi,2
	jne podpetla2aValue
podpetla2bValue:
	mov al, byte ptr [rightEPermRes+1]
	mov cl, byte ptr [SPom_1_2+esi]
	call AddValue
	cmp esi,6
	jne podpetla2bValue
	mov esi, 0
	cmp dl, 0
	je sb2_00
	cmp edx, 1
	je sb2_01
	cmp edx, 2
	je sb2_10
	cmp edx, 3
	je sb2_11
next12:
	call InsertValueRightSide2
	jmp podpetla3aValue

sb2_00:
	mov al, byte ptr [S2_00+ebx]
	jmp next12
sb2_01:
	mov al, byte ptr [S2_01+ebx]
	jmp next12
sb2_10:
	mov al, byte ptr [S2_10+ebx]
	jmp next12
sb2_11:
	mov al, byte ptr [S2_11+ebx]
	jmp next12

podpetla3aValue:
	mov al, byte ptr [rightEPermRes+1]
	mov cl, byte ptr [SPom_2_1+esi]
	call AddValue
	cmp esi,4 
	jne podpetla3aValue
podpetla3bValue:
	mov al, byte ptr [rightEPermRes+2]
	mov cl, byte ptr [SPom_2_1+esi]
	call AddValue
	cmp esi,6
	jne podpetla3bValue
	mov esi, 0
	cmp edx, 0
	je sb3_00
	cmp edx, 1
	je sb3_01
	cmp edx, 2
	je sb3_10
	cmp edx, 3
	je sb3_11
next21:
	call InsertValueRightSide1
	jmp podpetla4Value

sb3_00:
	mov al, byte ptr [S3_00+ebx]
	jmp next21
sb3_01:
	mov al, byte ptr [S3_01+ebx]
	jmp next21
sb3_10:
	mov al, byte ptr [S3_10+ebx]
	jmp next21
sb3_11:
	mov al, byte ptr [S3_11+ebx]
	jmp next21

podpetla4Value:
	mov al, byte ptr [rightEPermRes+2]
	mov cl, byte ptr [SPom_2_2+esi]
	call AddValue
	cmp esi,6
	jne podpetla4Value
	mov esi, 0
	cmp dl, 0
	je sb4_00
	cmp dl, 1
	je sb4_01
	cmp dl, 2
	je sb4_10
	cmp dl, 3
	je sb4_11
next22:
	call InsertValueRightSide2
	jmp podpetla5Value

sb4_00:
	mov al, byte ptr [S4_00+ebx]
	jmp next22
sb4_01:
	mov al, byte ptr [S4_01+ebx]
	jmp next22
sb4_10:
	mov al, byte ptr [S4_10+ebx]
	jmp next22
sb4_11:
	mov al, byte ptr [S4_11+ebx]
	jmp next22

podpetla5Value:
	mov al, byte ptr [rightEPermRes+3]
	mov cl, byte ptr [SPom_1_1+esi]
	call AddValue
	cmp esi,6
	jne podpetla5Value
	mov esi, 0								; wyzerowanie esi
											; sprawdzenie która tablica ma zostaæ wziêta pod uwagê
	cmp dl, 0
	je sb5_00
	cmp dl, 1
	je sb5_01
	cmp dl, 2
	je sb5_10
	cmp dl, 3
	je sb5_11
next31:
	call InsertValueRightSide1
	jmp podpetla6aValue

sb5_00:
	mov al, byte ptr [S5_00+ebx]
	jmp next31
sb5_01:
	mov al, byte ptr [S5_01+ebx]
	jmp next31
sb5_10:
	mov al, byte ptr [S5_10+ebx]
	jmp next31
sb5_11:
	mov al, byte ptr [S5_11+ebx]
	jmp next31

podpetla6aValue:
	mov al, byte ptr [rightEPermRes+3]
	mov cl, byte ptr [SPom_1_2+esi]
	call AddValue
	cmp esi,2
	jne podpetla6aValue
podpetla6bValue:
	mov al, byte ptr [rightEPermRes+4]
	mov cl, byte ptr [SPom_1_2+esi]
	call AddValue
	cmp esi,6
	jne podpetla6bValue
	mov esi, 0
	cmp dl, 0
	je sb6_00
	cmp edx, 1
	je sb6_01
	cmp edx, 2
	je sb6_10
	cmp edx, 3
	je sb6_11
next32:
	call InsertValueRightSide2
	jmp podpetla7aValue

sb6_00:
	mov al, byte ptr [S6_00+ebx]
	jmp next32
sb6_01:
	mov al, byte ptr [S6_01+ebx]
	jmp next32
sb6_10:
	mov al, byte ptr [S6_10+ebx]
	jmp next32
sb6_11:
	mov al, byte ptr [S6_11+ebx]
	jmp next32

podpetla7aValue:
	mov al, byte ptr [rightEPermRes+4]
	mov cl, byte ptr [SPom_2_1+esi]
	call AddValue
	cmp esi,4 
	jne podpetla7aValue
podpetla7bValue:
	mov al, byte ptr [rightEPermRes+5]
	mov cl, byte ptr [SPom_2_1+esi]
	call AddValue
	cmp esi,6
	jne podpetla7bValue
	mov esi, 0
	cmp dl, 0
	je sb7_00
	cmp dl, 1
	je sb7_01
	cmp dl, 2
	je sb7_10
	cmp dl, 3
	je sb7_11
next41:
	call InsertValueRightSide1
	jmp podpetla8Value

sb7_00:
	mov al, byte ptr [S7_00+ebx]
	jmp next41
sb7_01:
	mov al, byte ptr [S7_01+ebx]
	jmp next41
sb7_10:
	mov al, byte ptr [S7_10+ebx]
	jmp next41
sb7_11:
	mov al, byte ptr [S7_11+ebx]
	jmp next41

podpetla8Value:
	mov al, byte ptr [rightEPermRes+5]
	mov cl, byte ptr [SPom_2_2+esi]
	call AddValue
	cmp esi,6
	jne podpetla8Value

	cmp dl, 0
	je sb8_00
	cmp dl, 1
	je sb8_01
	cmp dl, 2
	je sb8_10
	cmp dl, 3
	je sb8_11
next42:
	call InsertValueRightSide2
	jmp sboxPermLoop

sb8_00:
	mov al, byte ptr [S8_00+ebx]
	jmp next42
sb8_01:
	mov al, byte ptr [S8_01+ebx]
	jmp next42
sb8_10:
	mov al, byte ptr [S8_10+ebx]
	jmp next42
sb8_11:
	mov al, byte ptr [S8_11+ebx]
	jmp next42

call startParameters
mov esi, 0
mov edi, 0

sboxPermLoop:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[sboxedPerm +esi] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continuePerm
	mov edx,8
	cmp eax,0
	je continuePerm
	dec eax

continuePerm:						
	mov al, byte ptr[rightSide+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne sboxPermLoop

	movd edi, mm3							; edi = mm3
	mov byte ptr[newrightSide+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne sboxPermLoop
	call startParameters
	mov esi, 0
	mov edi, 0

	xorRandL:
	mov al, byte ptr [leftSide+edi]
	movd mm0, eax
	mov dl, byte ptr [newrightSide+edi]
	movd mm1, edx
	pxor mm1, mm0
	movd ecx, mm1
	mov byte ptr[rightSide+edi], cl
	inc edi
	cmp edi,4
	jne xorRandL

	call startParameters
	mov esi, 0
	mov edi, 0

rightequalsleft:
	mov cl, byte ptr [oldrightSide+edi]
	mov byte ptr [leftSide+edi], cl
	inc edi
	cmp edi,4
	jne rightequalsleft
	call startParameters
	mov esi, 0
	mov edi, 0
	
	ret
cditeration endp

subXorFunction proc
	movd mm0, eax
	mov dl, byte ptr [rightEPermRes+edi]
	movd mm1, edx
	pxor mm1, mm0
	movd ecx, mm1
	mov byte ptr[rightEPermRes+edi], cl
	inc edi
	ret
subXorFunction endp
;------------------------------------------------------------------------------------------------------------
; Funkcja szyfrowania g³ówna
;------------------------------------------------------------------------------------------------------------
Szyfruj proc data:dword, encrypt:dword
	
	call PrzygotowanieKlucza
	mov ebx, data
	call startParameters
	
dataPermutationLoop1:
	mov	edx, 0								
	mov al, byte ptr[dataStartPermutation1+esi*4]
	div arrayKeySize
	cmp edx,0
	jne continueDataPermutation1						
	mov edx,8
	cmp eax,0
	je continueDataPermutation1						
	dec eax

continueDataPermutation1:						
	mov al, byte ptr[ebx+eax]			
	call loopChangeBitValue
	cmp edi, 8
	jne dataPermutationLoop1
	movd edi, mm3							
	mov byte ptr[leftSide+edi], al		
	call ediSet
	cmp esi, 32
	jne dataPermutationLoop1
	call startParameters
	
dataPermutationLoop2:
	mov	edx, 0								
	mov al, byte ptr[dataStartPermutation2+esi*4]
	div arrayKeySize
	cmp edx,0
	jne continueDataPermutation2						
	mov edx,8
	cmp eax,0
	je continueDataPermutation2					
	dec eax

continueDataPermutation2:						
	mov al, byte ptr[ebx+eax]			
	call loopChangeBitValue
	cmp edi, 8
	jne dataPermutationLoop2
	movd edi, mm3							
	mov byte ptr[rightSide+edi], al		
	call ediSet
	cmp esi, 32
	jne dataPermutationLoop2
	
	call siteration
DaneDoXorLoop1:
	mov al, byte ptr [finalSubKey1+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop1
	call cditeration

	call siteration
DaneDoXorLoop2:
	mov al, byte ptr [finalSubKey2+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop2
	call cditeration

	call siteration
DaneDoXorLoop3:
	mov al, byte ptr [finalSubKey3+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop3
	call cditeration

	call siteration
DaneDoXorLoop4:
	mov al, byte ptr [finalSubKey4+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop4
	call cditeration

	call siteration
DaneDoXorLoop5:
	mov al, byte ptr [finalSubKey5+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop5
	call cditeration

	call siteration
DaneDoXorLoop6:
	mov al, byte ptr [finalSubKey6+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop6
	call cditeration

	call siteration
DaneDoXorLoop7:
	mov al, byte ptr [finalSubKey7+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop7
	call cditeration

	call siteration
DaneDoXorLoop8:
	mov al, byte ptr [finalSubKey8+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop8
	call cditeration

	call siteration
DaneDoXorLoop9:
	mov al, byte ptr [finalSubKey9+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop9
	call cditeration

	call siteration
DaneDoXorLoop10:
	mov al, byte ptr [finalSubKey10+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop10
	call cditeration

	call siteration
DaneDoXorLoop11:
	mov al, byte ptr [finalSubKey11+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop11
	call cditeration

	call siteration
DaneDoXorLoop12:
	mov al, byte ptr [finalSubKey12+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop12
	call cditeration

	call siteration
DaneDoXorLoop13:
	mov al, byte ptr [finalSubKey13+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop13
	call cditeration

	call siteration
DaneDoXorLoop14:
	mov al, byte ptr [finalSubKey14+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop14
	call cditeration

	call siteration
DaneDoXorLoop15:
	mov al, byte ptr [finalSubKey15+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop15
	call cditeration

	call siteration
DaneDoXorLoop16:
	mov al, byte ptr [finalSubKey16+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop16
	call cditeration
noweDane1:
	mov ebx, encrypt
	mov cl, byte ptr [rightSide+edi]
	mov byte ptr [newData+edi], cl
	inc edi
	cmp edi,4
	jne noweDane1
noweDane2:
	mov ebx, encrypt
	mov cl, byte ptr [leftSide+edi-4]
	mov byte ptr [newData+edi], cl
	inc edi
	cmp edi,8
	jne noweDane2
	call startParameters

finalP1:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalDataPermutation1+esi] ; pobranie wartoœci który bajt
	div arrayKeySize			
	cmp edx,0
	jne continueFinalP1
	mov edx,8
	cmp eax,0
	je continueFinalP1
	dec eax

continueFinalP1:			
	mov al, byte ptr[newData+eax]				
	call loopChangeBitValue
	cmp edi, 8
	jne finalP1

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalData+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne finalP1

	call startParameters

finalP2:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalDataPermutation2+esi] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueFinalP2
	mov edx,8
	cmp eax,0
	je continueFinalP2
	dec eax

continueFinalP2:
	mov al, byte ptr[newData+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne finalP2

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalData+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne finalP2
	call startParameters

wpisanieDanych:
	mov ebx, encrypt
	mov cl, byte ptr [finalData+edi]
	mov byte ptr [ebx+edi], cl
	inc edi
	cmp edi,8
	jne wpisanieDanych
	emms
	ret

Szyfruj endp
;------------------------------------------------------------------------------------------------------------
; Funkcja deszyfrowania g³ówna
;------------------------------------------------------------------------------------------------------------
Deszyfruj proc data:dword, encrypt:dword
	
	call PrzygotowanieKlucza
	mov ebx, data
	call startParameters
	
dataPermutationLoop1:
	mov	edx, 0								
	mov al, byte ptr[dataStartPermutation1+esi*4]
	div arrayKeySize
	cmp edx,0
	jne continueDataPermutation1						
	mov edx,8
	cmp eax,0
	je continueDataPermutation1						
	dec eax

continueDataPermutation1:						
	mov al, byte ptr[ebx+eax]			
	call loopChangeBitValue
	cmp edi, 8
	jne dataPermutationLoop1
	movd edi, mm3							
	mov byte ptr[leftSide+edi], al		
	call ediSet
	cmp esi, 32
	jne dataPermutationLoop1
	call startParameters
	
dataPermutationLoop2:
	mov	edx, 0								
	mov al, byte ptr[dataStartPermutation2+esi*4]
	div arrayKeySize
	cmp edx,0
	jne continueDataPermutation2						
	mov edx,8
	cmp eax,0
	je continueDataPermutation2					
	dec eax

continueDataPermutation2:						
	mov al, byte ptr[ebx+eax]			
	call loopChangeBitValue
	cmp edi, 8
	jne dataPermutationLoop2
	movd edi, mm3							
	mov byte ptr[rightSide+edi], al		
	call ediSet
	cmp esi, 32
	jne dataPermutationLoop2
	
	call siteration
DaneDoXorLoop1:
	mov al, byte ptr [finalSubKey16+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop1
	call cditeration

	call siteration
DaneDoXorLoop2:
	mov al, byte ptr [finalSubKey15+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop2
	call cditeration

	call siteration
DaneDoXorLoop3:
	mov al, byte ptr [finalSubKey14+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop3
	call cditeration

	call siteration
DaneDoXorLoop4:
	mov al, byte ptr [finalSubKey13+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop4
	call cditeration

	call siteration
DaneDoXorLoop5:
	mov al, byte ptr [finalSubKey12+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop5
	call cditeration

	call siteration
DaneDoXorLoop6:
	mov al, byte ptr [finalSubKey11+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop6
	call cditeration

	call siteration
DaneDoXorLoop7:
	mov al, byte ptr [finalSubKey10+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop7
	call cditeration

	call siteration
DaneDoXorLoop8:
	mov al, byte ptr [finalSubKey9+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop8
	call cditeration

	call siteration
DaneDoXorLoop9:
	mov al, byte ptr [finalSubKey8+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop9
	call cditeration

	call siteration
DaneDoXorLoop10:
	mov al, byte ptr [finalSubKey7+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop10
	call cditeration

	call siteration
DaneDoXorLoop11:
	mov al, byte ptr [finalSubKey6+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop11
	call cditeration

	call siteration
DaneDoXorLoop12:
	mov al, byte ptr [finalSubKey5+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop12
	call cditeration

	call siteration
DaneDoXorLoop13:
	mov al, byte ptr [finalSubKey4+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop13
	call cditeration

	call siteration
DaneDoXorLoop14:
	mov al, byte ptr [finalSubKey3+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop14
	call cditeration

	call siteration
DaneDoXorLoop15:
	mov al, byte ptr [finalSubKey2+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop15
	call cditeration

	call siteration
DaneDoXorLoop16:
	mov al, byte ptr [finalSubKey1+edi]
	call subXorFunction
	cmp edi,6
	jne DaneDoXorLoop16
	call cditeration
noweDane1:
	mov ebx, encrypt
	mov cl, byte ptr [rightSide+edi]
	mov byte ptr [newData+edi], cl
	inc edi
	cmp edi,4
	jne noweDane1
noweDane2:
	mov ebx, encrypt
	mov cl, byte ptr [leftSide+edi-4]
	mov byte ptr [newData+edi], cl
	inc edi
	cmp edi,8
	jne noweDane2
	call startParameters

finalP1:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalDataPermutation1+esi] ; pobranie wartoœci który bajt
	div arrayKeySize			
	cmp edx,0
	jne continueFinalP1
	mov edx,8
	cmp eax,0
	je continueFinalP1
	dec eax

continueFinalP1:			
	mov al, byte ptr[newData+eax]				
	call loopChangeBitValue
	cmp edi, 8
	jne finalP1

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalData+edi], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne finalP1

	call startParameters

finalP2:
	mov	edx, 0								; przypisanie 0, w miejsce gdzie bedzie zapisana wartoœæ reszty z dzielenia						
	mov al, byte ptr[finalDataPermutation2+esi] ; pobranie wartoœci który bajt
	div arrayKeySize
	cmp edx,0
	jne continueFinalP2
	mov edx,8
	cmp eax,0
	je continueFinalP2
	dec eax

continueFinalP2:
	mov al, byte ptr[newData+eax]				; pobranie bajtu klucza z danej pozycji
	call loopChangeBitValue
	cmp edi, 8
	jne finalP2

	movd edi, mm3							; edi = mm3
	mov byte ptr[finalData+edi+4], al			; zapisanie do tablicy newKey wartoœci z eax
	call ediSet
	cmp esi, 32
	jne finalP2
	call startParameters

wpisanieDanych:
	mov ebx, encrypt
	mov cl, byte ptr [finalData+edi]
	mov byte ptr [ebx+edi], cl
	inc edi
	cmp edi,8
	jne wpisanieDanych
	emms
	ret

Deszyfruj endp
end 
