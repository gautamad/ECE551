module motor_driver(clk, rst_n, lft, rht, fwd_lft, rev_lft, fwd_rht, rev_rht);
	
	input clk, rst_n;
	input [10:0] lft, rht;
	
	output wire fwd_lft, rev_lft, fwd_rht, rev_rht;
	
	wire [9:0] mag_lft, mag_rht;
	wire PWM_left, PWM_right;

	assign mag_lft = lft[9:0];
	assign mag_rht = rht[9:0];
	
	PWM pwm_lft(.clk(clk), .rst_n(rst_n), .duty(mag_lft), .PWM_sig(PWM_left));
	PWM pwm_rht(.clk(clk), .rst_n(rst_n), .duty(mag_rht), .PWM_sig(PWM_right));
	
	assign fwd_lft = lft[10] ? 0 : PWM_left;
	assign fwd_rht = lft[10] ? PWM_left : 0;         // Optimize here for Area
		
	assign fwd_rht = rht[10] ? 0 : PWM_right;
	assign rev_rht = rht[10] ? PWM_right : 0;
	

endmodule

module moto_driver_tb();

	reg clk, rst_n;
	reg [10:0] lft, rht;

	wire fwd_lft, rev_lft, fwd_rht, rev_rht; 

motor_driver mtr_drv(.clk(clk), .rst_n(rst_n), .lft(lft), .rht(rht), .fwd_lft(fwd_lft), .rev_lft(rev_lft), .fwd_rht(fwd_rht), .rev_rht(rev_rht));

	initial begin
	#0 clk = 0;
	   rst_n = 0;
	#11 rst_n = 1;
	#2  lft = 1025;
	    rht = 2047;
	end

	always @(clk)
	clk <= #5 ~clk;

endmodule	 