//----------------------------------------------------------------------------------------
// TASK 8: Neuron
// 
//----------------------------------------------------------------------------------------

module neuron #(parameter INPUTS_NUM = 3, 
                parameter FXP_FRAC   = 14,
                parameter FXP_INT    = 6,
                parameter LEARNING_RATE = 17'b00000000000000000)(
  input  logic                               clk,
  input  logic                               rst_n,
  input  logic                               mode, // 0-WORKING, 1-LEARNING
  input  logic                               in_data_vld,
  input  logic                               in_data [INPUTS_NUM-1:0],
  output logic                               in_data_rdy,
  input  logic signed [FXP_FRAC+FXP_INT-1:0] init_weights_data [INPUTS_NUM+1-1:0],
  input  logic                               init_weights_vld,
  input  logic                               expected_result_data,
  output logic                               result_data,
  output logic                               result_vld,
  output logic signed [FXP_FRAC+FXP_INT-1:0] result_weights [INPUTS_NUM+1-1:0]);

  assign in_data_rdy = 1;		// Just a dummy assignement. Replace with your code.
  always @(posedge clk) begin
    result_data <= in_data[0];	// Just a dummy assignement. Replace with your code.
    result_vld <= 1;		// Just a dummy assignement. Replace with your code.
  end
endmodule
