`timescale 1 ns / 1 ns
//----------------------------------------------------------------------------------------
// TASK 11: Phase detector
// 
//----------------------------------------------------------------------------------------

module phase_detector(i_clk, i_clk_1, i_clk_2, clk_sampl, i_rstn, o_out, o_valid);

    input i_clk, i_clk_1, i_clk_2, clk_sampl, i_rstn;
    output logic [9:0] o_out;
    output logic o_valid;
    always @(posedge i_clk) begin
        o_out <= i_clk_1 ^ i_clk_2 + i_clk_2;		// Just a dummy assignement. Replace with your code.
        o_valid <= i_clk_1 || i_clk_2;		// Just a dummy assignement. Replace with your code.
    end
endmodule 
