`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 11:11:30
// Design Name: 
// Module Name: Selector41_32bits
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 10:57:37
// Design Name: 
// Module Name: Selector41_31bits
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


module Selector41_32bits(
  PCPlusFourAddress, ExtendedImmediate, ReadData1, ExtendedAddress, PCSrc, NextAddress
);
    input wire[31:0] PCPlusFourAddress;  // PC + 4  地址
    input wire[31:0] ExtendedImmediate;  // 立即数扩展
    input wire[31:0] ReadData1;          // 寄存器 rs 输出值
    input wire[31:0] ExtendedAddress;    //跳转指令扩展地址
    input [1:0] PCSrc;              // 控制信号
    output reg[31:0] NextAddress;        // 产生下一条指令地址
    
    always @( PCPlusFourAddress or ExtendedImmediate or ReadData1 or ExtendedAddress or PCSrc)begin
            case (PCSrc)
                2'b00: NextAddress = PCPlusFourAddress;                             // 顺序执行
                2'b01: NextAddress = PCPlusFourAddress + (ExtendedImmediate << 2);  // 分支跳转
                2'b10: NextAddress = ReadData1;                                     // 寄存器寻址
                2'b11: NextAddress = ExtendedAddress;                               // 跳转地址
                default:begin
                     NextAddress = NextAddress;  // 保留原地址不变
                end                        //$display (" no match");
            endcase
        end
    
endmodule
