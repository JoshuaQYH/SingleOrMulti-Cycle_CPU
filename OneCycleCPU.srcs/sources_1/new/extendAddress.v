`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 21:38:24
// Design Name: 
// Module Name: extendAddress
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

module extendAddress(
    toExtendAddress,
    PCPlusFourAddress,
     JumpAddress
);

	input wire[25:0] toExtendAddress;
	input wire[31:0] PCPlusFourAddress;
	output wire[31:0] JumpAddress;
    assign JumpAddress = {PCPlusFourAddress[31:28], toExtendAddress[25:0],{2{0}}};
	//assign ExtendAddress = {pcPlusFour[31:28], Address[25:0], 2{0}};

endmodule