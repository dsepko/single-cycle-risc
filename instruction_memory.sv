module instruction_memory(
	input logic clk,
	input logic rst,
	input logic [2:0] A, // address
	output logic [31:0] RD // output data, instruction
);
	reg[31:0] instr_reg[4:0];
	always@(posedge clk or negedge rst)
		begin
			if(!rst)
			begin
			//I-type instruction = op[31:26]+rs[25:21]+rt[20:16]+imm[15:0]
			//R-type instruction = op[31:26]+rs[25:21]+rt[20:16]+rd[15:11]+rest[10:0]
				instr_reg[0] <= 0;
				
				// 1st instruction: load data_reg[5] to rf_reg[1], rs=2, rt=1, imm=3. Result: rf_reg[1]=5
				instr_reg[1] <= 32'b010101_00010_00001_0000_0000_0000_0011;
				
				// 2nd instruction: store rf_reg[1] to data_reg[9], rs=8, rt=1, imm=1. Result: data_reg[9]=5
				instr_reg[2] <= 32'b010100_01000_00001_0000000000000001;
				
				// 3rd instruction: add rf_reg[3] and rf_reg[4] to rf_reg[1]. Result: rf_reg[1]=3+4=7
				instr_reg[3] <= 32'b100100_00011_00100_00001_00000_000000;
				
				// 4th instruction: sub rf_reg[10] - rf_reg[8] to rf_reg[1]. Result: rf_reg[1]=2
				instr_reg[4] <= 32'b101100_01010_01000_00001_00000_000000;
			end
			else
				begin
					RD <= instr_reg[A];
				end
		end
endmodule