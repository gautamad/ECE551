module button_smpl(clk, preset_n, next_byte, button_rise_edge);

input clk;
input preset_n;
input next_byte;

output button_rise_edge;

reg q0, q1, q2;

assign button_rise_edge = (~q2 & q1);

always_ff @(negedge clk, negedge preset_n) begin
	if(!preset_n) begin
		q0 <= 1;
		q1 <= 1;
		q2 <= 1;
	end
	else begin
		q0 <= next_byte;
		q1 <= q0;
		q2 <= q1;
	end
end
endmodule