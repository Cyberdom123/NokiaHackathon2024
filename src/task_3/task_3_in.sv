//============================================================================================================================
// TASK INPUT
// 
//============================================================================================================================
module task_3_in #(parameter WRITE_DATA_WIDTH = 8, parameter READ_DATA_WIDTH = 8, parameter NUM_WORDS = 243)
(i_clk, i_rst, i_tdata_valid, i_tdata, i_tdata_last, i_output_last, o_tready, o_data, o_enb);
//-----		INPUTS		------------------------------------------------------------------------------------------------------	
	input i_clk;
	input i_rst;
	input i_tdata_valid;
	input [WRITE_DATA_WIDTH-1:0] i_tdata;
	input i_tdata_last;
	input i_output_last;
//-----		OUTPUTS		------------------------------------------------------------------------------------------------------
	output o_tready;
	output [READ_DATA_WIDTH-1:0] o_data;
        output o_enb;
//-----		WIRES			------------------------------------------------------------------------------------------------------
   wire [WRITE_DATA_WIDTH-1:0] w_fifo_in;
	wire [READ_DATA_WIDTH-1:0] w_fifo_out;
	wire w_wrreq;
	wire w_rdreq;
	wire w_empty;
//-----		REGS			------------------------------------------------------------------------------------------------------
	reg r_tready = 0;
   reg r_rdreq_del = 0;
	reg r_first_flag = 1;
//-----     OTHERS      ------------------------------------------------------------------------------------------------------
   typedef enum {s_IDLE, s_START_REQ, s_LOAD, s_SEND} task_input_enum;		
	task_input_enum state = s_IDLE;
	task_input_enum next_state = s_IDLE;
	localparam NUM_WORDS_8BITS = NUM_WORDS*READ_DATA_WIDTH/8;
	
//============================================================================================================================
// 		   MODULE CONTENT		                                                                                               
//============================================================================================================================
 
 
//--------- NEXT STATE LOGIC  ------------------------------------------------------------------------------------------------	
	always @(*) begin
		if (i_rst) begin
			next_state = s_IDLE;
		end
		else begin
			case(state) 
				s_IDLE: begin
					if(w_empty && (r_first_flag || i_output_last))
						next_state = s_START_REQ;
					else if (!w_empty)
						next_state = s_SEND;
					else
						next_state = s_IDLE;
				end
				s_START_REQ: begin
					next_state = s_LOAD;			
				end
				s_LOAD: begin
					if(i_tdata_last)
						next_state = s_IDLE;
					else
						next_state = s_LOAD;
				end
				s_SEND: begin
					if(w_empty)
						next_state = s_IDLE;
					else
						next_state = s_SEND;		
				end
				default: begin
					next_state = s_IDLE;
				end
			endcase
		end
	end
//--------- UPDATING STATE    ------------------------------------------------------------------------------------------------ 
	always @(posedge i_clk)
		if (i_rst) begin
			state = s_IDLE;
		end
		else begin
		 state <= next_state;
		end
