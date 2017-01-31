		.DATA
cursorImage 		.FILL #0
		.FILL #0
		.FILL #24
		.FILL #60
		.FILL #60
		.FILL #24
		.FILL #0
		.FILL #0
		.DATA
launcherImage 		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #24
		.FILL #60
		.FILL #60
		.FILL #36
		.DATA
destroyedCityImage 		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #60
		.FILL #60
		.FILL #60
		.FILL #60
;;;;;;;;;;;;;;;;;;;;;;;;;;;;printnum;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
printnum
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-13	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRnp L6_mc
	LEA R7, L8_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L5_mc
L6_mc
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L10_mc
	LDR R7, R5, #3
	NOT R7,R7
	ADD R7,R7,#1
	STR R7, R5, #-13
	JMP L11_mc
L10_mc
	LDR R7, R5, #3
	STR R7, R5, #-13
L11_mc
	LDR R7, R5, #-13
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRzp L12_mc
	LEA R7, L14_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L5_mc
L12_mc
	ADD R7, R5, #-12
	ADD R7, R7, #10
	STR R7, R5, #-2
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #0
	STR R3, R7, #0
	JMP L16_mc
L15_mc
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	LDR R3, R5, #-1
	CONST R2, #10
	MOD R3, R3, R2
	CONST R2, #48
	ADD R3, R3, R2
	STR R3, R7, #0
	LDR R7, R5, #-1
	CONST R3, #10
	DIV R7, R7, R3
	STR R7, R5, #-1
L16_mc
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnp L15_mc
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L18_mc
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #45
	STR R3, R7, #0
L18_mc
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L5_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;endl;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
endl
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, L21_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L20_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;abs;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
abs
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L23_mc
	LDR R7, R5, #3
	NOT R7,R7
	ADD R7,R7,#1
	JMP L22_mc
L23_mc
	LDR R7, R5, #3
L22_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;rand16;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
rand16
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #127
	AND R7, R7, R3
L25_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
numMissiles 		.FILL #8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawCursor;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawCursor
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, cursorImage
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, cursor
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L26_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawMissileLauncher;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawMissileLauncher
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-3	;; allocate stack space for local variables
	;; function body
	LEA R7, missileLauncher
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L28_mc
	CONST R7, #0
	STR R7, R5, #-2
	STR R7, R5, #-3
	STR R7, R5, #-1
	JMP L33_mc
L30_mc
	LDR R7, R5, #-1
	CONST R3, #2
	MOD R7, R7, R3
	CONST R3, #0
	CMP R7, R3
	BRnp L34_mc
	LEA R7, missileLauncher
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	CONST R3, #116
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #55
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-2
	ADD R7, R7, #-5
	STR R7, R5, #-2
	JMP L35_mc
L34_mc
	LEA R7, missileLauncher
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-3
	CONST R3, #116
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #65
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	LDR R7, R5, #-3
	ADD R7, R7, #-5
	STR R7, R5, #-3
L35_mc
L31_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
L33_mc
	LDR R7, R5, #-1
	LEA R3, missileLauncher
	LDR R3, R3, #1
	CMP R7, R3
	BRn L30_mc
L28_mc
L27_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawCities;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawCities
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, cities
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L37_mc
	LEA R7, cities
	ADD R7, R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	HICONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #116
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #20
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L38_mc
L37_mc
	LEA R7, destroyedCityImage
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	HICONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #116
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #20
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L38_mc
	LEA R7, cities
	LDR R7, R7, #10
	CONST R3, #0
	CMP R7, R3
	BRnp L39_mc
	LEA R7, cities
	ADD R7, R7, #12
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	HICONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #116
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #100
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L40_mc
L39_mc
	LEA R7, destroyedCityImage
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	HICONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #116
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #100
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L40_mc
L36_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;endpoint;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
endpoint
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	MOD R7, R7, R3
	CONST R3, #0
	CMP R7, R3
	BRnp L42_mc
	LEA R7, cities
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L44_mc
	LDR R7, R5, #3
	CONST R3, #20
	STR R3, R7, #5
	JMP L43_mc
