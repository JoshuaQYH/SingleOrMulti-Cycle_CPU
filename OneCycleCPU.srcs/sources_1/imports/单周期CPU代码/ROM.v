module ROM ( 
	rd, 
	addr, 
	dataOut
); // 指令存储器模�?

	input rd; // 读使能信�?
	input [31:0] addr; // 存储器地�? 32条指�?
	output reg [31:0] dataOut; // 输出的指�?
	reg [7:0] rom [127:0]; // 存储器定义必须用reg类型，存储器存储单元8位长度，�?100个存储单�?

	initial begin // 加载数据到存储器rom。注意：必须使用绝对路径，如：E:/Xlinx/VivadoProject/ROM/（自己定�?
		$readmemb ("E:/Xlinx/VivadoProject/ROM/rom_data.txt", rom); // 指令代码初始化到指令存储器，数据文件rom_data�?.coe�?.txt）�?�未指定，就�?0地址�?始存放�??
	end
	always @( rd or addr ) begin
		if (rd==0) begin // �?0，读存储器�?�大端数据存储模�?
			dataOut[31:24] = rom[addr];
			dataOut[23:16] = rom[addr+1];
			dataOut[15:8] = rom[addr+2];
			dataOut[7:0] = rom[addr+3];
		end
	end
endmodule
