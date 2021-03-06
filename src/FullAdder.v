module FA(a,b,cin,sum,cout);

input a,b,cin;
output sum, cout;
wire out1,out2,out3;

xor X0(sum,a,b,cin);
and A1(out1,a,b),
    A2(out2,b,cin),
    A3(out3,cin,a);

or  O0(cout,out1,out2,out3);

endmodule


module add8bit(cout,sum,overflow,a,b,cin);
    output [7:0] sum;
    output cout,overflow;
    input [7:0] a,b;
    input cin;
    
    wire cout0,cout1,cout2,cout3,cout4,cout5,cout6;
    
    FA A0(a[0],b[0],cin,sum[0],cout0);
    FA A1(a[1],b[1],cout0,sum[1],cout1);
    FA A2(a[2],b[2],cout1,sum[2],cout2);
    FA A3(a[3],b[3],cout2,sum[3],cout3);
    FA A4(a[4],b[4],cout3,sum[4],cout4);
    FA A5(a[5],b[5],cout4,sum[5],cout5);
    FA A6(a[6],b[6],cout5,sum[6],cout6);
    FA A7(a[7],b[7],cout6,sum[7],cout);
    
    xor X0(overflow,cout,cout6);
endmodule