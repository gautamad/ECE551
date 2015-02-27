module LEDBlinkFPGA(clk, RST_n, LEDs);

	input clk, RST_n;

	output [7:0] LEDs;
	
	wire rst_n;
	wire [27:0] count;
	wire PWM_sig; 
		
	assign LEDs[0] = (count[27:26] == 2'b00) ? 0: PWM_sig;
	assign LEDs[1] = (count[27:26] == 2'b00) ? 0: PWM_sig;
	assign LEDs[2] = (count[27:26] == 2'b00) ? 0: PWM_sig;
	assign LEDs[3] = (count[27:26] == 2'b00) ? 0: PWM_sig;
	assign LEDs[4] = (count[27:26] == 2'b11) ? 0: PWM_sig;
	assign LEDs[5] = (count[27:26] == 2'b11) ? 0: PWM_sig;
	assign LEDs[6] = (count[27:26] == 2'b11) ? 0: PWM_sig;
	assign LEDs[7] = (count[27:26] == 2'b11) ? 0: PWM_sig;

	
	reset_synch rstsync(.RST_n(RST_n), .clk(clk), .rst_n(rst_n));
	simple_cnt  counter(.rst_n(rst_n), .clk(clk), .count(count));
	
	PWM led_pwm(.clk(clk), .rst_n(rst_n), .duty(count[25:16]), .PWM_sig(PWM_sig));
 
endmodule
