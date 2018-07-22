module controlUnit(
	input [5:0]ops,
	input zero,
	input sign,
	output ExtSel,
	output PCWre,
	output insMenRW,
	output RegDst,
	output RegWre,
	output AlUOp,
	output PCSrc,
	output ALUSrcA,
	output ALUSrcB,
	output mRD,
	output mWR,
	output DBDataSrc
);
	input reg[5:0] ops;
	input wire zero, sign;

	output reg ExtSel;
	output reg PCWre;
	output reg insMenRW;
	output reg RegDst;
	output reg RegWre;
	output reg[2:0] AlUOp;
	output reg PCSrc;
	output reg ALUSrcA;
	output reg ALUSrcB;
	output reg mRD;
	output reg mWR;
	output reg DBDataSrc;

	initial begin
		ExtSel = 0;
		PCWre = 1;   //更改pc
		insMenRW = 0;  // 写指�?
		RegDst = 0;    
		RegWre = 0;
		ALUop = 0;
		PCSrc = 0;
		ALUSrcA = 0;
		ALUSrcB = 0;
		mRD = 0;
		mWR = 0;
		DBDataSrc = 0;
	end

	always@ (zero or sign or ops)begin
		case(ops)
			6'b000000:               //add
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 1;
				InsMemRW = 1;
				mRD = 0;
				mWR = 0;
				RegDst  = 1;
				ExtSel = 0;
				PCSrc = 00;
				ALUop = 000;
			end
			6'b000001:               //addi
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 1;
				DBDataSrc = 0;
				RegWre = 1;
				InsMemRW = 1;
				mRD = 0;
				mWR = 0;
				RegDst  = 0;
				ExtSel = 1;
				PCSrc = 00;
				ALUop = 000;
			end
			6'b000010:               //sub
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 1;
				InsMemRW 1;
				mRD = 0;
				mWR = 0;
				RegDst  = 1;
				ExtSel = 0;
				PCSrc = 00;
				ALUop = 001;
			end
			6'b010000:               //ori
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 1;
				DBDataSrc = 0;
				RegWre = 1;
				InsMemRW = 1;
				mRD = 0;
				mWR = 0;
				RegDst  = 0;
				ExtSel = 0;
				PCSrc = 00;
				ALUop = 011;
			end
			6'b010001:               //and
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 1;
				InsMemRW = 1;
				mRD = 0;
				mWR = 0;
				RegDst  = 1;
				ExtSel = 0;
				PCSrc = 00;
				ALUop = 100;
			end
			6'b010010:               //or
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 1;
				InsMemRW = 1;
				mRD = 0;
				mWR = 0;
				RegDst  = 1;
				ExtSel = 0;
				PCSrc = 00;
				ALUop = 011;
			end
			6'b011000:               //sll
			begin
				PCWre = 1;
				ALUSrcA = 1;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 1;
				InsMemRW = 1;
				mRD = 0;
				mWR = 0;
				RegDst  = 1;
				ExtSel = 1;
				PCSrc = 00;
				ALUop = 010;
			end
			6'b011011:               //slti
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 1;
				DBDataSrc = 0;
				RegWre = 1;
				InsMemRW = 1;
				mRD = 0;
				mWR = 0;
				RegDst  = 1;
				ExtSel = 1;
				PCSrc = 00;
				ALUop = 101;
			end
			6'b100110:               //sw
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 1;
				DBDataSrc = 0;
				RegWre = 0;
				InsMemRW = 1;
				mRD = 0;
				mWR = 1;
				RegDst  = 0;  ?
				ExtSel = 1;
				PCSrc = 00;
				ALUop = 000;
			end
			6'b100111:               //lw 
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 1;
				DBDataSrc = 1;
				RegWre = 1;
				InsMemRW = 1;
				mRD = 1;
				mWR = 0;
				RegDst  = 0;
				ExtSel = 1;
				PCSrc = 00;
				ALUop = 100;
			end
			6'b110000:               //beq
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 0;
				InsMemRW = 1;
				mRD = 0;
				mWR = 0;
				RegDst  = 1;
				ExtSel = 1;
				if(zero == 0)
					PCSrc = 00;
				else if(zero == 1)
					PCSrc = 01;
				ALUop = 101;
			end
			6'b110001:               //bne
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 0;
				InsMemRW = 1;
				mRD = 0;
				mWR = 0;
				RegDst = 1;
				ExtSel = 1;
				if(zero == 1)
					PCSrc = 00;
				else if(zero == 1)
					PCSrc = 00;
				ALUop = 100;
			end
			6'b111000:               //j
			begin
				PCWre = 1;
				ALUSrcA = 0;
				ALUSrcB = 0;
				DBDataSrc = 0;
				RegWre = 0;
				InsMemRW = 1;
				mRD = 0;
				mWR = 0;
				RegDst  = 1;
				ExtSel = 1;
				PCSrc = 10;		ALUop = 101;
			end
			6'b111111:               //halt
			begin
				PCWre = 0;
			end
	end



endmodule