L44_mc
	LEA R7, cities
	LDR R7, R7, #10
	CONST R3, #0
	CMP R7, R3
	BRnp L46_mc
	LDR R7, R5, #3
	CONST R3, #100
	STR R3, R7, #5
	JMP L43_mc
L46_mc
	LDR R7, R5, #3
	CONST R3, #60
	STR R3, R7, #5
	JMP L43_mc
L42_mc
	LDR R7, R5, #-1
	CONST R3, #3
	MOD R7, R7, R3
	CONST R3, #1
	CMP R7, R3
	BRnp L48_mc
	LEA R7, cities
	LDR R7, R7, #10
	CONST R3, #0
	CMP R7, R3
	BRnp L50_mc
	LDR R7, R5, #3
	CONST R3, #100
	STR R3, R7, #5
	JMP L49_mc
L50_mc
	LEA R7, cities
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L52_mc
	LDR R7, R5, #3
	CONST R3, #20
	STR R3, R7, #5
	JMP L49_mc
L52_mc
	LDR R7, R5, #3
	CONST R3, #60
	STR R3, R7, #5
	JMP L49_mc
L48_mc
	LDR R7, R5, #-1
	CONST R3, #3
	MOD R7, R7, R3
	CONST R3, #2
	CMP R7, R3
	BRnp L54_mc
	LEA R7, missileLauncher
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L56_mc
	LDR R7, R5, #3
	CONST R3, #60
	STR R3, R7, #5
	JMP L57_mc
L56_mc
	LEA R7, cities
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L58_mc
	LDR R7, R5, #3
	CONST R3, #20
	STR R3, R7, #5
	JMP L59_mc
L58_mc
	LEA R7, cities
	LDR R7, R7, #10
	CONST R3, #0
	CMP R7, R3
	BRnp L60_mc
	LDR R7, R5, #3
	CONST R3, #100
	STR R3, R7, #5
	JMP L61_mc
L60_mc
	LDR R7, R5, #3
	CONST R3, #60
	STR R3, R7, #5
L61_mc
L59_mc
L57_mc
L54_mc
L49_mc
L43_mc
L41_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawIncoming;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawIncoming
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-3	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
L63_mc
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L67_mc
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-2
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR endpoint
	ADD R6, R6, #1	;; free space for arguments
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R3, R7, #2
	ADD R2, R3, #0
	ADD R6, R6, #-1
	STR R2, R6, #0
	LDR R7, R7, #1
	ADD R2, R7, #0
	ADD R6, R6, #-1
	STR R2, R6, #0
	ADD R6, R6, #-1
	STR R3, R6, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_line
	ADD R6, R6, #5	;; free space for arguments
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #0
	JMP L68_mc
L67_mc
	CONST R7, #240
	HICONST R7, #127
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R3, R7, #4
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #3
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_line
	ADD R6, R6, #5	;; free space for arguments
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	STR R7, R5, #-3
	LDR R3, R7, #3
	LDR R2, R7, #5
	CMP R3, R2
	BRnp L69_mc
	LDR R7, R5, #-3
	LDR R7, R7, #4
	LDR R3, R5, #-3
	LDR R3, R3, #6
	CMP R7, R3
	BRnp L69_mc
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #5
	CONST R3, #20
	CMP R7, R3
	BRnp L71_mc
	LEA R7, cities
	CONST R3, #1
	STR R3, R7, #0
	JMP L72_mc
L71_mc
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #5
	CONST R3, #100
	CMP R7, R3
	BRnp L73_mc
	LEA R7, cities
	CONST R3, #1
	STR R3, R7, #10
	JMP L74_mc
L73_mc
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #5
	CONST R3, #60
	CMP R7, R3
	BRnp L75_mc
	LEA R7, missileLauncher
	CONST R3, #1
	STR R3, R7, #0
