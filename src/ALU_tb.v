module ALU_tb();
	
	reg [2:0] src1sel, src0sel;
	reg [15:0] Accum, Pcomp;
	reg multiply, saturate, mult2, mult4, sub;
	wire [15:0] out;

	
	ALU inst1(.Accum(Accum), .Pcomp(Pcomp), .dst(out), .multiply(multiply),
			  .saturate(saturate), .src1sel(src1sel), .src0sel(src0sel),
			  .mult2(mult2), .mult4(mult4), .sub(sub));
	initial begin
	src1sel = 3'b000;
	src0sel = 3'b011;
	Accum = 16'h5fff;
	Pcomp = 16'h4fff;
	multiply = 1'b1;
	saturate = 1'b1;
	mult2 = 1'b0;
	mult4 = 1'b0;
	sub = 1'b0;
	#50
	src1sel = 3'b000;
	src0sel = 3'b011;
	Accum = 16'h358c;
	Pcomp = 16'hcedc;
	multiply = 1'b1;
	saturate = 1'b0;
	mult2 = 1'b0;
	mult4 = 1'b0;
	sub = 1'b0;
	end

endmodule
