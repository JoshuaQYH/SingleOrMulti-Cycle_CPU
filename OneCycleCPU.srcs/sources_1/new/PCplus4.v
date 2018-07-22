`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 21:36:45
// Design Name: 
// Module Name: PCplus4
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

module PCplus4(
	 inputPC,
     outputPC
);

	input wire [31:0] inputPC;
	input wire [31:0] outputPC;
    //PC£«4
	assign outputPC[31:0] = inputPC[31:0] + 4;

endmodule
