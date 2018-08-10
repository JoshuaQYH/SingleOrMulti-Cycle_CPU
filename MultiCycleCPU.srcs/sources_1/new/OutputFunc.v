`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/17 16:57:35
// Design Name: 
// Module Name: OutputFunc
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


module OutputFunc(
    opcode, zero, sign, OutputState, DBDataSrc, mWR, mRD,ExtSel, PCWre,
    IRWre, InsMemRW, WrRegDSrc, RegDst, RegWre, ALUOp, PCSrc, ALUSrcA, ALUSrcB  
);
    input [5:0] opcode;
    input zero, sign;
    input [2:0] OutputState;
    output reg DBDataSrc;
    output reg mWR;
    output reg mRD;
    output reg ExtSel;
    output reg PCWre;
    output reg IRWre;
    output reg InsMemRW;
    output reg WrRegDSrc;
    output reg RegWre;
    output reg ALUSrcA;
    output reg ALUSrcB;
    output reg [1:0] RegDst;
    output reg [1:0] PCSrc;
    output reg [2:0] ALUOp;
    
    initial begin
                ExtSel = 0;
                PCWre = 1;   //更改pc
                InsMemRW = 1;  // 写指令
                IRWre = 1;
                RegDst = 0;    
                RegWre = 0;
                ALUOp = 0;
                PCSrc = 0;
                ALUSrcA = 0;
                ALUSrcB = 0;
                mRD = 0;
                mWR = 1;
                DBDataSrc = 0;
     end

      //     状态码
      parameter [2:0] IF = 3'b000;
      parameter [2:0] ID = 3'b001 ;
      parameter [2:0] EXE = 3'b010; 
      parameter [2:0] WB = 3'b011;
      parameter [2:0] MEM = 3'b100;
      
      parameter [5:0] _add = 6'b000000; 
      parameter [5:0] _sub = 6'b000001; 
      parameter [5:0] _addi = 6'b000010;  
      parameter [5:0] _or = 6'b010000; 
      parameter [5:0] _and = 6'b010001; 
      parameter [5:0] _ori = 6'b010010; 
      parameter [5:0] _sll = 6'b011000; 
      parameter [5:0] _slt = 6'b100110; 
      parameter [5:0] _sltiu = 6'b100111; 
      parameter [5:0] _sw = 6'b110000; 
      parameter [5:0] _lw = 6'b110001; 
      parameter [5:0] _beq = 6'b110100; 
      parameter [5:0] _bltz = 6'b110110; 
      parameter [5:0] _j = 6'b111000; 
      parameter [5:0] _jr = 6'b111001; 
      parameter [5:0] _jal = 6'b111010; 
      parameter [5:0] _halt = 6'b111111;
      
      always @(OutputState or opcode or sign or zero)begin
          // PCWre
          if(OutputState == IF && opcode != _halt) PCWre = 1;
          else PCWre = 0;  // 除非遇到停机指令否则 为1
         
          //InsMemRW
          InsMemRW = 1;   //一直为1 保持取指状态
          
          //IRWre
          if(OutputState == IF) IRWre = 1;
          else IRWre = 0;   //除非取指状态，否则为0
          
           
           if(OutputState == EXE) begin
            //ALUSrcA
                     if(opcode == _sll) ALUSrcA = 1;
                     else ALUSrcA = 0;  // sll 输入sa移位码
                     
                     //ALUSrcB
                     if(opcode == _addi || opcode == _ori || opcode == _sltiu || opcode == _lw || opcode == _sw)
                         ALUSrcB = 1; //需要立即数的指令声明为1
                     else ALUSrcB = 0;
            //ALUOp
               case(opcode)
                      _add: ALUOp = 3'b000;
                      _sub: ALUOp = 3'b001;
                      _addi: ALUOp = 3'b000;
                      _or: ALUOp = 3'b101;
                      _and: ALUOp = 3'b110;
                      _ori: ALUOp = 3'b101; 
                      _sll: ALUOp = 3'b100;
                      _slt: ALUOp = 3'b010;
                      _sltiu: ALUOp = 3'b010;
                      _sw: ALUOp = 3'b000;
                      _lw: ALUOp = 3'b000;  
                      _beq: ALUOp = 3'b001;
                      _bltz: ALUOp = 3'b001;
               endcase          
           end
         
           if(OutputState == ID)begin
                 //ExtSel   需要0 或立即数的指令声明为1
                  if(opcode == _addi || opcode == _sll || opcode == _sltiu || opcode == _sw || opcode == _lw || opcode == _beq || opcode == _bltz)
                   ExtSel = 1;
                  else ExtSel = 0;
           end
           
           if(OutputState == IF)begin
                 //PCSrc 
                     case(opcode)
                         _j: PCSrc = 2'b11;
                         _jal: PCSrc = 2'b11;
                         _jr: PCSrc = 2'b10;
                         _beq: begin
                               if(zero)
                                   PCSrc = 2'b01;
                               else PCSrc = 2'b00;
                         end
                         _bltz:begin
                              if(sign)
                                  PCSrc = 2'b01;
                              else PCSrc = 2'b00;
                         end
                         default: PCSrc = 2'b00;
                     endcase
           end          
   
           //mWR  存储阶段，根据 opcode 确定读取或者存储存储器的内容
           if(OutputState == MEM)begin
                  if(opcode == _sw) mWR = 1;
                    else mWR = 0;
                    //mRD
                    if(opcode == _lw) mRD = 1;
                    else mRD = 0;
           end
         
         
           //////////////////////WB 
           //DBDataSrc 筛选 lw 指令读取存储器的内容 和 ALU运算结果
           if(OutputState == WB && opcode == _lw) DBDataSrc = 1'b1;
           else if(OutputState == WB) DBDataSrc = 1'b0;
           
          //WrRegDSrc 写回阶段确定写入寄存器的内容
          if(OutputState == ID && opcode == _jal) WrRegDSrc = 1'b0;
          else if(OutputState == WB) WrRegDSrc = 1'b1;
     
          
            //RegWre 写回阶段，寄存器组可写，其他阶段寄存器可读
          if(OutputState == WB || opcode == _jal) RegWre = 1'b1;
          else RegWre = 1'b0;   //写回的时候需要等于1
           
            //RegDst ，写回阶段，确定写入的位置。根据操作码的不同来确定
           if(opcode == _jal && OutputState == ID) RegDst = 2'b00;  // jal 指令 需要31号寄存器
                          
           if(OutputState == WB)begin                
                if(opcode == _lw || opcode == _addi || opcode == _ori || opcode == _sltiu) RegDst = 2'b01;  // lw指令 指定rt 寄存器
                else RegDst = 2'b10;              // add 等指定 rd寄存器
           end          
           
           //取值阶段防止写入读取存储器
           if(OutputState == IF)begin
                RegWre = 0;
                mRD = 0;
                mWR = 0;
           end
      end                                                                                               
endmodule
