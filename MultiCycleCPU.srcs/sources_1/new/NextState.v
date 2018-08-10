`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/17 16:57:01
// Design Name: 
// Module Name: NextState
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


module NextState(
InputState, opcode, OutputState
);
    input [5:0] opcode;
    output reg [2:0] OutputState;
    input [2:0] InputState;
    
   //     状态码
    parameter [2:0] StateIF = 3'b000;
    parameter [2:0] StateID = 3'b001 ;
    parameter [2:0] StateEXE = 3'b010; 
    parameter [2:0] StateWB = 3'b011;
    parameter [2:0] StateMEM = 3'b100;

    always @ (InputState or opcode)begin
        case (InputState)
            StateIF: OutputState = StateID;  //取指之后直接译码状态
            StateID: begin
                case (opcode[5:3])
                    3'b111: OutputState = StateIF; //  跳转指令译码之后直接跳转进入IF
                    default: OutputState = StateEXE;    // 其他指令进入执行阶段
                endcase                                
            end
            StateEXE:
                case(opcode[5:2])
                    4'b1101: OutputState = StateIF;   // beq bltz  to IF
                    4'b1100: OutputState = StateMEM;  // sw lw to MEM
                    default: OutputState = StateWB;   // to WB
                endcase
            StateMEM:
                    if(opcode == 6'b110000) OutputState = StateIF;     // sw
                    else OutputState = StateWB;     // lw    
            StateWB: OutputState = StateIF;   // to IF             
        endcase       
    end    
    
endmodule
