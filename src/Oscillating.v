module osc(en, out);
    input en;
    output out;
    
    wire w1,w2;
    
    nand #5 n0(w1, en, out);
    not #5 n1(w2, w1);
    not #5 n2(out, w2);
    
endmodule


module osc_tb();
    
    reg en;
    wire out;
    
    osc o1(.en(en), .out(out));
    
    initial begin
        #0 en = 0;
        #15 en = 1;
        #5;
    end
endmodule