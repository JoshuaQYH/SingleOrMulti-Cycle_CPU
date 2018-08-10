`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 11:19:30
// Design Name: 
// Module Name: JumpAddressExtend
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


module JumpAddressExtend(
    PCPlusFourAddress, AddressToExtend, ExtendedAddress
);
    input wire [31:0] PCPlusFourAddress;
    input wire [25:0] AddressToExtend;
    output wire [31:0] ExtendedAddress;
    
    assign ExtendedAddress = {PCPlusFourAddress[31:28], AddressToExtend[25:0],{2{1'b0}}};

endmodule
