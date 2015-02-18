module reset_synch(RST_n, clk, rst_n);
    
    input RST_n, clk;
    output reg rst_n;
    
    reg q0;
    always @(negedge clk, negedge RST_n) begin
        if(RST_n == 1'b0) begin
           q0 <= 1'b0;
           rst_n <= q0;
        end
       
        else begin
           q0 <= 1'b1;
           rst_n <= q0;
        end
    end
endmodule