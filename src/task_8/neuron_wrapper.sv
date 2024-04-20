module neuron_wrapper #(parameter INPUTS_NUM = 3, 
                parameter FXP_FRAC   = 14,
                parameter FXP_INT    = 6,
                parameter LEARNING_RATE = 17'b00000000000000000)(
  input  logic                               clk,
  input  logic                               rst_n,
  input  logic                               mode, // 0-WORKING, 1-LEARNING
  input  logic                               in_data_vld,
  input  logic                               in_data [INPUTS_NUM-1:0],
  output logic                               in_data_rdy,
  input  logic                               expected_result_data,  //used only in learning mode
  output logic                               result_data,
  output logic                               result_vld,
  output logic signed [FXP_FRAC+FXP_INT-1:0] result_weights [INPUTS_NUM+1-1:0]);

  logic signed [FXP_FRAC+FXP_INT-1:0] init_weights_data [INPUTS_NUM+1-1:0];
  logic                               init_weights_vld;

  assign init_weights_vld = 1;
  
  initial begin
    $readmemh("weights.mem", init_weights_data);
  end
  
  neuron #(
    .INPUTS_NUM    (INPUTS_NUM),
    .FXP_FRAC      (FXP_FRAC),
    .FXP_INT       (FXP_INT),
    .LEARNING_RATE(LEARNING_RATE)
  )
  u_neuron (
    .clk                 (clk),
    .expected_result_data(expected_result_data),
    .in_data             (in_data),
    .in_data_rdy         (in_data_rdy),
    .in_data_vld         (in_data_vld),
    .init_weights_data   (init_weights_data),
    .init_weights_vld    (init_weights_vld),
    .mode                (mode), //0-WORKING, 1-LEARNING
    .result_data         (result_data),
    .result_vld          (result_vld),
    .result_weights      (result_weights),
    .rst_n               (rst_n)
    );
  
endmodule
