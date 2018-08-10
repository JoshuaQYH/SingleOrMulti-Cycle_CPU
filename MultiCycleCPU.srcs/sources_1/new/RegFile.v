`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 09:59:10
// Design Name: 
// Module Name: RegFile
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


module RegFile(
RegWre, CLK,  rs,  rt, WriteReg ,
WriteData, ReadData1, ReadData2
);
        
    input  RegWre;
    input  CLK;
    input wire [4:0]rs;
    input wire [4:0]rt;
  //  input wire [1:0] RegDst;
  //  input wire [4:0] rd;
    input wire [4:0] WriteReg; 
    input wire [31:0] WriteData;
    output wire [31:0] ReadData1;
    output wire [31:0] ReadData2;
    
    reg [31:0] regFile[0:31]; // 寄存器组值的定义，同样大端存储
    integer i;
    initial begin
        for( i = 0; i < 32; i = i+1)
           regFile[i] = 0;
    end
    //0号寄存器的值为0
    assign ReadData1 = (rs == 0 ? 0:regFile[rs]);  //寄存器输出值1
    assign ReadData2 = (rt == 0 ? 0:regFile[rt]);  //寄存器输出值2
    
	always @ (negedge CLK ) begin //
	       
         if(RegWre == 1 && WriteReg != 0)begin // 
            regFile[WriteReg] <= WriteData; //  写入寄存器
         end
    end    
       
endmodule
