module PWM(clk, rst_n, duty, PWM_sig);
    input clk, rst_n;
    input [9:0] duty;
    output reg PWM_sig;
    
    reg [9:0] count;
 
    always @(posedge clk, negedge rst_n) begin
	if(!rst_n) 
	    count <= 0;
	else 
	    count <= count + 1;
    end
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
           PWM_sig <=  0;
	else if (count <= duty)
	   PWM_sig <= 1;
	else
	   PWM_sig <= 0;
 end
endmodule
	           
         
module PWM_tb();
     reg [9:0] duty;
     reg clk, rst_n;
     wire PWM_sig;

PWM DUT_PWM(.duty(duty), .clk(clk), .rst_n(rst_n), .PWM_sig(PWM_sig));

        initial begin
	  #0 clk = 0;
	  #0 rst_n = 0;
	  #14 rst_n = 1;
	  #15 duty = 100; 	
	end
	
	always @(clk)
	  clk <= #5 ~clk;
endmodule	