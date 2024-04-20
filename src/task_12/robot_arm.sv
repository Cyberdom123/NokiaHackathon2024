`timescale 1 ps / 1 ps
//----------------------------------------------------------------------------------------
// TASK 12: Robot arm
// 
//----------------------------------------------------------------------------------------

module robot_arm #(
    parameter DATA_WIDTH_IN = 16,
    parameter DATA_WIDTH_OUT = 32	
)(
    input i_clk,
    input i_rst,
    input i_thi_valid,
    input [DATA_WIDTH_IN-1:0] i_thi1,
    input [DATA_WIDTH_IN-1:0] i_thi2,
    input [DATA_WIDTH_IN-1:0] i_thi3,
    output logic         o_xyz_valid,
    output logic [DATA_WIDTH_OUT-1:0]  o_x,
    output logic [DATA_WIDTH_OUT-1:0]  o_y,
    output logic [DATA_WIDTH_OUT-1:0]  o_z
);
    
    localparam a1    = 20;
    localparam a2    = 10;
    localparam b     = 81920; // 5 but with bit shift
    always @(posedge i_clk) begin
        o_x <= {i_thi1,i_thi1};		// Just a dummy assignement. Replace with your code.
        o_y <= {i_thi2,i_thi2};		// Just a dummy assignement. Replace with your code.
        o_z <= {i_thi3,i_thi3};		// Just a dummy assignement. Replace with your code.
        o_xyz_valid <= i_thi_valid;		// Just a dummy assignement. Replace with your code.
    end

endmodule