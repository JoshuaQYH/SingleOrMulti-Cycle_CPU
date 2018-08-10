`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/21 16:10:13
// Design Name: 
// Module Name: Selector31_5bits
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


module Selector31_5bits(
    rt, rd, RegDst, WriteReg
);
    input [4:0] rt;
    input [4:0] rd;
    input [1:0] RegDst;
    output reg[4:0] WriteReg;
    
    always @(rt or rd or RegDst)begin
        case(RegDst)
                   2'b00: WriteReg = 5'b11111;   //31ºÅ¼Ä´æÆ÷
                   2'b01: WriteReg = rt;         // rt ¼Ä´æÆ÷
                   2'b10: WriteReg = rd;         // rd ¼Ä´æÆ÷
                   default: WriteReg = WriteReg;
        endcase       
    end
endmodule
