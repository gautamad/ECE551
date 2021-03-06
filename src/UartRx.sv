module UartRx(rdy, cmd, clr_rdy, clk, rst_n, RX);

	input RX;
	input clr_rdy;

	input clk;
	input rst_n;

	output reg rdy;
	output [7:0] cmd;
	
	reg [3:0] bit_cnt;
	reg [11:0] baud_cnt;
	reg [8:0] rx_shft_reg;
	reg iRX,fRX;
	reg load;
	reg recving;

	wire [3:0] bit_cnt_val;
	wire [11:0] baud_cnt_val;
	wire [8:0] rx_shft_reg_val;
	wire shift;

	logic rdy_sig;

	// State assignment
	typedef enum reg[1:0]{IDLE, LOAD, RCVING, CLEAR} state_t;
	
	state_t state, next_state;
	
	// Double flop RX for metastaility issues
	
	always_ff @(posedge clk) begin
	  iRX <= RX;
	  fRX <= iRX;
	end

	// Bit count increment logic
	assign bit_cnt_val = (load)? 4'b0000: (shift)? bit_cnt + 1: bit_cnt;
	
	// Baud count increment logic
	assign baud_cnt_val = (load)? 12'hF42: (recving)? baud_cnt - 1: baud_cnt;
	
	// Recevied data buffer (Shift register)
	assign rx_shft_reg_val = (load)? 9'h00: (shift)? {fRX, rx_shft_reg[8:1]} : rx_shft_reg;
	
	// Shift wire
	assign shift = recving & (~|baud_cnt);
	
	// Final data received 
	assign cmd = rx_shft_reg[7:0];

	// State machine initialization and assignment
	always_ff @(posedge clk, negedge rst_n) begin
		if(!rst_n) begin
		   bit_cnt <= 4'b0000;
		   baud_cnt <= 12'hF42;
		   rx_shft_reg <= 8'h00;
		   state <= IDLE;
		   rdy <= 0;
		end
		else begin
		   bit_cnt <= bit_cnt_val;
		   baud_cnt <= (shift) ? 12'hA2C: baud_cnt_val;
		   rx_shft_reg <= rx_shft_reg_val;	
		   state <= next_state;
		   rdy <= rdy_sig;
		end
	end
	
	// Next state and output logic
	always_comb begin
		load = 0;
		recving = 0;
		rdy_sig = 0;
		case(state) 
		IDLE: begin
			 if(!fRX) 
			  next_state = LOAD;
			 else
			  next_state = state;
		end
		
		LOAD: begin
			  load = 1;
			  next_state = RCVING;
		end
		
		RCVING: begin
				recving = 1;
			if(bit_cnt == 9) begin	
			   rdy_sig = 1;
			   next_state = CLEAR;
				end
				else
			   next_state = RCVING;	
		end
		
		CLEAR: begin
			if(clr_rdy | !fRX) begin
			  rdy_sig = 0;
			  next_state = IDLE;
			end
			else begin
			  rdy_sig = 1;
			  next_state = CLEAR;
		   end
		end

		default: next_state = IDLE;

		endcase
	end

endmodule