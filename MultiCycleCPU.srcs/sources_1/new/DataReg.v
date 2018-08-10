`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 16:30:44
// Design Name: 
// Module Name: DataReg
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


module DataReg(
DataIn, DataOut, CLK
);
   input wire [31:0] DataIn;
   output reg [31:0] DataOut;
   input  CLK;
   
   always @(posedge CLK)begin
          DataOut = DataIn;  
   end

endmodule
