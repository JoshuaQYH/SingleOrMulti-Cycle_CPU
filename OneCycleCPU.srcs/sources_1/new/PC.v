`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 21:34:43
// Design Name: 
// Module Name: PC
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

// PC程序计数器
module PC(
	 clk,    //时钟信号
	 reset,  //复位
	 input_pc,  //输入下一条指令地址
	 output_pc, //输出当前指令地址
	 PCWre   //停机指令
);
	 input wire[31:0] input_pc;
	 output reg[31:0] output_pc;
	 input clk, reset, PCWre;

    //等待时钟上升沿
	always@(posedge clk)begin
		if(reset == 0)begin  //初始化
			output_pc = 0;
		end
		else if(!PCWre)begin  //停机
			output_pc = output_pc;
		end
		else if(PCWre)begin   //不停机，下一条指令地址成为当前指令地址
			output_pc = input_pc;
		end
	end

endmodule