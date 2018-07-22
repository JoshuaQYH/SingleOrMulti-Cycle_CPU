`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 21:38:45
// Design Name: 
// Module Name: RegFile
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
//寄存器堆
module RegFile(
	input CLK,   //时钟信号
	input reset,  //复位信号
	input RegWre,  //寄存器写使能信号
	input [4:0] ReadReg1,  //读取寄存器1
	input [4:0] ReadReg2,  //读取寄存器2
	input [4:0] WriteReg,  //写寄存器1
	input [31:0] WriteData,  // 写入寄存器 
	output [31:0] ReadData1,//输出readReg1
	output [31:0] ReadData2  //输出readreg2
);
	reg [31:0] regFile[0:31]; // 寄存器定义必须用reg 类型
	integer i;
	initial begin
	   for( i = 0; i < 32; i = i+1)
	       regFile[i] = 0;
	end
	assign ReadData1 = (ReadReg1 == 0 ? 0:regFile[ReadReg1]);
	assign ReadData2 = (ReadReg2 == 0 ? 0:regFile[ReadReg2]);
        
	//assign ReadData1 = regFile[ReadReg1]; //  直接输出rs
//	assign ReadData2 = regFile[ReadReg2]; 
	always @ (negedge CLK ) begin // 必须用时钟边沿触发		
		 if(RegWre == 1 && WriteReg != 0)begin // WriteReg != 0，$0寄存器不能修改
			regFile[WriteReg] <= WriteData; // 写寄存器，将要写入的值赋给寄存器
		end		
	end
endmodule