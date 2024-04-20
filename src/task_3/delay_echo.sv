`timescale 1ns / 1ps
//----------------------------------------------------------------------------------------
// TASK 3: Echo 
// 
//----------------------------------------------------------------------------------------

module delay_echo #(
parameter DATA_WIDTH_IN = 32,
parameter DATA_WIDTH_OUT = 32
)(
        input i_clk,
        input i_rst,
        input i_valid,
        input [DATA_WIDTH_IN-1:0] i_data,
        output o_valid,
        output [DATA_WIDTH_OUT-1:0] o_data
    );

localparam DELAY_MAX = 100;

// Just a dummy assignement. Replace with your code.
reg [DATA_WIDTH_IN-1:0] r_data = 0; 			// Just a dummy assignement. Replace with your code.
reg r_valid = 0;					// Just a dummy assignement. Replace with your code.
   
always@(posedge i_clk) begin				// Just a dummy assignement. Replace with your code.
    if(i_rst)						// Just a dummy assignement. Replace with your code.
        r_data <= 0;					// Just a dummy assignement. Replace with your code.
    else						// Just a dummy assignement. Replace with your code.
        r_data <= i_data;				// Just a dummy assignement. Replace with your code.
end							// Just a dummy assignement. Replace with your code.

always@(posedge i_clk) begin				// Just a dummy assignement. Replace with your code.
    if(i_rst)						// Just a dummy assignement. Replace with your code.
        r_valid <= 0;					// Just a dummy assignement. Replace with your code.
    else						// Just a dummy assignement. Replace with your code.
        r_valid <= i_valid;				// Just a dummy assignement. Replace with your code.
end							// Just a dummy assignement. Replace with your code.

assign o_data = r_data; 				// Just a dummy assignement. Replace with your code.
assign o_valid = ~(r_valid ^ i_valid) && i_valid; 	// Just a dummy assignement. Replace with your code.

   
endmodule