L75_mc
L74_mc
L72_mc
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #7
L69_mc
L68_mc
L64_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L63_mc
L62_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;DrawOutgoing;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
DrawOutgoing
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-5	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-2
L78_mc
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L82_mc
	LEA R7, missileLauncher
	LDR R7, R7, #1
	CONST R3, #0
	CMP R7, R3
	BRn L82_mc
	CONST R7, #0
	HICONST R7, #51
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R3, R7, #4
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #3
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_line
	ADD R6, R6, #5	;; free space for arguments
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	STR R7, R5, #-5
	LDR R3, R7, #3
	LDR R2, R7, #5
	CMP R3, R2
	BRnp L84_mc
	LDR R7, R5, #-5
	LDR R7, R7, #4
	LDR R3, R5, #-5
	LDR R3, R3, #6
	CMP R7, R3
	BRnp L84_mc
	CONST R7, #0
	STR R7, R5, #-1
L86_mc
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R3, R5, #-1
	SLL R3, R3, #3
	LEA R2, incoming
	ADD R3, R3, R2
	LDR R2, R7, #3
	LDR R1, R3, #3
	SUB R2, R2, R1
	MUL R2, R2, R2
	STR R2, R5, #-3
	LDR R7, R7, #4
	LDR R3, R3, #4
	SUB R7, R7, R3
	MUL R7, R7, R7
	STR R7, R5, #-4
	LDR R7, R5, #-3
	LDR R3, R5, #-4
	ADD R7, R7, R3
	CONST R3, #250
	CMP R7, R3
	BRp L90_mc
	LEA R7, numMissiles
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #7
L90_mc
L87_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L86_mc
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #7
L84_mc
L82_mc
L79_mc
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #1
	CMP R7, R3
	BRn L78_mc
L77_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;processNextIncomingPosition;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
processNextIncomingPosition
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-13	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	LDR R3, R7, #1
	STR R3, R5, #-4
	LDR R3, R7, #2
	STR R3, R5, #-9
	LDR R3, R7, #5
	STR R3, R5, #-3
	LDR R7, R7, #6
	STR R7, R5, #-11
	LDR R7, R5, #-11
	LDR R3, R5, #-9
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-13
	LDR R3, R5, #-3
	LDR R2, R5, #-4
	SUB R3, R3, R2
	ADD R6, R6, #-1
	STR R3, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	LDR R3, R5, #-13
	CMP R3, R7
	BRnz L93_mc
	CONST R7, #1
	STR R7, R5, #-10
	JMP L94_mc
L93_mc
	CONST R7, #0
	STR R7, R5, #-10
L94_mc
	LDR R7, R5, #-10
	CONST R3, #1
	CMP R7, R3
	BRnp L95_mc
	LDR R7, R5, #-9
	LDR R3, R5, #-4
	SUB R3, R3, R7
	STR R3, R5, #-4
	LDR R3, R5, #-4
	ADD R7, R3, R7
	STR R7, R5, #-9
	LDR R7, R5, #-9
	SUB R7, R7, R3
	STR R7, R5, #-4
	LDR R7, R5, #-11
	LDR R3, R5, #-3
	SUB R3, R3, R7
	STR R3, R5, #-3
	LDR R3, R5, #-3
	ADD R7, R3, R7
	STR R7, R5, #-11
	LDR R7, R5, #-11
	SUB R7, R7, R3
	STR R7, R5, #-3
L95_mc
	LDR R7, R5, #-4
	LDR R3, R5, #-3
	CMP R7, R3
	BRnz L97_mc
	LDR R7, R5, #-3
	LDR R3, R5, #-4
	SUB R3, R3, R7
	STR R3, R5, #-4
	LDR R3, R5, #-4
	ADD R7, R3, R7
	STR R7, R5, #-3
	LDR R7, R5, #-3
	SUB R7, R7, R3
	STR R7, R5, #-4
	LDR R7, R5, #-11
	LDR R3, R5, #-9
	SUB R3, R3, R7
	STR R3, R5, #-9
	LDR R3, R5, #-9
	ADD R7, R3, R7
	STR R7, R5, #-11
	LDR R7, R5, #-11
	SUB R7, R7, R3
	STR R7, R5, #-9
