module UART_test(clk,RST_n,next_byte,LEDs);

input clk,RST_n;	// 50MHz clock & unsynched active low reset from push button
input next_byte;	// active low unsynched push button to send next byte over UART

output [7:0] LEDs;	// received byte of LEDs will be displayed over LEDs

reg [7:0] count;

wire RX, send_next;
wire rst_n;

wire [7:0] cmd;

assign LEDs = cmd;

//// Instantiate reset synchronizer ////
reset_synch iRST(.clk(clk), .RST_n(RST_n), .rst_n(rst_n));

//// Make or instantiate a push button release detector /////
button_smpl iButton_smpl(.clk(clk), .preset_n(rst_n), .next_byte(next_byte), .button_rise_edge(send_next));

//// Instantiate your UART_tx...data to transmit comes from 8-bit counter ////
UartTx iUart_Tx(.TX(RX), .clk(clk), .rst_n(rst_n), .trmt(send_next), .tx_data(count));

//// Instantiate your UART_rx...output byte should be connected to LEDs[7:0] ////
UartRx iUART_rcv (.cmd(cmd), .clk(clk), .rst_n(rst_n), .RX(RX)); 

//// Make or instantiate an 8-bit counter to provide data to test with /////

always @(posedge clk, negedge	rst_n) begin
	if(!rst_n)
		count <= 8'h00;
	else if(send_next)
		count <= count + 1;
	else	
		count <= count;

end
endmodule
