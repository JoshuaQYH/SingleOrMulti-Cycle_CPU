`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/17 16:56:44
// Design Name: 
// Module Name: DFlipFlop
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


module DFlipFlop(
RST, CLK, InputState, OutputState
);
    input RST, CLK;
    input [2:0] InputState;
    output reg[2:0] OutputState;
    initial begin
        OutputState = 3'b000;
    end
    
    always @(negedge CLK)begin
        if(RST == 0) OutputState = 3'b000;   // 重置为0
        else OutputState = InputState;  // 输出等于输入
    end
    
endmodule
