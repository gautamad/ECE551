module add4bit(A, B, cin, Sum, co);
    input [3:0] A, B;
    input cin;
    output wire [3:0] Sum;
    output wire co;
    
    assign {co, Sum} = A + B + cin;
endmodule


module add4bit_tb();
    reg [4:0] A,B,Cin;
    wire [3:0] sum;
    wire Cout;
    
    reg [4:0] cal_sum;
    add4bit A0(.A(A), .B(B), .cin(Cin), .Sum(sum), .co(Cout)); 
    
    initial begin
        for(Cin =0; Cin<2;Cin=Cin+1) begin 
           for(A=0;A<16;A = A + 1) begin
               for(B=0;B<16;B = B + 1) begin
                   #5;
                    cal_sum = A + B + Cin;
                    if(sum != cal_sum[3:0] || Cout != cal_sum[4]) begin
                       $display("Failed: Sum = %b, cal_sum = %b", sum[3:0], cal_sum[3:0]);
                       $stop;
                   end      
               end
           end
       end
       $display("Test Passed");
   end
endmodule
           