L97_mc
	LDR R7, R5, #-3
	LDR R3, R5, #-4
	SUB R7, R7, R3
	STR R7, R5, #-5
	LDR R7, R5, #-11
	LDR R3, R5, #-9
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-8
	CONST R7, #0
	STR R7, R5, #-1
	LDR R7, R5, #-9
	STR R7, R5, #-6
	LDR R3, R5, #-11
	CMP R7, R3
	BRzp L99_mc
	CONST R7, #1
	STR R7, R5, #-12
	JMP L100_mc
L99_mc
	CONST R7, #-1
	STR R7, R5, #-12
L100_mc
	CONST R7, #0
	STR R7, R5, #-7
	LDR R7, R5, #-4
	STR R7, R5, #-2
	JMP L104_mc
L101_mc
	LDR R7, R5, #-4
	LDR R3, R5, #3
	LDR R3, R3, #7
	ADD R7, R7, R3
	LDR R3, R5, #-3
	CMP R7, R3
	BRnz L105_mc
	LDR R7, R5, #3
	LDR R3, R7, #5
	STR R3, R7, #3
	LDR R7, R5, #3
	LDR R3, R7, #6
	STR R3, R7, #4
	JMP L103_mc
L105_mc
	LDR R7, R5, #-7
	CONST R3, #0
	CMP R7, R3
	BRnp L107_mc
	LDR R7, R5, #-10
	CONST R3, #1
	CMP R7, R3
	BRnp L109_mc
	LDR R7, R5, #-2
	LDR R3, R5, #-4
	LDR R2, R5, #3
	LDR R2, R2, #7
	ADD R3, R3, R2
	CMP R7, R3
	BRnp L109_mc
	LDR R7, R5, #3
	LDR R3, R5, #-6
	STR R3, R7, #3
	LDR R7, R5, #3
	LDR R3, R5, #-2
	STR R3, R7, #4
	LDR R7, R5, #3
	ADD R7, R7, #7
	LDR R3, R7, #0
	ADD R3, R3, #2
	STR R3, R7, #0
	CONST R7, #1
	STR R7, R5, #-7
	JMP L110_mc
L109_mc
	LDR R7, R5, #-10
	CONST R3, #0
	CMP R7, R3
	BRnp L111_mc
	LDR R7, R5, #-2
	LDR R3, R5, #-4
	LDR R2, R5, #3
	LDR R2, R2, #7
	ADD R3, R3, R2
	CMP R7, R3
	BRnp L111_mc
	LDR R7, R5, #3
	LDR R3, R5, #-2
	STR R3, R7, #3
	LDR R7, R5, #3
	LDR R3, R5, #-6
	STR R3, R7, #4
	LDR R7, R5, #3
	ADD R7, R7, #7
	LDR R3, R7, #0
	ADD R3, R3, #2
	STR R3, R7, #0
	CONST R7, #1
	STR R7, R5, #-7
L111_mc
L110_mc
L107_mc
	LDR R7, R5, #-1
	LDR R3, R5, #-8
	ADD R7, R7, R3
	STR R7, R5, #-1
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LDR R3, R5, #-5
	CMP R7, R3
	BRn L113_mc
	LDR R7, R5, #-6
	LDR R3, R5, #-12
	ADD R7, R7, R3
	STR R7, R5, #-6
	LDR R7, R5, #-1
	LDR R3, R5, #-5
	SUB R7, R7, R3
	STR R7, R5, #-1
L113_mc
L102_mc
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
L104_mc
	LDR R7, R5, #-2
	LDR R3, R5, #-3
	CMP R7, R3
	BRnz L101_mc
