module Barcode_test(clk,RST_n,next_byte,LEDs);

input clk,RST_n;	// 50MHz clock & unsynched active low reset from push button
input next_byte;	// active low unsynched push button to send next byte over UART

output [7:0] LEDs;	// received byte of LEDs will be displayed over LEDs

reg [7:0] count;

wire BC, send_next;
wire rst_n;
wire [7:0] ID;
//wire [7:0] station_ID_val;
//wire [21:0] period_val;
 
reg [7:0] station_ID;
reg [21:0] period;

assign LEDs = ID;

//// Instantiate reset synchronizer ////
reset_synch iRST(.clk(clk), .RST_n(RST_n), .rst_n(rst_n));

//// Make or instantiate a push button release detector /////
button_smpl iButton_smpl(.clk(clk), .preset_n(rst_n), .next_byte(next_byte), .button_rise_edge(send_next));

//// Instantiate your Barcode module ////
barcode BCR1(.ID(ID), .BC(BC), .clk(clk), .rst_n(rst_n));
 
 
//// Instantiate your barcode mimic module ////
barcode_mimic BCM1(.clk(clk), .rst_n(rst_n), .period(period), .send(send_next), .station_ID(station_ID), .BC(BC));

//// Make or instantiate an 8-bit counter to provide data to test with /////


always @(posedge send_next, negedge rst_n) begin
	if(!rst_n) begin
		station_ID = 8'b0;
		period = 22'b0;
	end
	else begin
		station_ID = 8'h55;
		period = 22'hC00;
	end

end
endmodule
