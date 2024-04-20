//----------------------------------------------------------------------------------------
// TASK 9: Neural network
// 
//----------------------------------------------------------------------------------------

module network_xor #(parameter INPUTS_NUM = 3,
    parameter FXP_FRAC   = 14,
    parameter FXP_INT    = 6,
    parameter LEARNING_RATE = 17'b00000000000000000,
    parameter LAYERS_NUM = 2,
    parameter integer NEURON_NUM[LAYERS_NUM-1:0] ={1,9},
    parameter MAX_NEURON_NUM = 9)(
    input  logic                               clk,
    input  logic                               rst_n,
    input  logic                               mode, // 0-WORKING, 1-LEARNING
    input  logic                               in_data_vld,
    output logic                               in_data_rdy,
    input  logic                               in_data [INPUTS_NUM-1:0],
    input  logic                               expected_result_data, //used only in learning mode
    input  logic signed [FXP_FRAC+FXP_INT-1:0] init_weights_data [LAYERS_NUM][MAX_NEURON_NUM][MAX_NEURON_NUM+1-1:0], //used only in learning mode
    input  logic                               init_weights_vld, //used only in learning mode
    output logic                               result_data,
    output logic                               result_vld,
    output logic signed [FXP_FRAC+FXP_INT-1:0] result_weights [LAYERS_NUM][MAX_NEURON_NUM][MAX_NEURON_NUM+1-1:0]); //used only in learning mode

    assign in_data_rdy = 1;		// Just a dummy assignement. Replace with your code.
    always @(posedge clk)
        result_data <= in_data[0];	// Just a dummy assignement. Replace with your code.
    assign result_vld = 1;		// Just a dummy assignement. Replace with your code.

endmodule
