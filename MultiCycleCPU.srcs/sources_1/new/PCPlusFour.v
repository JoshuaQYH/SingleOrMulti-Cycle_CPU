`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 10:09:21
// Design Name: 
// Module Name: PCPlusFour
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


module PCPlusFour(
CurrentAddress,PCPlusFourAddress
);
     input wire [31:0] CurrentAddress;
     output wire [31:0] PCPlusFourAddress;
     assign PCPlusFourAddress [31:0] = CurrentAddress[31:0] + 3'b100;
endmodule
