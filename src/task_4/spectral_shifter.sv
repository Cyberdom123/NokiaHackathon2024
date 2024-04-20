`timescale 1ns / 1ps
//----------------------------------------------------------------------------------------
// TASK 4: Spectral shifter 
// 
//----------------------------------------------------------------------------------------
module spectral_shifter
(
	input i_clk,
    input i_rst,
	input signed [15:0] i_data,
	input i_valid,
	input i_switch,
	input [31:0] i_frequency,
	output logic signed [15:0] o_data,
    output logic o_valid
	
);

    always@(posedge i_clk) begin
        o_data <= i_data + i_frequency + i_switch;	// Just a dummy assignement. Replace with your code.
        o_valid <= i_valid;				// Just a dummy assignement. Replace with your code.
    end

endmodule

// Module instances to use:

//  nco_ii nco_ii(
//     .clk(),
//     .rst(),
//     .clken(),
//     .phase_incr_i(),
//     .cos_o(),
//     .sin_o(),
//     .out_valid()
//  );

//  hilbert_fir hilbert_fir (
//    .aclk(),                              
//    .s_axis_data_tvalid(),
//    .s_axis_data_tready(),
//    .s_axis_data_tdata(),
//    .m_axis_data_tvalid(),
//    .m_axis_data_tdata()
//  );