L103_mc
L92_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;processNextOutgoingPosition;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
processNextOutgoingPosition
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-15	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-13
	LDR R7, R5, #3
	LDR R3, R7, #1
	STR R3, R5, #-4
	LDR R3, R7, #2
	STR R3, R5, #-10
	LDR R3, R7, #5
	STR R3, R5, #-2
	LDR R7, R7, #6
	STR R7, R5, #-11
	LDR R7, R5, #-11
	LDR R3, R5, #-10
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-14
	LDR R3, R5, #-2
	LDR R2, R5, #-4
	SUB R3, R3, R2
	ADD R6, R6, #-1
	STR R3, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	LDR R3, R5, #-14
	CMP R3, R7
	BRnz L116_mc
	CONST R7, #1
	STR R7, R5, #-9
	JMP L117_mc
L116_mc
	CONST R7, #0
	STR R7, R5, #-9
L117_mc
	LDR R7, R5, #-9
	CONST R3, #1
	CMP R7, R3
	BRnp L118_mc
	LDR R7, R5, #-10
	LDR R3, R5, #-4
	SUB R3, R3, R7
	STR R3, R5, #-4
	LDR R3, R5, #-4
	ADD R7, R3, R7
	STR R7, R5, #-10
	LDR R7, R5, #-10
	SUB R7, R7, R3
	STR R7, R5, #-4
	LDR R7, R5, #-11
	LDR R3, R5, #-2
	SUB R3, R3, R7
	STR R3, R5, #-2
	LDR R3, R5, #-2
	ADD R7, R3, R7
	STR R7, R5, #-11
	LDR R7, R5, #-11
	SUB R7, R7, R3
	STR R7, R5, #-2
L118_mc
	LDR R7, R5, #-4
	LDR R3, R5, #-2
	CMP R7, R3
	BRnz L120_mc
	CONST R7, #1
	STR R7, R5, #-13
	LDR R7, R5, #-2
	LDR R3, R5, #-4
	SUB R3, R3, R7
	STR R3, R5, #-4
	LDR R3, R5, #-4
	ADD R7, R3, R7
	STR R7, R5, #-2
	LDR R7, R5, #-2
	SUB R7, R7, R3
	STR R7, R5, #-4
	LDR R7, R5, #-11
	LDR R3, R5, #-10
	SUB R3, R3, R7
	STR R3, R5, #-10
	LDR R3, R5, #-10
	ADD R7, R3, R7
	STR R7, R5, #-11
	LDR R7, R5, #-11
	SUB R7, R7, R3
	STR R7, R5, #-10
L120_mc
	LDR R7, R5, #-2
	LDR R3, R5, #-4
	SUB R7, R7, R3
	STR R7, R5, #-5
	LDR R7, R5, #-11
	LDR R3, R5, #-10
	SUB R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR abs
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-8
	CONST R7, #0
	STR R7, R5, #-1
	LDR R7, R5, #-10
	STR R7, R5, #-6
	LDR R3, R5, #-11
	CMP R7, R3
	BRzp L122_mc
	CONST R7, #1
	STR R7, R5, #-12
	JMP L123_mc
L122_mc
	CONST R7, #-1
	STR R7, R5, #-12
L123_mc
	CONST R7, #0
	STR R7, R5, #-7
	LDR R7, R5, #-4
	STR R7, R5, #-3
	JMP L127_mc
L124_mc
	LDR R7, R5, #-2
	LDR R3, R5, #3
	LDR R3, R3, #7
	SUB R7, R7, R3
	LDR R3, R5, #-4
	CMP R7, R3
	BRzp L128_mc
	LDR R7, R5, #3
	LDR R3, R7, #5
	STR R3, R7, #3
	LDR R7, R5, #3
	LDR R3, R7, #6
	STR R3, R7, #4
	JMP L126_mc
L128_mc
	LDR R7, R5, #-7
	CONST R3, #0
	CMP R7, R3
	BRnp L130_mc
	LDR R7, R5, #-9
	CONST R3, #1
	CMP R7, R3
	BRnp L132_mc
	LDR R7, R5, #-3
	LDR R3, R5, #-2
	LDR R2, R5, #3
	LDR R2, R2, #7
	SUB R3, R3, R2
	CMP R7, R3
	BRnp L132_mc
	LDR R7, R5, #3
	LDR R3, R5, #-6
	STR R3, R7, #3
	LDR R7, R5, #3
	LDR R3, R5, #-3
	STR R3, R7, #4
	LDR R7, R5, #3
	ADD R7, R7, #7
	LDR R3, R7, #0
	ADD R3, R3, #4
	STR R3, R7, #0
	CONST R7, #1
	STR R7, R5, #-7
	JMP L133_mc
