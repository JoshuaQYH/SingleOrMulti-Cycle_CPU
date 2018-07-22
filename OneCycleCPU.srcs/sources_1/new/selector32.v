`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 21:35:53
// Design Name: 
// Module Name: selector32
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
//32位数据选择器
module selector32(
	 control,
	  Data1,
	  Data2,
	  result
);
	input control;  
	input wire[31:0] Data1;
	input wire[31:0] Data2;
	output wire[31:0] result;
	assign result = (control == 0) ? Data1: Data2;
endmodule  