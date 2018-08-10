`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 11:07:16
// Design Name: 
// Module Name: Selector21_32bits
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


module Selector21_32bits(
    Data1, Data2, Control, Result 
);
    input wire [31:0] Data1;
    input wire [31:0] Data2;
    input  Control;
    output wire [31:0] Result;
    assign Result = (Control == 0) ? Data1: Data2;
    
endmodule
