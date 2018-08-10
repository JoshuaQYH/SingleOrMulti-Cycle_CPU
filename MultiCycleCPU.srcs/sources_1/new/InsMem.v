`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 09:56:09
// Design Name: 
// Module Name: InsMem
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


module InsMem(
 InsMemRW,  CurrentAddress,  IDataOut
);
     input InsMemRW; 
     input wire [31:0] CurrentAddress; 
     output reg [31:0] IDataOut;
     reg [7:0] mem[127:0];   // 指令存储器单元的定义，128个单元每个单元长度为8
     
  initial begin 
             {mem[0], mem[1], mem[2], mem[3]} = 32'b00001000000000010000000000001000;
             {mem[4], mem[5], mem[6], mem[7]} = 32'b01001000000000100000000000000010;
             {mem[8], mem[9], mem[10], mem[11]} = 32'b01000000010000010001100000000000;
             {mem[12], mem[13], mem[14], mem[15]} = 32'b00000100011000010010000000000000;
             {mem[16], mem[17], mem[18], mem[19]} = 32'b01000100100000100010100000000000;
             {mem[20], mem[21], mem[22], mem[23]} = 32'b01100000000001010010100010000000;
             {mem[24], mem[25], mem[26], mem[27]} = 32'b11010000101000011111111111111110;
             {mem[28], mem[29], mem[30], mem[31]} = 32'b11101000000000000000000000010000;
             {mem[32], mem[33], mem[34], mem[35]} = 32'b10011001100000010100000000000000;
             {mem[36], mem[37], mem[38], mem[39]} = 32'b00001000000011011111111111111110;
             {mem[40], mem[41], mem[42], mem[43]} = 32'b10011001000011010100100000000000;
             {mem[44], mem[45], mem[46], mem[47]} = 32'b10011101001010100000000000000010;
             {mem[48], mem[49], mem[50], mem[51]} = 32'b10011101010010110000000000000000;
             {mem[52], mem[53], mem[54], mem[55]} = 32'b00001001101011010000000000000001;
             {mem[56], mem[57], mem[58], mem[59]} = 32'b11011001101000001111111111111110;
             {mem[60], mem[61], mem[62], mem[63]} = 32'b11100000000000000000000000010011;
             {mem[64], mem[65], mem[66], mem[67]} = 32'b11000000001000100000000000000100;
             {mem[68], mem[69], mem[70], mem[71]} = 32'b11000100001011000000000000000100;
             {mem[72], mem[73], mem[74], mem[75]} = 32'b11100111111000000000000000000000;
             {mem[76], mem[77], mem[78], mem[79]} = 32'b11111100000000000000000000000000;                             
        end
     
     //当前指令地址进入，和读取信号
         always @( InsMemRW or CurrentAddress ) begin
             if (InsMemRW==1) begin // 为1，读存储器。大端数据存储模式
                 IDataOut[31:24] = mem[CurrentAddress];
                 IDataOut[23:16] = mem[CurrentAddress+1];
                 IDataOut[15:8] = mem[CurrentAddress+2];
                 IDataOut[7:0] = mem[CurrentAddress+3];
             end
         end
endmodule
