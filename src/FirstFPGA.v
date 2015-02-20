module FirstFPGA(clk, RST_n, LEDs);

	input clk, RST_n;

	output [7:0] LEDs;
	
	wire rst_n;
	wire [21:0] count;
	
	assign LEDs = count[21:14];
	
	reset_synch rstsync(.RST_n(RST_n), .clk(clk), .rst_n(rst_n));
	
	simple_cnt  counter(.rst_n(rst_n), .clk(clk), .count(count));
	 
endmodule
	