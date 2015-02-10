
module add8bit_tb();

reg [7:0] a,b;
reg cin;

wire [7:0] sum;
wire cout,overflow;


add8bit DUT(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout), .overflow(overflow));

initial begin
	a = 8'hA5;
	b = 8'h59;
	cin = 0;
	$strobe("sum = %h", sum);
	#5;
end

endmodule

