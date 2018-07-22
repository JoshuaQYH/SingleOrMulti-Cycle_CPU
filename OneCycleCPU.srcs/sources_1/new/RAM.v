`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 21:34:58
// Design Name: 
// Module Name: RAM
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


module RAM(
    clk,
    address,
    writeData, // [31:24], [23:16], [15:8], [7:0]
	mRD, // 为1，正常读；为0,输出高组态
    mWR, // 为1，写；为0，无操作
    DataOut
);
    input clk, mRD, mWR;
    input [31:0] address;
    input [31:0] writeData;
	reg [7:0] ram[0:63]; //数据存储器定义
	output reg [31:0] DataOut;	
	
	initial begin
	   DataOut = 0;
	end
	
	//
	always@( negedge clk ) begin
		if( mWR == 1 ) begin   //写
			ram[address] <= writeData[31:24];
			ram[address+1] <= writeData[23:16];
			ram[address+2] <= writeData[15:8];
			ram[address+3] <= writeData[7:0];
	   end
	   else begin
	    if(mRD == 1)begin    // 读
               DataOut[31:24] = ram[address+3];
               DataOut[23:16] = ram[address+2];
               DataOut[15:8] = ram[address+1];
               DataOut[7:0] = ram[address];
	       end
	       else if(mRD == 0)begin //高阻态
               DataOut[31:24] = 8'bz;
               DataOut[23:16] = 8'bz;
               DataOut[15:8] = 8'bz;
               DataOut[7:0] = 8'bz;
	       end
	   end
	 end
endmodule
