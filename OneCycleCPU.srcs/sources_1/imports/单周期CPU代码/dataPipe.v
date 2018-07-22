`timescale 1ns / 1ps
module DataPipe(
	    clk,              // 时钟
		 reset,           // 复位信号
	     zero,            //零信号
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
	     opcode,
	     PCSrc,           // 确定产生下个地址的控制信号
         PCPlusFourAddress,    //pc+4地址
         immediate,        //立即数符号数
         ExtendResult,       // 0 / 符号扩展位输出
         toExtendAddress,   //j指令中待扩展地址
         JumpAddress,       //扩展后跳转地址
         WriteReg
);  
        input clk, reset, zero;
		output [31:0] DataOut;	// 扩展字段输出，和数据存储器输出	
		output [31:0] NextAddress;//  PCPlusAddress, ExtendResult, JumpAddress, IDataOut;
	    input wire [4:0] WriteReg; //写寄存器
		output [2:0] ALUOp;   // 控制信号alu操作码 
        wire mRD, mWR;
        output [1:0] PCSrc;
	    wire InsMemRW;    
		output wire[31:0] IDataOut;  
		output wire [31:0] WriteData;
		
		//控制信号
		wire ExtSel, PCWre,  RegDst, RegWre, ALUSrcA, ALUSrcB, DBDataSrc;
        output wire[31:0] ReadData1;  // 寄存器输出值1
        output wire[31:0] ReadData2;  //寄存器输出值2
        output wire[31:0] CurrentAddress;  //当前地址
        output wire[31:0] ALUResult;   //ALU运算结果 
         output wire[31:0] ExtendResult;  //符号位扩展结果
         //分配字段
	     input wire[4:0] rs;
	     assign rs = IDataOut[25:21]; 
		 input wire[4:0] rt;
		 assign rt = IDataOut[20:16];
		 input wire[4:0] rd;
		 assign rd = IDataOut[15:11];
	// wire[4:0] sa = IDataOut[10:6];
		 input wire[31:0] sa;
		 assign sa = {{26{1'b0}},IDataOut[10:6]};
		 input wire[5:0] opcode;
		 assign opcode = IDataOut[31:26];
		 wire[15:0] toSignZeroExtend;
		 assign toSignZeroExtend = IDataOut[15:0];
		 input wire[25:0]toExtendAddress;
		 assign toExtendAddress = IDataOut[25:0];
		 input wire[15:0] immediate;
		 assign immediate = IDataOut[15:0];
         input wire[31:0] dataA, dataB;   // 进入ALU单元的数据
                //wire[15:0] toExtendAddress;
       //  input wire[25:0] toJumpAddress;  // 进入j指令扩展模块，产生跳转地址
                
	//PC时钟运行
	PC _PC(clk, reset, NextAddress, CurrentAddress, PCWre);

	 // 指令存储器模块
     //	 mRD = 1;
	ROM _ROM(InsMemRW, CurrentAddress, IDataOut);

	//控制单元实例化
	controlUnit _controlUnit(opcode, zero, ExtSel, PCWre, InsMemRW, RegDst,RegWre, ALUOp, PCSrc, ALUSrcA, ALUSrcB, mRD, mWR, DBDataSrc);

	// 五位选择器选择进入写寄存器的内容
	selector5 _selector5(RegDst, rt, rd, WriteReg);

	// 寄存器组模块化
	RegFile  _RegFile(clk, reset, RegWre, rs, rt, WriteReg, WriteData, ReadData1, ReadData2);

   //实例化数据存储器，命名一律用 _name格式
   RAM _RAM(clk, ALUResult, ReadData2, mRD, mWR, DataOut);

	//0 符号扩展位
	SignZeroExtend _SignZeroExtend(ExtSel, immediate, ExtendResult);

	//32位数据选择器，输入ALU
	selector32 _selector32_A(ALUSrcA, ReadData1, sa, dataA);
	selector32 _selector32_B(ALUSrcB, ReadData2, ExtendResult, dataB);
    selector32 _selector32_DB(DBDataSrc, ALUResult, DataOut, WriteData);
	// alu32 模块，接受数据选择器的数据，产生结果和 0
	ALU32 _ALU32(ALUOp, dataA, dataB, ALUResult, zero);
	
    input wire[31:0] PCPlusFourAddress;  // PC加4模块，进入三选一模块
	//PC + 4模块产生地址
	PCplus4 _PCplus4(CurrentAddress, PCPlusFourAddress);
	
	input wire[31:0] JumpAddress;  //跳转地址，进入三选一模块	
	//产生跳转地址
	extendAddress _extendAddress(toExtendAddress,PCPlusFourAddress,JumpAddress);
	
	//三选一选择器确定下一条指令地址
	selector3to1 _selector3to1(PCPlusFourAddress, ExtendResult, JumpAddress, PCSrc, NextAddress);
	
endmodule