L132_mc
	LDR R7, R5, #-9
	CONST R3, #0
	CMP R7, R3
	BRnp L134_mc
	LDR R7, R5, #-3
	LDR R3, R5, #-2
	LDR R2, R5, #3
	LDR R2, R2, #7
	SUB R3, R3, R2
	CMP R7, R3
	BRnp L134_mc
	LDR R7, R5, #-13
	CONST R3, #1
	CMP R7, R3
	BRnp L134_mc
	LDR R7, R5, #3
	LDR R3, R5, #-3
	STR R3, R7, #3
	LDR R7, R5, #3
	LDR R3, R5, #-6
	STR R3, R7, #4
	LDR R7, R5, #3
	ADD R7, R7, #7
	LDR R3, R7, #0
	ADD R3, R3, #4
	STR R3, R7, #0
	CONST R7, #1
	STR R7, R5, #-7
	JMP L135_mc
L134_mc
	CONST R7, #0
	STR R7, R5, #-15
	LDR R3, R5, #-9
	CMP R3, R7
	BRnp L136_mc
	LDR R7, R5, #-3
	LDR R3, R5, #-4
	LDR R2, R5, #3
	LDR R2, R2, #7
	ADD R3, R3, R2
	CMP R7, R3
	BRnp L136_mc
	LDR R7, R5, #-13
	LDR R3, R5, #-15
	CMP R7, R3
	BRnp L136_mc
	LDR R7, R5, #3
	LDR R3, R5, #-3
	STR R3, R7, #3
	LDR R7, R5, #3
	LDR R3, R5, #-6
	STR R3, R7, #4
	LDR R7, R5, #3
	ADD R7, R7, #7
	LDR R3, R7, #0
	ADD R3, R3, #3
	STR R3, R7, #0
	CONST R7, #1
	STR R7, R5, #-7
L136_mc
L135_mc
L133_mc
L130_mc
	LDR R7, R5, #-1
	LDR R3, R5, #-8
	ADD R7, R7, R3
	STR R7, R5, #-1
	LDR R7, R5, #-1
	SLL R7, R7, #1
	LDR R3, R5, #-5
	CMP R7, R3
	BRn L138_mc
	LDR R7, R5, #-6
	LDR R3, R5, #-12
	ADD R7, R7, R3
	STR R7, R5, #-6
	LDR R7, R5, #-1
	LDR R3, R5, #-5
	SUB R7, R7, R3
	STR R7, R5, #-1
L138_mc
L125_mc
	LDR R7, R5, #-3
	ADD R7, R7, #1
	STR R7, R5, #-3
L127_mc
	LDR R7, R5, #-3
	LDR R3, R5, #-2
	CMP R7, R3
	BRnz L124_mc
L126_mc
L115_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;Redraw;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
Redraw
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR lc4_reset_vmem
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawCursor
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawMissileLauncher
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawCities
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawOutgoing
	ADD R6, R6, #0	;; free space for arguments
	JSR DrawIncoming
	ADD R6, R6, #0	;; free space for arguments
	JSR lc4_blt_vmem
	ADD R6, R6, #0	;; free space for arguments
L140_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;reset;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
reset
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR lc4_reset_vmem
	ADD R6, R6, #0	;; free space for arguments
	JSR lc4_blt_vmem
	ADD R6, R6, #0	;; free space for arguments
