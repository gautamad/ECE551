module UartTx(clk, rst_n, TX, trmt, tx_data, tx_done);
	input clk;
	input rst_n;
	input [7:0] tx_data;
	
	output TX;
	output tx_done;
	
	parameter S0 = 2'b00, S1 = 2'b01 , S2 = 2'b10, S3 = 2'b11;
	
	reg [1:0] state, next_state;
		
	always @(posedge clk, negedge rst_n) begin
		if(rst_n)	
			state <= S0; 	
		else
			state <= next_state;
	end
	
	always @(state) begin
		case(state)
			S0: begin
				if(!rst_n)
					state = S0;
				else if(trmt)
					state = S1;
				else
					state = state;
			end
			S1: begin
								
	end
		
endmodule


module baud_counter(load, transmitting, shift, clk)
	input load;
	input transmitting;
	input clk;
	
	output shift;
	
	reg count;
	
	simple_cnt #(SIZE=12) (.clk(clk), .rst_n(.rst_n), .count(count));
	
	always(count, load,) begin
		if(load == 1)
			rst_n = 1;
		else if(count == 2604)
			shift = 1;
		else 
			shift = 0;
	end

endmodule

module bit_counter(load, shift, clk, rst_n, bit_cnt);

	input load;
	input shift;
	input clk;
	input rst_n;
	
	output reg [3:0] bit_cnt;
	
	always @(posedge clk) begin
		if(load)
			bit_cnt = 0;
		else if(shift == 1)
			bit_cnt = bit_cnt + 1;
		else
			bit_cnt = bit_cnt;
	end
	
endmodule
	