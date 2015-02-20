module simple_cnt(rst_n, clk, count);
	input rst_n, clk;
	output reg [21:0] count;

	always @(posedge clk, negedge rst_n) begin
		if(rst_n == 1'b0) begin
			count <= 22'b0;
		end
		else begin
			count <= count + 1;
		end
	end
endmodule	
	
