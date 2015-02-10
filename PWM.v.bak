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
	else if (count < duty) begin
	   PWM_sig = 1;
	   count = count + 1;
	end
	else begin
	   PWM_sig = 0; 
	   count = count + 1;
	end
 end
endmodule
	           
         
