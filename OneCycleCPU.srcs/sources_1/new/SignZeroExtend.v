`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/31 17:02:15
// Design Name: 
// Module Name: SignZeroExtend
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module SignZeroExtend(
	 ExtSel,
	 inputNum,
	 outputNum
);

	input ExtSel;
	input wire[15:0] inputNum;
	output reg[31:0] outputNum;

	initial begin
		outputNum = 0;
	end

	always @ (ExtSel or  inputNum)begin 
		if(ExtSel)begin
			outputNum = {{16{inputNum[15]}}, inputNum[15:0]};
		end
		else begin
		  outputNum = {{16{1'b0}},inputNum[15:0]};
		end
	end

endmodule
