module PWM(clk, rst_n, duty, PWM_sig);
    input clk, rst_n;
    input [9:0] duty;
    output reg PWM_sig;
    
    reg [9:0] count;
    always @(posedge clk) begin
        if(rst_n == 0) begin
	   count = 0;
           PWM_sig =  0;
	end
	else if (count <= duty) begin           // Can Optimize here for AREA
	   PWM_sig = 1;
	   count = count + 1;
	end
	else begin
	   PWM_sig = 0; 
	   count = count + 1;
	end
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
	  #15 duty = 1024; 	
	end
	
	always @(clk)
	  clk <= #5 ~clk;
endmodule	