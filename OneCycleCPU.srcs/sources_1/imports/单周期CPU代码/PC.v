module PC(
	input clk,
	input reset,
	input [31:0] input_pc,
	output [31:0] output_pc,
	input PCWre
);

	input wire[31:0] input_pc;
	output reg[31:0] output_pc;

	input clk, reset, PCWre;

	always@(posedge clk) begin
		if(reset == 0)begin
			output_pc = 0;
		end
		else if(!PCWre) begin
			output_pc = output_pc;
		end
		else if(PCWre)begin
			output_pc = input_pc;
		end
	end

endmodule