module simple_cnt(rst_n, clk, LED);
	input rst_n, clk;
	output [7:0] LED;
	reg [21:0] count;
	assign LED = count[21:14];

	always @(posedge clk, negedge rst_n) begin
		if(rst_n == 1'b0) begin
			count <= 22'b0;
		end
		else begin
			count <= count + 1;
		end
	end
endmodule	
	
