`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 21:36:25
// Design Name: 
// Module Name: controlUnit
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

module controlUnit(
	ops,
	zero,
	ExtSel,
	PCWre,
	insMemRW,
	RegDst,
	 RegWre,
	 ALUOp,
	PCSrc,
	ALUSrcA,
	ALUSrcB,
	 mRD,
	mWR,
	DBDataSrc
);
	input [5:0] ops;
	input wire zero;

	output reg ExtSel;
	output reg PCWre;
	output reg insMemRW;
	output reg RegDst;
	output reg RegWre;
	output reg[2:0] ALUOp;
	output reg [1:0]PCSrc;
	output reg ALUSrcA;
	output reg ALUSrcB;
	output reg mRD;
	output reg mWR;
	output reg DBDataSrc;

	initial begin
		ExtSel = 0;
		PCWre = 1;   //¸ü¸Äpc
		insMemRW = 1;  // Ð´Ö¸Áî
		RegDst = 0;    
		RegWre = 0;
		ALUOp = 0;
		PCSrc = 0;
		ALUSrcA = 0;
		ALUSrcB = 0;
		mRD = 0;
		mWR = 0;
		DBDataSrc = 0;
	end

	always@ (zero or ops)begin
		case(ops)
			6'b000000:               //add
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 1;
				insMemRW = 1;
			//	mRD = 0;
				mWR = 0;
				RegDst  = 1;
			//	ExtSel = 0;
				PCSrc = 00;
				ALUOp = 000;
			end
			6'b000001:               //addi
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 1;
				DBDataSrc = 0;
				RegWre = 1;
				insMemRW = 1;
			//	mRD = 0;
				mWR = 0;
				RegDst  = 0;
				ExtSel = 1;
				PCSrc = 00;
				ALUOp = 000;
			end
			6'b000010:               //sub
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 1;
				insMemRW= 1;
			//	mRD = 0;
				mWR = 0;
				RegDst  = 1;
				ExtSel = 0;
				PCSrc = 00;
				ALUOp = 001;
			end
			6'b010000:               //ori
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 1;
				DBDataSrc = 0;
				RegWre = 1;
				insMemRW= 1;
			//	mRD = 0;
				mWR = 0;
				RegDst  = 0;
				ExtSel = 0;
				PCSrc = 00;
				ALUOp = 011;
			end
			6'b010001:               //and
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 1;
				insMemRW = 1;
			//	mRD = 0;
				mWR = 0;
				RegDst  = 1;
				ExtSel = 0;
				PCSrc = 00;
				ALUOp = 100;
			end
			6'b010010:              //or
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 1;
			    insMemRW = 1;
			//	mRD = 0;
				mWR = 0;
				RegDst  = 1;
				ExtSel = 0;
				PCSrc = 00;
				ALUOp = 011;
			end
			6'b011000:               //sll
			begin
				PCWre = 1;
				ALUSrcA = 1;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 1;
				insMemRW = 1;
				//mRD = 0;
			    mWR = 0;
				RegDst  = 1;
				ExtSel = 1;
				PCSrc = 00;
				ALUOp = 010;
			end
			6'b011011:               //slti
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 1;
				DBDataSrc = 0;
				RegWre = 1;
				insMemRW = 1;
			//	mRD = 0;
				mWR = 0;
				RegDst  = 0;
				ExtSel = 1;
				PCSrc = 00;
				ALUOp = 101;
			end
			6'b100110:               //sw
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 1;
				DBDataSrc = 0;
				RegWre = 0;
				insMemRW = 1;
				mRD = 0;
				mWR = 1;
				RegDst  = 0;  ///£¿£¿£¿£¿£¿£¿£¿
				ExtSel = 1;
				PCSrc = 00;
				ALUOp = 000;
			end
			6'b100111:               //lw 
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 1;
				DBDataSrc = 1;
				RegWre = 1;
				insMemRW = 1;
				mRD = 1;
				mWR = 0;
				RegDst  = 0;
				ExtSel = 1;
				PCSrc = 00;
				ALUOp = 000;
			end
			6'b110000:               //beq
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 0;
				insMemRW = 1;
			//	mRD = 0;
				//mWR = 0;
				RegDst  = 1;
				ExtSel = 1;
				if(zero == 0)
					PCSrc = 01;
				else if(zero == 1)
					PCSrc = 00;
				ALUOp = 101;
			end
			6'b110001:               //bne
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 0;
				insMemRW = 1;
			//	mRD = 0;
			//	mWR = 0;
				RegDst = 1;
				ExtSel = 1;
				if(zero == 1)
					PCSrc = 01;
				else if(zero != 1)
					PCSrc = 00;
				ALUOp = 100;
			end
			6'b111000:               //j
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 0;
				insMemRW = 1;
			//	mRD = 0;
			//	mWR = 0;
				RegDst  = 1;
				ExtSel = 1;
				PCSrc = 10;		
				ALUOp = 101;
			end
			6'b111111:               //halt
			begin
				PCWre = 0;
			end
	   endcase
	end
endmodule