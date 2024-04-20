`timescale 1 ns / 1 ns
//----------------------------------------------------------------------------------------
// TASK 15: UFO
// 
//----------------------------------------------------------------------------------------
module UFO #(
    parameter DATA_WIDTH_IN = 17,
    parameter DATA_WIDTH_OUT = 64
)(
    input i_clk,
    input i_rst,
    input i_enb,
    input  [DATA_WIDTH_IN-1:0] i_data,
    output logic [DATA_WIDTH_OUT-1:0] o_data,
    output logic o_valid );
    
    always @(posedge i_clk) begin
      o_data <= {{8{i_data[16]}}, {i_data, {39{1'b0}}}};	// Just a dummy assignement. Replace with your code.
      o_valid <= i_enb;					// Just a dummy assignement. Replace with your code.
    end

endmodule 

