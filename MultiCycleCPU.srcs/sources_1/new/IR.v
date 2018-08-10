`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 16:08:21
// Design Name: 
// Module Name: IR
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


module IR(
    IRWre, IDataOut, CLK, IRDataOut
);
    input  IRWre;          // IR 寄存器写使能信号
    input [31:0] IDataOut;  // 接受指令存储器的指令值
    input CLK;             //时钟信号
    output reg [31:0] IRDataOut; // 指令寄存器的输出指令值 
    
   always @(negedge CLK )begin 
        if(IRWre == 1)
            IRDataOut = IDataOut;   //  更新指令寄存器的输出值
        else
            IRDataOut = IRDataOut;  // 保持现在输出值不变
   end 
endmodule
