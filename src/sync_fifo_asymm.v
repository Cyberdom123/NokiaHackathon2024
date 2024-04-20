`timescale 1 ns / 1 ps


module sync_fifo_asymm #
(
  parameter FIFO_DIN_WIDTH  = 32,
  parameter FIFO_DOUT_WIDTH = 32,
  parameter FIFO_DEPTH      = 32
)
(
  input clk,
  input resetn,
  input rd_en,
  input wr_en,
  input  [FIFO_DIN_WIDTH-1:0]  din,
  output [FIFO_DOUT_WIDTH-1:0] dout,
  output empty,
  output full,
  output almost_empty,
  output almost_full,
  output prog_full
);

reg reset;

always@(posedge clk) begin
  reset <= ~resetn;
end

// xpm_fifo_sync: Synchronous FIFO
// Xilinx Parameterized Macro, version 2023.2

// USE_ADV_FEATURES[0]  to 1 enables overflow
// USE_ADV_FEATURES[1]  to 1 enables prog_full
// USE_ADV_FEATURES[2]  to 1 enables wr_data_count
// USE_ADV_FEATURES[3]  to 1 enables almost_full
// USE_ADV_FEATURES[4]  to 1 enables wr_ack
// USE_ADV_FEATURES[8]  to 1 enables underflow
// USE_ADV_FEATURES[9]  to 1 enables prog_empty
// USE_ADV_FEATURES[10] to 1 enables rd_data_count
// USE_ADV_FEATURES[11] to 1 enables almost_empty
// USE_ADV_FEATURES[12] to 1 enables data_valid
xpm_fifo_sync #(
  .CASCADE_HEIGHT(0),                // DECIMAL
  .DOUT_RESET_VALUE("0"),            // String
  .ECC_MODE("no_ecc"),               // String
  .FIFO_MEMORY_TYPE("ultra"),        // String
  .FIFO_READ_LATENCY(1),             // DECIMAL
  .FIFO_WRITE_DEPTH(FIFO_DEPTH),     // DECIMAL
  .FULL_RESET_VALUE(0),              // DECIMAL
  .PROG_EMPTY_THRESH(3),             // DECIMAL
  .PROG_FULL_THRESH(FIFO_DEPTH-6),   // DECIMAL
  .RD_DATA_COUNT_WIDTH(1),           // DECIMAL
  .READ_DATA_WIDTH(FIFO_DOUT_WIDTH), // DECIMAL
  .READ_MODE("std"),                 // String
  .SIM_ASSERT_CHK(0),                // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
  .USE_ADV_FEATURES("080A"),         // String 0000_1000_0000_1010
  .WAKEUP_TIME(0),                   // DECIMAL
  .WRITE_DATA_WIDTH(FIFO_DIN_WIDTH), // DECIMAL
  .WR_DATA_COUNT_WIDTH(1)            // DECIMAL
)
xpm_fifo_sync_inst (
  .almost_empty(almost_empty),   // 1-bit output: Almost Empty : When asserted, this signal indicates that
                                 // only one more read can be performed before the FIFO goes to empty.

  .almost_full(almost_full),     // 1-bit output: Almost Full: When asserted, this signal indicates that
                                  // only one more write can be performed before the FIFO is full.

  .data_valid(data_valid),       // 1-bit output: Read Data Valid: When asserted, this signal indicates
                                  // that valid data is available on the output bus (dout).

  .dbiterr(),             // 1-bit output: Double Bit Error: Indicates that the ECC decoder detected
                                  // a double-bit error and data in the FIFO core is corrupted.

  .dout(dout),                   // READ_DATA_WIDTH-bit output: Read Data: The output data bus is driven
                                  // when reading the FIFO.

  .empty(empty),                 // 1-bit output: Empty Flag: When asserted, this signal indicates that the
                                  // FIFO is empty. Read requests are ignored when the FIFO is empty,
                                  // initiating a read while empty is not destructive to the FIFO.

  .full(full),                   // 1-bit output: Full Flag: When asserted, this signal indicates that the
                                  // FIFO is full. Write requests are ignored when the FIFO is full,
                                  // initiating a write when the FIFO is full is not destructive to the
                                  // contents of the FIFO.

  .overflow(),           // 1-bit output: Overflow: This signal indicates that a write request
                                  // (wren) during the prior clock cycle was rejected, because the FIFO is
                                  // full. Overflowing the FIFO is not destructive to the contents of the
                                  // FIFO.

  .prog_empty(),                  // 1-bit output: Programmable Empty: This signal is asserted when the
                                  // number of words in the FIFO is less than or equal to the programmable
                                  // empty threshold value. It is de-asserted when the number of words in
                                  // the FIFO exceeds the programmable empty threshold value.

  .prog_full(prog_full),         // 1-bit output: Programmable Full: This signal is asserted when the
                                  // number of words in the FIFO is greater than or equal to the
                                  // programmable full threshold value. It is de-asserted when the number of
                                  // words in the FIFO is less than the programmable full threshold value.

  .rd_data_count(), // RD_DATA_COUNT_WIDTH-bit output: Read Data Count: This bus indicates the
                                  // number of words read from the FIFO.

  .rd_rst_busy(),     // 1-bit output: Read Reset Busy: Active-High indicator that the FIFO read
                                  // domain is currently in a reset state.

  .sbiterr(),                    // 1-bit output: Single Bit Error: Indicates that the ECC decoder detected
                                  // and fixed a single-bit error.

  .underflow(),                  // 1-bit output: Underflow: Indicates that the read request (rd_en) during
                                  // the previous clock cycle was rejected because the FIFO is empty. Under
                                  // flowing the FIFO is not destructive to the FIFO.

  .wr_ack(),               // 1-bit output: Write Acknowledge: This signal indicates that a write
                                  // request (wr_en) during the prior clock cycle is succeeded.

  .wr_data_count(), // WR_DATA_COUNT_WIDTH-bit output: Write Data Count: This bus indicates
                                  // the number of words written into the FIFO.

  .wr_rst_busy(),     // 1-bit output: Write Reset Busy: Active-High indicator that the FIFO
                                  // write domain is currently in a reset state.

  .din(din),                     // WRITE_DATA_WIDTH-bit input: Write Data: The input data bus used when
                                  // writing the FIFO.

  .injectdbiterr(1'b0),          // 1-bit input: Double Bit Error Injection: Injects a double bit error if
                                  // the ECC feature is used on block RAMs or UltraRAM macros.

  .injectsbiterr(1'b0),          // 1-bit input: Single Bit Error Injection: Injects a single bit error if
                                  // the ECC feature is used on block RAMs or UltraRAM macros.

  .rd_en(rd_en),                 // 1-bit input: Read Enable: If the FIFO is not empty, asserting this
                                  // signal causes data (on dout) to be read from the FIFO. Must be held
                                  // active-low when rd_rst_busy is active high.

  .rst(reset),                   // 1-bit input: Reset: Must be synchronous to wr_clk. The clock(s) can be
                                  // unstable at the time of applying reset, but reset must be released only
                                  // after the clock(s) is/are stable.

  .sleep(1'b0),                  // 1-bit input: Dynamic power saving- If sleep is High, the memory/fifo
                                  // block is in power saving mode.

  .wr_clk(clk),                  // 1-bit input: Write clock: Used for write operation. wr_clk must be a
                                  // free running clock.

  .wr_en(wr_en)                  // 1-bit input: Write Enable: If the FIFO is not full, asserting this
                                  // signal causes data (on din) to be written to the FIFO Must be held
                                  // active-low when rst or wr_rst_busy or rd_rst_busy is active high
);

// End of xpm_fifo_sync_inst instantiation

endmodule
