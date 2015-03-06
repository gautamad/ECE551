module UartTx(clk, rst_n, TX, trmt, tx_data, tx_done);
	input clk;
	input rst_n;
	input [7:0] tx_data;
	
	output TX;
	output tx_done;
		
endmodule


