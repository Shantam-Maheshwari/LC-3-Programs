		.ORIG x3000

; prompt
START	LEA R0, PROMPT
		PUTS				;print prompt
		GETC				;input character

;ascii -> integer
		ADD R1, R0, #0		;copy R0 to R1
		ADD R1, R1, #-16
		ADD R1, R1, #-16
		ADD R1, R1, #-16 	;R1 has actual value

; check if input is valid 0 <= R1 <= 6
		ADD R1, R1, #0 		;set CCs
		BRn INVALID			;if <0, input is invalid
		ADD R1, R1, #-6 	;R1 <- R1 - 6
		BRp INVALID 		;if >6, input is invalid
		ADD R1, R1, #6 		;restore R1's value

		LEA R0, DAYS 		;R0 <- S of SUNDAY
		ADD R1, R1, #0 		;set CCs

LOOP	BRz DISPLAY
		ADD R0, R0, #10
		ADD R1, R1, #-1
		BR LOOP

DISPLAY PUTS
		BR START

INVALID	HALT

PROMPT	.STRINGZ	"Please enter number: "
DAYS	.STRINGZ 	"Sunday   "
		.STRINGZ 	"Monday   "
		.STRINGZ 	"Tuesday  "
		.STRINGZ 	"Wednesday"
		.STRINGZ 	"Thursday "
		.STRINGZ 	"Friday   "
		.STRINGZ 	"Saturday "

	.END