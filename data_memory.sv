module data_memory(
	input logic clk,
	input logic rst,
	input logic [31:0] A, // address
	input logic [31:0] WD, // input data
	input logic WE, // enable input
	output logic [31:0] RD,
	output logic [31:0] probe_dm
	);
	reg [31:0] mem[31:0];
	always@(posedge clk or negedge rst)
		begin
			if(!rst)
			begin
				for(int i=0; i<32; i++)
				begin
					mem[i] <= i;
				end
			end
			else
				begin
					if(WE)
						mem[A] <= WD;
				end
		end
		assign RD = mem[A];
		assign probe_dm = mem[A];
endmodule