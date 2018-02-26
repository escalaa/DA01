;
; Task1.asm
;
; Created: 2/25/2018 4:34:41 PM
; Author : Oji
;

; ==============================================================================
; TASK 1
;===============================================================================
; Code Segment that stores 300 numbers fromt STARTADDS = 0x0222
LDI r16,1			; counter starting at number 1
LDI XL, LOW($0222)  ; Load the low byte of X with 0x20
LDI XH, HIGH($0222) ; Load the high byte of X with 0x02
L1:ST X+, r16		; store number into X address (numbers 1 to 255)
inc r16				; increment the number
cpi r16,255			; compare if we cycled through 255 numbers
BRNE L1				; branch to L1 if not equal
L2: ST X+, r16		; store number into X address (numbers 256 to 300)
inc r16				; increment the number
cpi	r16, 45			; compare if we cycled through the last 45 numbers
BRNE L2				; branch to L2 if not equal

; ==============================================================================
; TASK 2
;===============================================================================
; Parse through the number is divisble by 5 store the number to location 0x0400
; else store number to location 0x0600

ldi XL, LOW($0222)		;load low byte of 0x22 to XL
ldi XH, HIGH($0222)		;load high byte of 0x02 to XH
ldi YL, LOW($0400)		;load low byte of 0x00 to YL
ldi YH, HIGH($0400)		;load high byte to 0x04 to YH
ldi ZL, LOW($0600)		;load low byte of 0x00 to ZL
ldi ZH, HIGH($0600)		;load high byte of 0x06 to ZH
ldi r16, 0
loop:
	ldi r21,0
	ld r20, X+			; dividend
	add r21, r20		; store just in case else
Divide:					; loops to divide number by 5
	cpi r20,0			; compare if current number is 0
	breq NotDivisible	
	cpi r20,1			; comapre if current number is 1
	breq NotDivisible		
	cpi r20,2			; compare if current number is 2
	breq NotDivisible
	cpi r20,3			; compare if current number is 3
	breq NotDivisible
	cpi r20,4			; compare if current number is 4
	breq NotDivisible
	cpi r20,5			; compare if current number is 5
	breq Divisible
	subi r20,5			; subtract current number by 5
	jmp Divide			; loop back to Divide
Divisible:
	st Y+, r21			; if divisble by 5 store into Y address
	jmp done1			
NotDivisible:	
	st Z+, r21			; if not divisbly by 5 store into Z address
done1:
	cpi r20,0			; if number hits 256, we take note of it
	breq incrementC
	jmp notZero
incrementC:
	inc r16				; increment checker if number hits 256
notZero:
	cpi r16,2			; checking if number hits 256
	breq done2
	jmp loop
done2: 

; ==============================================================================
; TASK 3
;===============================================================================
; Simultaneously add numbers from memory location Y and Z 
; Store the sums R16:R17 to Y
; Store the sums R18:R19 to Z

ldi YL, LOW($0400)		;load low byte of 0x00 to YL
ldi YH, HIGH($0400)		;load high byte to 0x04 to YH
ldi ZL, LOW($0600)		;load low byte of 0x00 to ZL
ldi ZH, HIGH($0600)		;load high byte of 0x06 to ZH

ldi r21,0
ldi r16,0				;clearing r16
ldi r17,0				;clearing r17
ldi r18,0				;clearing r18
ldi r19,0				;clearing r19
ldi r23,0
Sum:
	ld r20, Y+			;load number in Y address to r20
	ld r22, Z+			;load number in Z address to r22
	cpi r20, 0			; compare if Y is 0
	brne notDone
	cpi r22,0			;compare if Z is 0
	brne notDone		
	inc r23				; if both is 0 increment time met once
	cpi r23,2			; if both is 0 twice means we jump to Done
	breq Done			
notDone:
	add r16, r20		; add low bit Y
	adc r17, r21		; add high bit Y
	add r18, r22		; add low bit Z
	adc r19, r21		; add high bit Z
	jmp Sum				; loop back to sum again
Done: jmp Done
