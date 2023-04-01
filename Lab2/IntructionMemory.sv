module InstructionMemory (
    //ports definition
    input logic [7:0] InstrAddr,
    output logic [15:0] ReadInstr
);

    //Signals
	always_comb begin
		case(InstrAddr)
			//OPERACIONES X
			0: ReadInstr = 16'hA100;//MOV R0, #0
			1: ReadInstr = 16'hC9FF;//LDR R1,[R0,#255]
			2: ReadInstr = 16'hE9FD;//STR R1,[R0,#253]
			3: ReadInstr = 16'hD1FE;//LDR R2,[R0,#254]
			4: ReadInstr = 16'hB080;//MOV R2,R2   Verificacion boton apretado
			5: ReadInstr = 16'h1A40;//ADD R3,R1,R1
			6: ReadInstr = 16'hF900;//STR R3,[R0,#0]
			//RESULTADO 2*X
			//OPERACIONES Y
			7: ReadInstr = 16'hD1FE;//LDR R2,[R0,#254]
			8: ReadInstr = 16'hB080;//MOV R2,R2          Verificacion boton soltado
			9: ReadInstr = 16'hC9FF;//LDR R1[R0,#255]
			10: ReadInstr = 16'hE9FD;//STR R1,[R0,#253]
			11: ReadInstr = 16'hD1FE;//LDR R2,[R0,#254]
			12: ReadInstr = 16'hB080;//MOV R2,R2         Verificacion boton apretado
			13: ReadInstr = 16'hB106;//MOV R2,#6
			14: ReadInstr = 16'h0040;//ADD R0,R0,R1 
			15: ReadInstr = 16'h3501;//SUB R2,R2,#1     Verificacion ciclo multiplicacion
			16: ReadInstr = 16'hE501;//STR R0,[R2,#1]
			//RESULTADO 6*Y
			//OPERACIONES Z		
			17: ReadInstr = 16'hA100;//MOV R0,0
			18: ReadInstr = 16'hD1FE;//LDR R2,[R0,#254]
			19: ReadInstr = 16'hB080;//MOV R2,R2          Verificacion boton soltado
			20: ReadInstr = 16'hC9FF;//LDR R1[R0,#255]
			21: ReadInstr = 16'hE9FD;//STR R1,[R0,#253]
			22: ReadInstr = 16'hD1FE;//LDR R2,[R0,#254]
			23: ReadInstr = 16'hB080;//MOV R2,R2         Verificacion boton apretado
			24: ReadInstr = 16'hB105;//MOV R2,#5
			25: ReadInstr = 16'h0040;//ADD R0,R0,R1 
			26: ReadInstr = 16'h3501;//SUB R2,R2,#1     Verificacion ciclo multiplicacion
			//27: ReadInstr = 16'hE5FD;//STR R0,[R2,#2]
			//RESULTADO 5*Z
			27: ReadInstr = 16'hCD01;//LDR R1[R2,#1]
			28: ReadInstr = 16'h3A00;//SUB R3,R1,R0    V=6Y-5Z
			29: ReadInstr = 16'hCD00;//LDR R1[R2,#0] Cargar 2X
			30: ReadInstr = 16'h02C0;//ADD R0,R1,R3   2X+V
			31: ReadInstr = 16'hE5FD;//STR R0,[R2,#253]  Display
			default: ReadInstr = 0;
		endcase
	
	end
endmodule

//			17: ReadInstr = 16'hD5FE;//LDR R2,[R2,#254]
//			18: ReadInstr = 16'hB080;//MOV R2,R2      Verificacion boton soltado
//			19: ReadInstr = 16'hA100;//MOV R0,0
//			20: ReadInstr = 16'hC9FF;//LDR R1,[R0,#255]
//			21: ReadInstr = 16'hE9FD;//STR R1,[R0,#253]
//			22: ReadInstr = 16'hD1FE;//LDR R2[R0,#254]
//			23: ReadInstr = 16'hB080;//MOV R2,R2 Verificacion boton presionado
//			24: ReadInstr = 16'hB105;//MOV R2,#5
//			25: ReadInstr = 16'h0040;//ADD R0,R0,R1
//			26: ReadInstr = 16'h3501;//SUB R2,R2,1 Verificacion ciclo multiplicacion
//			27: ReadInstr = 16'hE5FD;