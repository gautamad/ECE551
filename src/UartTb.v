module UART_rx_tb();

  wire TX, tx_done;		// Outputs from Transmitter
  wire rdy;			// Output from Receiver
  wire [7:0]cmd;		// Output command from the receiver

  reg clk, rst_n;		// Clock and async reset
  reg trmt;			// Input to transmitter
  reg [7:0]tx_data;		// Input to transmitter- Byte to transmit
  reg clr_rdy;			// Input to receiver

  reg [7:0]input_vectors[0:15];	// Input test vectors
  reg [4:0]input_ptr;		// Pointer to test vector


  // Instantiate the transmitter
  UartTx iUart_Tx(.TX(TX), .tx_done(tx_done), .clk(clk), .rst_n(rst_n), .trmt(trmt), .tx_data(tx_data));
  // Instantiate the Receiver
  UartRx iUART_rcv(.rdy(rdy), .cmd(cmd), .clk(clk), .rst_n(rst_n), .RX(TX), .clr_rdy(clr_rdy)); 

  // Forever clk toggling
  initial begin
    clk = 0;
    forever #5 clk = !clk;
  end

  // Test bench initial block
  initial begin  
    rst_n = 0;
    trmt =0;
    
    // Initialize the test vectors and pointer
    input_ptr = 4'b0000;
    input_vectors[0] = 8'h01;
    input_vectors[1] = 8'hFF;
    input_vectors[2] = 8'hA0;
    input_vectors[3] = 8'h02;
    input_vectors[4] = 8'h00;
    input_vectors[5] = 8'hEE;
    input_vectors[6] = 8'hAC;
    input_vectors[7] = 8'h0A;
    input_vectors[8] = 8'hD9;
    input_vectors[9] = 8'h99;
    input_vectors[10] = 8'h10; 
    input_vectors[11] = 8'hF0; 
    input_vectors[12] = 8'h0F; 
    input_vectors[13] = 8'hAA;
    input_vectors[14] = 8'h55;
    input_vectors[15] = 8'h88;


    @(posedge clk);
    @(negedge clk);

    rst_n =1;
     
    // Transmit and receive input vectors one by one
    for (input_ptr = 0; input_ptr < 2; input_ptr = input_ptr+1) begin
      clr_rdy =0;
      trmt = 1;
      tx_data = input_vectors[input_ptr];
      repeat (2) @(posedge clk);
      trmt =0;
  
      // When rdy is asserted, compare the received signal and transmitter input byte
      @(posedge rdy);
      if (cmd != input_vectors[input_ptr]) begin
        $display(" Transmitted and received values not matching!!cmd = %b, input_ptr = %d", cmd, input_ptr);
        $stop;
      end
      else
         $display("Pass, TX val = %x ::RX_val = %x", input_vectors[input_ptr], cmd);
      // Clear rdy. We already read the cmd byte
      //clr_rdy = 1;
      //@(posedge tx_done);
      repeat (10000) @(posedge clk);
    end

    $display("Test passed!!");
    $stop;
  end

endmodule