L141_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;ResetGame;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
ResetGame
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-3	;; allocate stack space for local variables
	;; function body
	LEA R7, numMissiles
	CONST R3, #8
	STR R3, R7, #0
	LEA R7, cursor
	CONST R3, #40
	STR R3, R7, #0
	CONST R3, #60
	STR R3, R7, #1
	JSR DrawCursor
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, missileLauncher
	CONST R3, #8
	STR R3, R7, #1
	LEA R7, missileLauncher
	CONST R3, #0
	STR R3, R7, #0
	CONST R3, #24
	STR R3, R7, #3
	LEA R7, missileLauncher
	CONST R3, #24
	STR R3, R7, #4
	LEA R7, missileLauncher
	CONST R3, #24
	STR R3, R7, #5
	LEA R7, missileLauncher
	CONST R3, #24
	STR R3, R7, #6
	LEA R7, missileLauncher
	CONST R3, #24
	STR R3, R7, #7
	LEA R7, missileLauncher
	CONST R3, #60
	STR R3, R7, #8
	LEA R7, missileLauncher
	CONST R3, #60
	STR R3, R7, #9
	LEA R7, missileLauncher
	CONST R3, #36
	STR R3, R7, #10
	JSR DrawMissileLauncher
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, cities
	CONST R3, #0
	STR R3, R7, #0
	CONST R3, #20
	STR R3, R7, #1
	LEA R7, cities
	CONST R3, #8
	STR R3, R7, #2
	LEA R7, cities
	CONST R3, #8
	STR R3, R7, #3
	LEA R7, cities
	CONST R3, #24
	STR R3, R7, #4
	LEA R7, cities
	CONST R3, #24
	STR R3, R7, #5
	LEA R7, cities
	CONST R3, #60
	STR R3, R7, #6
	LEA R7, cities
	CONST R3, #60
	STR R3, R7, #7
	LEA R7, cities
	CONST R3, #126
	STR R3, R7, #8
	LEA R7, cities
	CONST R3, #126
	STR R3, R7, #9
	LEA R7, cities
	CONST R3, #0
	STR R3, R7, #10
	LEA R7, cities
	CONST R3, #100
	STR R3, R7, #11
	LEA R7, cities
	CONST R3, #8
	STR R3, R7, #12
	LEA R7, cities
	CONST R3, #8
	STR R3, R7, #13
	LEA R7, cities
	CONST R3, #24
	STR R3, R7, #14
	LEA R7, cities
	CONST R3, #24
	STR R3, R7, #15
	LEA R7, cities
	CONST R3, #60
	STR R3, R7, #16
	LEA R7, cities
	CONST R3, #60
	STR R3, R7, #17
	LEA R7, cities
	CONST R3, #126
	STR R3, R7, #18
	LEA R7, cities
	CONST R3, #126
	STR R3, R7, #19
	JSR DrawCities
	ADD R6, R6, #0	;; free space for arguments
	CONST R7, #0
	STR R7, R5, #-2
L143_mc
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #60
	STR R3, R7, #1
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #116
	STR R3, R7, #2
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #60
	STR R3, R7, #3
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #116
	STR R3, R7, #4
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	LEA R3, cursor
	LDR R3, R3, #0
	STR R3, R7, #5
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	LEA R3, cursor
	LDR R3, R3, #1
	STR R3, R7, #6
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
L144_mc
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #1
	CMP R7, R3
	BRn L143_mc
	JSR DrawOutgoing
	ADD R6, R6, #0	;; free space for arguments
	CONST R7, #0
	STR R7, R5, #-1
L147_mc
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-3
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R3, R5, #-3
	STR R3, R7, #1
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #2
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R3, R5, #-3
	STR R3, R7, #3
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #4
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #116
	STR R3, R7, #5
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #115
	STR R3, R7, #6
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
L148_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L147_mc
	JSR DrawIncoming
	ADD R6, R6, #0	;; free space for arguments
L142_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;main;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
main
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-4	;; allocate stack space for local variables
	;; function body
	LEA R7, L152_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L153_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L154_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JSR ResetGame
	ADD R6, R6, #0	;; free space for arguments
	JMP L156_mc
L155_mc
	CONST R7, #5
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_getc_timer
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-3
	LDR R7, R5, #-3
	CONST R3, #119
	CMP R7, R3
	BRnp L158_mc
	LEA R7, cursor
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-5
	STR R3, R7, #0
	JMP L159_mc
