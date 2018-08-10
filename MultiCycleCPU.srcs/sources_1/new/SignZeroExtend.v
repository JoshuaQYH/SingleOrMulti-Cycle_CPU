`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 11:16:13
// Design Name: 
// Module Name: SignZeroExtend
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


module SignZeroExtend(
    ImmediateToExtend, ExtSel, ExtendedImmediate
);
    input wire[15:0] ImmediateToExtend;
    input ExtSel;
    output reg [31:0] ExtendedImmediate;
    	
    initial begin
        ExtendedImmediate = 0;  //初始化
    end

    always @ (ExtSel or  ImmediateToExtend)begin 
        if(ExtSel)begin  //符号位扩展
            ExtendedImmediate = {{16{ImmediateToExtend[15]}}, ImmediateToExtend[15:0]};
        end
        else begin     // 零位扩展
          ExtendedImmediate = {{16{1'b0}},ImmediateToExtend[15:0]};
        end
    end
endmodule
