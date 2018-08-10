`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 10:04:16
// Design Name: 
// Module Name: ALU
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


module ALU(
  DataA, DataB,  ALUOp,  ALUResult, zero,  sign
);
      input wire [31:0] DataA; 
      input wire [31:0] DataB; 
      input  [2:0] ALUOp; 
      output reg [31:0] ALUResult; 
      output  zero; 
      output  sign;
      
      initial begin
         ALUResult = 0;
      end
      assign sign = ( ALUResult[31] == 0)?0:1; // 结果负数 为1  
      assign zero = ( ALUResult == 0 )?1:0;   //    结果为0 为1
      
      always @( ALUOp or DataA or DataB ) begin
          case (ALUOp)  //根据操作码来判断执行的操作
              3'b000 : ALUResult = DataA + DataB;  
              3'b001 : ALUResult = DataA - DataB; 
              3'b010 : ALUResult = (DataA < DataB) ? 1 : 0;  //不带符号比较
              3'b011 : ALUResult = (((DataA<DataB) && (DataA[31] == DataB[31] )) ||( ( DataA[31] ==1 && DataB[31] == 0))) ? 1:0;    //带符号比较            
              3'b100 : ALUResult = DataB << DataA;
              3'b101 : ALUResult = DataA | DataB;  
              3'b110 : ALUResult = DataA & DataB;
              3'b111: if(DataA[31] == DataB[31]) ALUResult = 0;
                      else ALUResult = 1;        //异或    
              default : begin
                  ALUResult = 0;                //$display (" no match");
              end
          endcase
      end
endmodule
