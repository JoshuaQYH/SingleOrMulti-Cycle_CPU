`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/19 08:52:37
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


module TestCPU;
   reg _CLK;
   reg _RST;
   wire _zero;
   wire _sign;
   wire[31:0] _CurrentAddress;
   wire[31:0] _NextAddress;  
   wire[1:0]  _PCSrc;
   wire [2:0] _ALUOp; 
   wire[31:0] _ReadData1, _ReadData2, _ALUResult;
   wire [31:0] _dataA;           //ALU操作数1
   wire [31:0] _dataB;           //ALU操作数2
           
   wire[31:0] _ExtendOut, _DataOut, _IDataOut, _IRDataOut;
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
    DataPath _DataPath(
	     .CLK(_CLK),              // 时钟
		 .RST(_RST),           // 复位信号
	     .zero(_zero),            //零信号
	     .sign(_sign),
		 .CurrentAddress(_CurrentAddress),   // 当前指令地址
		 .NextAddress(_NextAddress),     // 下一条指令地址
		 .ALUOp(_ALUOp),           //alu操作码
		 .ReadData1(_ReadData1),       //寄存器 堆1 输出来自rs
         .ReadData2(_ReadData2),        // 寄存器 堆2 输出来自rt
         .dataA(_dataA),           //ALU操作数1
         .dataB(_dataB),           //ALU操作数2
		 .ALUResult(_ALUResult),       //ALU 运算结果
	     .IDataOut(_IDataOut),         //指令存储器输出指令 
	     .DataOut(_DataOut),          //数据存储器输出            
	     .WriteData(_WriteData),            //通过二选一写数据进入寄存器
	     .rs(_rs),        
	     .rt(_rt),
	     .rd(_rd),
	     .sa(_sa),
	     .opcode(_opcode),          // 控制单元指令单元操作码
	     .PCSrc(_PCSrc),           // 确定产生下个地址的控制信号
         .PCPlusFourAddress(_PCPlusFourAddress),    //pc+4地址
         .immediate(_immediate),        //立即数符号数
         .ExtendResult(_ExtendResult),       // 0 / 符号扩展位输出
         .toExtendAddress(_toExtendAddress),   //j指令中待扩展地址
         .JumpAddress(_JumpAddress),       //扩展后跳转地址
         .WriteReg(_WriteReg),           //  写入寄存器的位置
         .IRDataOut(_IRDataOut)           // 指令寄存器的输出值
         );  
         
            initial begin
                    _CLK = 0;
                    _RST = 0; //初始化输入
                   
                    #50;    //50 ns后开始 重置
                        _CLK = 1;
                    #50; //不再重置 pc 0
                      // _RST = 1;
                    forever #50 begin   //产生时钟信号
                        _RST = 1;
                        _CLK = !_CLK;
                    end
                 end         
endmodule
