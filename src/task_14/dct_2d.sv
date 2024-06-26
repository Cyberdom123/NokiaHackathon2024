`timescale 1 ns / 1 ns
//----------------------------------------------------------------------------------------
// TASK 14: DTC 2D
// 
//----------------------------------------------------------------------------------------
module dct_2d #(
    parameter DATA_WIDTH_IN = 8,
    parameter DATA_WIDTH_OUT = 16
)
(
        input i_clk,
        input i_rst,
        input i_valid,
        input [DATA_WIDTH_IN-1:0] i_data,
        output logic o_valid,
        output logic [DATA_WIDTH_OUT-1:0] o_data
    );

    always @(posedge i_clk) begin
        o_data <= {i_data, i_data};		// Just a dummy assignement. Replace with your code.
        o_valid <= i_valid;             // Just a dummy assignement. Replace with your code.
    end
    
endmodule