L158_mc
	LDR R7, R5, #-3
	CONST R3, #97
	CMP R7, R3
	BRnp L160_mc
	LEA R7, cursor
	LDR R3, R7, #0
	ADD R3, R3, #-5
	STR R3, R7, #0
	JMP L161_mc
L160_mc
	LDR R7, R5, #-3
	CONST R3, #115
	CMP R7, R3
	BRnp L162_mc
	LEA R7, cursor
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #5
	STR R3, R7, #0
	JMP L163_mc
L162_mc
	LDR R7, R5, #-3
	CONST R3, #100
	CMP R7, R3
	BRnp L164_mc
	LEA R7, cursor
	LDR R3, R7, #0
	ADD R3, R3, #5
	STR R3, R7, #0
	JMP L165_mc
L164_mc
	LDR R7, R5, #-3
	CONST R3, #114
	CMP R7, R3
	BRnp L166_mc
	LEA R7, outgoing
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L168_mc
	LEA R7, outgoing
	CONST R3, #1
	STR R3, R7, #0
	CONST R3, #60
	STR R3, R7, #3
	LEA R7, outgoing
	CONST R3, #116
	STR R3, R7, #4
	LEA R7, outgoing
	LEA R3, cursor
	LDR R3, R3, #0
	STR R3, R7, #5
	LEA R7, outgoing
	LEA R3, cursor
	LDR R3, R3, #1
	STR R3, R7, #6
	LEA R7, missileLauncher
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
L168_mc
L166_mc
L165_mc
L163_mc
L161_mc
L159_mc
	JSR Redraw
	ADD R6, R6, #0	;; free space for arguments
	CONST R7, #0
	STR R7, R5, #-1
L170_mc
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L174_mc
	LDR R7, R5, #-1
	SLL R7, R7, #3
	LEA R3, incoming
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR processNextIncomingPosition
	ADD R6, R6, #1	;; free space for arguments
L174_mc
L171_mc
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #3
	CMP R7, R3
	BRn L170_mc
	CONST R7, #0
	STR R7, R5, #-2
L176_mc
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L180_mc
	LDR R7, R5, #-2
	SLL R7, R7, #3
	LEA R3, outgoing
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR processNextOutgoingPosition
	ADD R6, R6, #1	;; free space for arguments
L180_mc
L177_mc
	LDR R7, R5, #-2
	ADD R7, R7, #1
	STR R7, R5, #-2
	LDR R7, R5, #-2
	CONST R3, #1
	CMP R7, R3
	BRn L176_mc
	LEA R7, numMissiles
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRp L182_mc
	JSR ResetGame
	ADD R6, R6, #0	;; free space for arguments
L182_mc
	LEA R7, cities
	STR R7, R5, #-4
	CONST R3, #1
	LDR R2, R7, #0
	CMP R2, R3
	BRnp L184_mc
	LDR R7, R5, #-4
	LDR R7, R7, #10
	CMP R7, R3
	BRnp L184_mc
	LEA R7, L186_mc
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JSR Reset
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	JMP L157_mc
L184_mc
L156_mc
	JMP L155_mc
L157_mc
	CONST R7, #0
L151_mc
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
cursor 		.BLKW 2
		.DATA
incoming 		.BLKW 24
		.DATA
outgoing 		.BLKW 8
		.DATA
missileLauncher 		.BLKW 11
		.DATA
cities 		.BLKW 20
		.DATA
targets 		.BLKW 3
		.DATA
L186_mc 		.STRINGZ "Game Over!\n"
		.DATA
L154_mc 		.STRINGZ "Press w, a, s and d to move the cursor.\n"
		.DATA
L153_mc 		.STRINGZ "Press r to shoot a missile.\n"
		.DATA
L152_mc 		.STRINGZ "Welcome to Missile Command!\n"
		.DATA
L21_mc 		.STRINGZ "\n"
		.DATA
L14_mc 		.STRINGZ "-32768"
		.DATA
L8_mc 		.STRINGZ "0"
