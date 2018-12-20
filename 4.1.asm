		.ORIG x3000

;prompt
		LEA R0, PROMPT 			;
		PUTS 					;print prompt
		GETC					;input number

;ascii to integer
		ADD R0, R0, #-16
		ADD R0, R0, #-16
		ADD R0, R0, #-16		;R0 has the actual value

		STI R0, n 				;M[x3100] <- n

;initialize a and b
		AND R1, R1, #0 			;clear R0
		ADD R1, R1, #1 			;R1 <- a
		
		AND R2, R2, #0 			;clear R1
		ADD R2, R2, #1 			;R2 <- b

		AND R3, R3, #0 			;R3 <- F

;check if n < 2
		ADD R0, R0, #-2 		;R0 <- n-2
		BRnz Fn_FOUND 			;if n <= 2, skip loop

;if n > 2 (R0 = n-2 currently)
LOOP1	ADD R3, R2, R1	 		;F <- b + a
		ADD R1, R2, #0 			;a <- b
		ADD R2, R3, #0 			;b <- F
		ADD R0, R0, #-1 		;R0--
		BRz Fn_FOUND			;if R0 == 0, we've got Fn
		BR LOOP1				;otherwise, repeat

Fn_FOUND
		STI R2, Fn 				;M[x3101] <- R2 = Fn

;finding N and FN
		LDI R0, n 				;R0 <- n
		LDI R2, Fn 				;R3 <- Fn

LOOP2	ADD R3, R2, R1 			;F <- b + a
		BRn FN_FOUND 			;if F < 0, we've got FN
		ADD R1, R2, #0 			;a <- b
		ADD R2, R3, #0 			;b <- F
		ADD R0, R0, #1 			;RO++
		BR LOOP2

FN_FOUND
		STI R0, N 				;M[X3102] <- N
		STI R2, FN 				;M[X3103] <- FN 

		HALT

PROMPT 	.STRINGZ 	"Enter n: "
n		.FILL		x3100
Fn 		.FILL 		x3101
N 		.FILL 		x3102
FN 		.FILL 		x3103

		.END