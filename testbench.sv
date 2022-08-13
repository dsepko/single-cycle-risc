module testbench();
	logic clk;
	logic rst;
	logic [2:0] instruction_A;
	logic RegWrite;
	logic MemWrite;
	logic [31:0] probe_register_file;
	logic [31:0] probe_data_memory;
	
	PC dut(.clk(clk),.rst(rst),.instruction_A(instruction_A),.RegWrite(RegWrite),
		.MemWrite(MemWrite),.probe_register_file(probe_register_file), .probe_data_memory(probe_data_memory));
	
	initial
	begin
		rst=0;
		#10;
		rst=1;
	end
	initial
	begin clk=0; forever begin #10; clk=~clk;
	end
	end
	initial
		begin
		RegWrite=0;
		MemWrite=0;
			#10;
			instruction_A=0;
			#100;
			RegWrite=1;
			#100;
			// 1st instruction: load data_reg[5] to rf_reg[1], rs=2, rt=1, imm=3. Result: rf_reg[1]=5
			instruction_A=1;
			#100;
			MemWrite=1;
			RegWrite=0;
			#10;
			// 2nd instruction: store rf_reg[1] to data_reg[9], rs=8, rt=1, imm=1. Result: data_reg[9]=5
			instruction_A=2;
			#10;
			RegWrite=1;
			MemWrite=0;
			#100;
			// 3rd instruction: add rf_reg[3] and rf_reg[4] to rf_reg[1]. Result: rf_reg[1]=3+4=7
			instruction_A=3;
			#100;
			// 4th instruction: sub rf_reg[10] - rf_reg[8] to rf_reg[1]. Result: rf_reg[1]=2
			#100;
			instruction_A=4;
		end
endmodule