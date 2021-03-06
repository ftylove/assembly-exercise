TITLE seagullbird_t25
.MODEL SMALL
.DATA
	MEM DB 4 DUP (?), 0DH, '$'
	OUTPUT_INFO DB 'THE NUMBER IN AX IS 2A49H, AND THE OUTPUT IS: $'
.CODE
MAIN PROC FAR
	ASSUME CS:_TEXT, DS:_DATA
	PUSH DS
	XOR AX, AX
	PUSH AX
	MOV AX, @DATA
	MOV DS, AX

	MOV AX, 2A49H
	LEA BX, MEM
	MOV CL, 4
	MOV SI, 4
	
	FOR:
		CMP SI, 0
		JZ OUTPUT
		MOV DX, AX
		AND DX, 000FH
		CMP DX, 9
		JG LETTER
		ADD DX, 30H
		JMP NEXT
		NEXT:
			MOV [BX], DX
			INC BX
			DEC SI
			ROR AX, CL
			JMP FOR

	LETTER:
		ADD DX, 37H
		JMP NEXT

	OUTPUT:
		MOV AH, 9
		LEA DX, OUTPUT_INFO
		INT 21H
		LEA DX, MEM
		INT 21H

	RET
MAIN ENDP
	END MAIN