//--------- OUTPUT LOGIC      ------------------------------------------------------------------------------------------------
	always @(posedge i_clk)
		begin
			case (state) 
			  s_IDLE:
				 begin
					r_tready <= 1'b0;
				 end
			  s_START_REQ:
				 begin
					r_tready <= 1'b1;
				 end
			  s_LOAD:
				 begin
					if(i_tdata_last)
						r_tready <= 0;
				 end
			  s_SEND:
				 begin
					
				 end
			endcase
	end

	assign o_tready = r_tready;
	assign o_data = w_fifo_out;
	assign w_fifo_in = i_tdata;
   assign o_enb = w_rdreq && r_rdreq_del;
	assign w_wrreq = i_tdata_valid;
	assign w_rdreq = (state == s_SEND) ? 1'b1: 1'b0;

   always@(posedge i_clk)
		r_rdreq_del <= w_rdreq;

	always@(posedge i_clk) begin
		if (i_tdata_last)
			r_first_flag <= 0;
		
		if(i_output_last)
			r_first_flag <= 1;
	end

	/*my_fifo #(.DATA_WIDTH(READ_DATA_WIDTH), .NUM_WORDS(NUM_WORDS)) fifo_in (
		.clock ( i_clk ),
		.data ( w_fifo_in ),
		.rdreq ( w_rdreq ),
	   .sclr  ( i_rst ),
		.wrreq ( w_wrreq ),
		.empty ( w_empty),
		.almost_empty(),
		.almost_full(),
		.full ( ),
		.q ( w_fifo_out )
	);*/
	
 xpm_fifo_sync #(
      .CASCADE_HEIGHT(0),        // DECIMAL
      .DOUT_RESET_VALUE("0"),    // String
      .ECC_MODE("no_ecc"),       // String
      .FIFO_MEMORY_TYPE("auto"), // String
      .FIFO_READ_LATENCY(1),     // DECIMAL
      .FIFO_WRITE_DEPTH(512),   // DECIMAL
      .FULL_RESET_VALUE(0),      // DECIMAL
      .PROG_EMPTY_THRESH(10),    // DECIMAL
      .PROG_FULL_THRESH(10),     // DECIMAL
      .RD_DATA_COUNT_WIDTH(1),   // DECIMAL
      .READ_DATA_WIDTH(READ_DATA_WIDTH),      // DECIMAL
      .READ_MODE("std"),         // String
      .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      .USE_ADV_FEATURES("0707"), // String
      .WAKEUP_TIME(0),           // DECIMAL
      .WRITE_DATA_WIDTH(WRITE_DATA_WIDTH),     // DECIMAL
      .WR_DATA_COUNT_WIDTH(1)    // DECIMAL
   )
   fifo_in (
      .almost_empty(),   // 1-bit output: Almost Empty : When asserted, this signal indicates that
                                     // only one more read can be performed before the FIFO goes to empty.

      .almost_full(),     // 1-bit output: Almost Full: When asserted, this signal indicates that
                                     // only one more write can be performed before the FIFO is full.

      .data_valid(),       // 1-bit output: Read Data Valid: When asserted, this signal indicates
                                     // that valid data is available on the output bus (dout).

      .dbiterr(),             // 1-bit output: Double Bit Error: Indicates that the ECC decoder detected
                                     // a double-bit error and data in the FIFO core is corrupted.

      .dout(w_fifo_out),                   // READ_DATA_WIDTH-bit output: Read Data: The output data bus is driven
                                     // when reading the FIFO.

      .empty(w_empty),                 // 1-bit output: Empty Flag: When asserted, this signal indicates that the
                                     // FIFO is empty. Read requests are ignored when the FIFO is empty,
                                     // initiating a read while empty is not destructive to the FIFO.

      .full(),                   // 1-bit output: Full Flag: When asserted, this signal indicates that the
                                     // FIFO is full. Write requests are ignored when the FIFO is full,
                                     // initiating a write when the FIFO is full is not destructive to the
                                     // contents of the FIFO.

      .overflow(),           // 1-bit output: Overflow: This signal indicates that a write request
                                     // (wren) during the prior clock cycle was rejected, because the FIFO is
                                     // full. Overflowing the FIFO is not destructive to the contents of the
                                     // FIFO.

      .prog_empty(),       // 1-bit output: Programmable Empty: This signal is asserted when the
                                     // number of words in the FIFO is less than or equal to the programmable
                                     // empty threshold value. It is de-asserted when the number of words in
                                     // the FIFO exceeds the programmable empty threshold value.

      .prog_full(),         // 1-bit output: Programmable Full: This signal is asserted when the
                                     // number of words in the FIFO is greater than or equal to the
                                     // programmable full threshold value. It is de-asserted when the number of
                                     // words in the FIFO is less than the programmable full threshold value.

      .rd_data_count(), // RD_DATA_COUNT_WIDTH-bit output: Read Data Count: This bus indicates the
                                     // number of words read from the FIFO.

      .rd_rst_busy(),     // 1-bit output: Read Reset Busy: Active-High indicator that the FIFO read
                                     // domain is currently in a reset state.

      .sbiterr(),             // 1-bit output: Single Bit Error: Indicates that the ECC decoder detected
                                     // and fixed a single-bit error.

      .underflow(),         // 1-bit output: Underflow: Indicates that the read request (rd_en) during
                                     // the previous clock cycle was rejected because the FIFO is empty. Under
                                     // flowing the FIFO is not destructive to the FIFO.

      .wr_ack(),               // 1-bit output: Write Acknowledge: This signal indicates that a write
                                     // request (wr_en) during the prior clock cycle is succeeded.

      .wr_data_count(), // WR_DATA_COUNT_WIDTH-bit output: Write Data Count: This bus indicates
                                     // the number of words written into the FIFO.

      .wr_rst_busy(),     // 1-bit output: Write Reset Busy: Active-High indicator that the FIFO
                                     // write domain is currently in a reset state.

      .din(w_fifo_in),                     // WRITE_DATA_WIDTH-bit input: Write Data: The input data bus used when
                                     // writing the FIFO.

      .injectdbiterr(1'b0), // 1-bit input: Double Bit Error Injection: Injects a double bit error if
                                     // the ECC feature is used on block RAMs or UltraRAM macros.

      .injectsbiterr(1'b0), // 1-bit input: Single Bit Error Injection: Injects a single bit error if
                                     // the ECC feature is used on block RAMs or UltraRAM macros.

      .rd_en(w_rdreq),                 // 1-bit input: Read Enable: If the FIFO is not empty, asserting this
                                     // signal causes data (on dout) to be read from the FIFO. Must be held
                                     // active-low when rd_rst_busy is active high.

      .rst(i_rst),                     // 1-bit input: Reset: Must be synchronous to wr_clk. The clock(s) can be
                                     // unstable at the time of applying reset, but reset must be released only
                                     // after the clock(s) is/are stable.

      .sleep(1'b0),                 // 1-bit input: Dynamic power saving- If sleep is High, the memory/fifo
                                     // block is in power saving mode.

      .wr_clk(i_clk),               // 1-bit input: Write clock: Used for write operation. wr_clk must be a
                                     // free running clock.

      .wr_en(w_wrreq)                  // 1-bit input: Write Enable: If the FIFO is not full, asserting this
                                     // signal causes data (on din) to be written to the FIFO Must be held
                                     // active-low when rst or wr_rst_busy or rd_rst_busy is active high

   );	
endmodule 
