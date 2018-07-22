`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 21:37:09
// Design Name: 
// Module Name: ALU32
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


module ALU32(
	ALUOp,
	rega,
	regb,
	result,
	zero
);
    input [2:0] ALUOp;
	input [31:0] rega;
	input [31:0] regb;
	output reg [31:0] result;
	output zero;
	initial begin
	   result = 0;
	end
	
	assign zero = (result==0)?0:1;   // 0 符号位
	always @( ALUOp or rega or regb ) begin
		case (ALUOp)  //根据操作码来判断执行的操作
			3'b000 : result = rega + regb;  
			3'b001 : result = rega - regb; 
			3'b010 : result = regb << rega;
			3'b011 : result = rega | regb;
			3'b100 : result = rega & regb;
			3'b101 : result = (rega < regb)?1:0; // 不带符号比较
			3'b110 : begin // 带符号比较
				result = (((rega<regb) && (rega[31] == regb[31] )) ||( ( rega[31] ==1 && regb[31] == 0))) ? 1:0;
			end
			3'b111: if(rega[31] == regb[31]) result = 0;
			        else result = 1;			
			default : begin
				result = 0;				//$display (" no match");
			end
		endcase
	end
endmodule