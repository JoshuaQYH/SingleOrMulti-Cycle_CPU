`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/31 01:11:27
// Design Name: 
// Module Name: dataPipe
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
`include "RAM.v"
`include "selector32"
`include "controlUnit.v"
`include "PCplus4.v"
`include "ALU32.v"
`include "selector5.v"
`include "selector3to1.v"
`include "extenndAddress.v"
`include "RegFile.v"
`include "PC.v"
`include "ROM.v"

module dataPipe(
	 clk,     
	 reset,      //初始重置
	 opcodes,      //操作码
	 zero,           //ALU的零位信号
	 sign,           // ALU的符号位信号
	 CurrentAddress, // 当前指令的地址
	 NextAddress,  // 下一个指令的地址
	 AluResult,   // 32位ALU运算结果
	 WriteData,   //写入寄存器
	 ReadData1,
	 ReadData2,   //寄存器堆2的输出
	 RAMDataOut,  // 数据存储器的输出
	 PcPlusFour,  // PC+4模块的输出
	 ExtendData,  // 0 / 符号扩展器的输出
	 ExtSel,   // 0 扩展还是符号扩展
	 PCWre,
	 InsMemRW,
	 RegDst,
	 RegWre,
	 ALUOp,      // ALU操作码
	 ALUSrcA,    //选择控制寄存器组2的输出和sa字段
	 ALUSrcB,   // 选择控制寄存器组的输出和移位扩展段
	 mRD,       // 为0 读
	 mWR,       //为 0 写
	 DBDataSrc  //控制输出数据存储器的内容或者ALUy运算结果写到寄存器或者输
);
    input clk, reset;
    output [5:0] opcodes;
    output [2:0] ALUOp;
    output [31:0] CurrentAddress,RAMDataout, NextAddress, AluResult, WriteData, ReadData1, ReadData2, PCPlusFour, ExtendData, Dataout;
    wire zero, sign;
    wire PCWre, InsMemRW, RegDst, RegWre, ALUop, ALUSrcA, ALUSrcB, mRD, mWR, DBDataSrc;
    

endmodule 
