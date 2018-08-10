`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 10:11:35
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
zero,  RST,  CLK, mRD,  mWR, DBDataSrc,
ExtSel, PCWre, IRWre, InsMemRW, opcode, WrRegDSrc,
RegDst,  RegWre,  ALUOp,  PCSrc, sign,  ALUSrcA, ALUSrcB 
);
        
    input  zero; 
    input  RST;
    input  CLK;
    output  mRD;
    output mWR; 
    output  DBDataSrc;
    output  ExtSel;
    output  PCWre;
    output IRWre;
    output  InsMemRW;
    input  [5:0] opcode; 
    output  WrRegDSrc; 
    output  [1:0]RegDst;
    output RegWre;
    output  [2:0]ALUOp;
    output  [1:0]PCSrc;
    input sign;
    output  ALUSrcA;
    output  ALUSrcB;
      
    wire [2:0] InputState;
    wire [2:0] OutputState;
   
    // 触发器
    DFlipFlop dFlipFlop(RST, CLK, InputState, OutputState);
    // 下一状态
    NextState nextState(OutputState, opcode, InputState);
    // 输出函数
   OutputFunc outputFunc(
        opcode, zero, sign, OutputState,DBDataSrc, mWR, mRD,ExtSel, PCWre,
        IRWre, InsMemRW, WrRegDSrc, RegDst, RegWre, ALUOp, PCSrc, ALUSrcA, ALUSrcB  
    );
endmodule
