`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/31 20:39:37
// Design Name: 
// Module Name: TestCPU
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


module TestCPU();
    reg _clk;
    reg _reset;
    wire _zero;
    wire[31:0] _CurrentAddress;
    wire[31:0] _NextAddress;  
    wire[1:0] _PCSrc;
    wire [2:0] _ALUOp; 
    wire[31:0] _ReadData1, _ReadData2, _ALUResult;
    wire [31:0] _dataA;           //ALU操作数1
    wire [31:0] _dataB;           //ALU操作数2
            
    wire[31:0] _ExtendOut, _DataOut, _IDataOut;
    wire[4:0] _WriteReg;
    wire[31:0] _WriteData;
    wire [4:0] _rs;        
    wire [4:0] _rt;
    wire [4:0] _rd;
    wire [31:0] _sa;
    wire [5:0] _opcode;
   // wire [1:0] _PCSrc;           // 确定产生下个地址的控制信号
    wire [31:0] _PCPlusFourAddress;    //pc+4地址
    wire [15:0] _immediate;        //立即数符号数
    wire [31:0] _ExtendResult;       // 0 / 符号扩展位输出
    wire [25:0] _toExtendAddress;   //j指令中待扩展地址
    wire [31:0] _JumpAddress;       //扩展后跳转地址
     DataPipe datapipe(
             .clk(_clk),
             .reset(_reset),
             .zero(_zero),
             .CurrentAddress(_CurrentAddress),
             .NextAddress(_NextAddress),
             .ALUOp(_ALUOp),
             .ReadData1(_ReadData1),
             .ReadData2(_ReadData2),
             .dataA(_dataA),           //ALU操作数1
             .dataB(_dataB),           //ALU操作数2
             .ALUResult(_ALUResult),
             .IDataOut(_IDataOut),
             .DataOut(_DataOut),
             .WriteData(_WriteData),
             .rs(_rs),        
             .rt(_rt),
             .rd(_rd),
             .sa(_sa),
             .opcode(_opcode),
             .PCSrc(_PCSrc),           // 确定产生下个地址的控制信号
             .PCPlusFourAddress(_PCPlusFourAddress),    //pc+4地址
             .immediate(_immediate),        //立即数符号数
             .ExtendResult(_ExtendResult),       // 0 / 符号扩展位输出
             .toExtendAddress(_toExtendAddress),   //j指令中待扩展地址
             .JumpAddress(_JumpAddress),      //扩展后跳转地址
             .WriteReg(_WriteReg)
    );  
  
	   initial begin
	       _clk = 0;
	       _reset = 0; //初始化输入
	      
	       #50;    //50 ns后开始 重置
	           _clk = 1;
	       #50; //不再重置 pc 0
	         //  _reset = 1;
	       forever #50 begin   //产生时钟信号
	           _reset = 1;
	           _clk = !_clk;
	       end
        end
endmodule
