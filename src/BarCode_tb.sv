`timescale 1ns/100ps
module BarCode_tb();
  
  logic clk,rst_n;			// clock and active low asynch reset
  logic [21:0] period;		// period used for transmission, can be a somewhat random #
  logic send;				// asserted for 1 clock to initiate a transmission
  logic [7:0] station_ID;	// code to transmit
  logic BC;			// serial barcode output
  logic BC_done;		// indicates when barcode tranmission is complete (useful for testbenches)
  logic  clr_ID_vld;                               //clear the ID_vld signal 
  logic [7:0] ID;                                 //8bit ID that will be read by the module
  logic ID_vld;                                   //Asserted if the ID receieved in valid.
  
  barcode BCR1(.ID(ID), .ID_vld(ID_vld), .BC(BC), .clr_ID_vld(clr_ID_vld), .clk(clk), .rst_n(rst_n));
  
  barcode_mimic BCM1(.clk(clk),.rst_n(rst_n),.period(period),.send(send),.station_ID(station_ID),.BC_done(BC_done),.BC(BC));
  
  initial begin
    clk = 0;
    rst_n=0;
    station_ID=8'h1A;
    send= 0;
    #10;
    rst_n=1;
    period=22'hC00;
    send =1;
    clr_ID_vld=0;
    #10;
    send =0;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////
    //TEST 1: Check for data reception
    //////////////////////////////////////////////////////////////////////////////////////////////////
    @(posedge BC_done);
    if(station_ID != ID) begin
        $display("Invalid ID");
        $stop;
    end
    else begin
        $display("Received the correct data");
    end
    if(ID_vld) 
    $display("ID_vld is asserting properly");
    //Knock down the valid signal.
    clr_ID_vld= 1;
    #10;
    if(ID_vld) begin
      $display("ID_vld is not knocked down by the clr_ID_vld signal");
      $stop;
    end
    else
      $display("ID_vld is knocked down. Good Work!!");
      
      
   ///////////////////////////////////////////////////////////////////////////////////////////////////  
   //Test 2: Change the data now. Check if the reader module is able to receive two data back to back.
   ///////////////////////////////////////////////////////////////////////////////////////////////////
   #10;
    station_ID=8'h3C;
    send= 1;
   #10;
    send= 0;
    clr_ID_vld=0;
   @(posedge BC_done);
   if(station_ID != ID) begin
     $display("Invalid ID");
     $stop;
   end
   else
     $display("Second Data also received correctly");
     
     
    ///////////////////////////////////////////////////////////////////////////////////
    //TEST 3: Without clearing the ID_vld, start transmitting the next byte. 
    //Also change the time period. Check for valid data.
    ///////////////////////////////////////////////////////////////////////////////////
    station_ID = 8'h2B;
    period = 22'hFFF;
    send = 1;
    #10;
    send = 0;
    @(posedge BC_done);
     if(station_ID != ID) begin
       $display("Invalid ID");
       $stop;
     end
     else
       $display("Third Data also received correctly");
     if(ID_vld == 0) begin
       @(posedge ID_vld);
     end
       clr_ID_vld = 1;
       #100;
     
     /////////////////////////////////////////////////////////////////////////////////
     //Test 4: check for metastality, See if the states are chaged.
     //For BC to be zero for two clock cycles. See if the state is changing.
     /////////////////////////////////////////////////////////////////////////////////
         
     force BCM1.BC=0;
     #8;
     release BCM1.BC;
     //repeat (10) @(posedge clk);
     if(BCR1.state != 3'h0) begin
       $display("Failed for a glitch. No wonder, you are the designer");
       $stop;
     end 
     $display("Passed Metastability Test");
     
     ///////////////////////////////////////////////////////////////////////////////////
     //Test 5: Make BC low for sometime and let it keep probing for the falling edge.
     //Check if it returns to zero.
     ////////////////////////////////////////////////////////////////////////////////////
     /*
     force BC= 0;  //Introducing glitch
     #20;
     release BC;
     #10;
     //@(posedge BCR1.SMPL_MAX_COUNT);
     #20;
     if(BCR1.state != 3'h0) begin
       $display("Failed to go back to IDLE state. Didn't you read the project spec??");
       $stop;
     end
       $display("Passed sample timer overflow test");
       */
     ////////////////////////////////////////////////////////////////////////////////////////
     // Test6: Check for data reception after a over flow has happened. This is to check any
     //flaws in the logic written for sample counter overflow.
     ////////////////////////////////////////////////////////////////////////////////////////
     station_ID = 8'h11;
     period = 22'hCFF;
     send = 1;
     #10;
     send = 0;
     clr_ID_vld = 0;
     @(posedge BC_done);
      if(station_ID != ID) begin
       $display("Invalid ID");
       $stop;
      end
      else
        $display("Data is received correctly after counter overflow test.");
      if(ID_vld == 0) begin
        @(posedge ID_vld);
      end
        $display("Clearing the ID_VLD");
        clr_ID_vld = 1;
        #10;
        
        
                   
      $display("All tests passed!! KUDOS!!");
      $stop;
    end
   always begin
     #2; clk= ~clk;
   end
endmodule