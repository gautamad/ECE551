module simple_cnt(rst_n, clk, count);

	parameter SIZE = 12; // Counter size
	
	input rst_n, clk;
	output reg [SIZE-1:0] count;

	always @(posedge clk, negedge rst_n) begin
		if(rst_n == 1'b0) begin
			count <= 0;
		end
		else begin
			count <= count + 1;
		end
	end
endmodule	
	
