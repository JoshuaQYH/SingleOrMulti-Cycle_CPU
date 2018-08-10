`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 09:41:42
// Design Name: 
// Module Name: PC
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


module PC(
PCWre, NextAddress, CLK, RST, CurrentAddress
);
    
    input  PCWre;
    input wire [31:0]NextAddress;
    input  CLK;
    input  RST;
    output reg [31:0] CurrentAddress;
    
     //等待时钟上升沿
       always@(posedge CLK)begin
           if(RST == 0)begin  //初始化
               CurrentAddress = 0;
           end
           else if(!PCWre)begin  //停机
               CurrentAddress = CurrentAddress;
           end
           else if(PCWre)begin   //不停机，下一条指令地址成为当前指令地址
               CurrentAddress = NextAddress;
           end
       end
endmodule 