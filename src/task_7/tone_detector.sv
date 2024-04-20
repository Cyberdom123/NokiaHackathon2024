`timescale 1 ns / 1 ns
//----------------------------------------------------------------------------------------
// TASK 8: Goertzel 
// 
//----------------------------------------------------------------------------------------

module tone_detector
#(  parameter DATA_WIDTH_IN = 16,
    parameter DATA_WIDTH_OUT = 8
)(  input logic i_clk,
    input logic i_rst,
    input logic i_valid,
    input logic signed [DATA_WIDTH_IN-1:0] i_data,
    output logic o_valid,
    output logic [DATA_WIDTH_OUT-1:0] o_data);

  
    always @(posedge i_clk) begin
        o_data <= 1;		// Just a dummy assignement. Replace with your code.
        o_valid <= i_valid;	// Just a dummy assignement. Replace with your code.
    end
    
endmodule 
