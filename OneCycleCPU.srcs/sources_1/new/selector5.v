`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 21:37:44
// Design Name: 
// Module Name: selector5
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
//五位数据选择器
module selector5(
	 control,
	 data1,
	 data2,
	 result
);
    
	input  control;  //控制信号
	input wire [4:0] data1;   
	input wire [4:0] data2;
	output wire [4:0] result;
	assign result = (control == 0)? data1:data2; //控制信号为1，选data1,否则data2
	
endmodule  
