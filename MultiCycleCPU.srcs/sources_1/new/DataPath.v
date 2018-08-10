`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 17:56:24
// Design Name: 
// Module Name: DataPath
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

`timescale 1ns / 1ps
module DataPath(
	     CLK,              // 时钟
		 RST,           // 复位信号
	     zero,            //零信号
	     sign,
		 CurrentAddress,   // 当前指令地址
		 NextAddress,     // 下一条指令地址
		 ALUOp,           //alu操作码
		 ReadData1,       //寄存器 堆1 输出来自rs
         ReadData2,        // 寄存器 堆2 输出来自rt
         dataA,           //ALU操作数1
         dataB,           //ALU操作数2
		 ALUResult,       //ALU 运算结果
	     IDataOut,         //指令存储器输出指令 
	     DataOut,          //数据存储器输出            
	     WriteData,            //通过二选一写数据进入寄存器
	     rs,        
	     rt,
	     rd,
	     sa,
	     opcode,          // 控制单元指令单元操作码
	     PCSrc,           // 确定产生下个地址的控制信号
         PCPlusFourAddress,    //pc+4地址
         immediate,        //立即数符号数
         ExtendResult,       // 0 / 符号扩展位输出
         toExtendAddress,   //j指令中待扩展地址
         JumpAddress,       //扩展后跳转地址
         WriteReg,           //  写入寄存器的位置
         IRDataOut,           // 指令寄存器的输出值
         );  //29 ports
        input wire CLK, RST, zero, sign;
		output [31:0] DataOut;	// 扩展字段输出，和数据存储器输出
		output [31:0] IRDataOut; 	
		output [31:0] NextAddress;
	    input wire [4:0] WriteReg; //写寄存器
		output [2:0] ALUOp;   // 控制信号alu操作码 
        wire mRD, mWR;
        output [1:0] PCSrc;
	    wire InsMemRW;    
		output wire[31:0] IDataOut;  
		output wire [31:0] WriteData;
		
		//控制信号
		wire ExtSel, PCWre, RegWre, ALUSrcA, ALUSrcB, DBDataSrc, IRWre, WrRegDSrc;
		wire [1:0] RegDst;
        output wire[31:0] ReadData1;  // 寄存器输出值1
        output wire[31:0] ReadData2;  //寄存器输出值2
        output wire[31:0] CurrentAddress;  //当前地址
        output wire[31:0] ALUResult;   //ALU运算结果 
         output wire[31:0] ExtendResult;  //符号位扩展结果
         //分配字段
	     input wire[4:0] rs;
	     assign rs = IRDataOut[25:21]; 
		 input wire[4:0] rt;
		 assign rt = IRDataOut[20:16];
		 input wire[4:0] rd;
		 assign rd = IRDataOut[15:11];
		 input wire[31:0] sa;
		 assign sa = {{26{1'b0}},IRDataOut[10:6]};     ///////////////   bug ??
		 input wire[5:0] opcode;
		 assign opcode = IRDataOut[31:26];
		 wire[15:0] toSignZeroExtend;
		 assign toSignZeroExtend = IRDataOut[15:0];
		 input wire[25:0]toExtendAddress;
		 assign toExtendAddress = IRDataOut[25:0];
		 input wire[15:0] immediate;
		 assign immediate = IRDataOut[15:0];
         input wire[31:0] dataA, dataB;   // 进入ALU单元的数据
         input wire[31:0] PCPlusFourAddress;  // PC加4模块，进入三选一模块
         input wire[31:0] JumpAddress;  //跳转地址，进入三选一模块	
                      
        
        
	//PC时钟运行
	PC _PC(PCWre, NextAddress, CLK, RST, CurrentAddress);
   //PC + 4模块产生地址
    PCPlusFour _PCplus4(CurrentAddress, PCPlusFourAddress);              
	 // 指令存储器模块
     //	 mRD = 1;
	InsMem _InsMem(InsMemRW, CurrentAddress, IDataOut);

    //指令寄存器IR    
    IR _IR(IRWre, IDataOut, CLK, IRDataOut);
    
	ControlUnit controlunit(
    zero,  RST,  CLK, mRD,  mWR, DBDataSrc,
    ExtSel, PCWre, IRWre, InsMemRW, opcode, WrRegDSrc,
    RegDst,  RegWre,  ALUOp,  PCSrc, sign,  ALUSrcA, ALUSrcB 
    );
	
	
    Selector31_5bits selectorWriteReg(rt, rd, RegDst, WriteReg);
	// 寄存器组模块化
	RegFile  _RegFile(RegWre, CLK, rs, rt, WriteReg, WriteData, ReadData1, ReadData2);
    //0 符号扩展位
    SignZeroExtend _SignZeroExtend(immediate, ExtSel , ExtendResult);

         //产生跳转地址
    JumpAddressExtend _JumpAddressExtend(PCPlusFourAddress,toExtendAddress,JumpAddress);
        // 四选一选择器确定下一条指令地址
     Selector41_32bits Selector41_32bits(PCPlusFourAddress, ExtendResult, ReadData1, JumpAddress, PCSrc, NextAddress);    
    // 数据寄存器
    wire [31:0] ADROut,BDROut,ALUOutDROut, DBDROut;
    DataReg ADR(ReadData1, ADROut, CLK);  
    DataReg BDR(ReadData2, BDROut, CLK);
    //32位数据选择器，输入ALU
     Selector21_32bits selector32_A(ADROut, sa, ALUSrcA, dataA);
     Selector21_32bits selector32_B(BDROut, ExtendResult, ALUSrcB,dataB);
   // wire [31:0] ALUOutDROut;
    ALU _ALU(dataA, dataB,ALUOp, ALUResult, zero, sign);
    DataReg ALUOutDR(ALUResult,ALUOutDROut,CLK);
    //实例化数据存储器，命名一律用 _name格式
    DataMem _DataMem(CLK, mWR, mRD, ALUOutDROut, BDROut, DataOut);

    
    wire [31:0] DBDRIn; 
    //二选一选择器
    Selector21_32bits ToDBDR(ALUResult, DataOut, DBDataSrc, DBDRIn);
    DataReg DBDR(DBDRIn, DBDROut, CLK);      
    Selector21_32bits ToRegFile(PCPlusFourAddress, DBDROut, WrRegDSrc, WriteData);
    
   

endmodule
