module network_xor_wrapper #(parameter INPUTS_NUM = 3)(
    input  logic                               clk,
    input  logic                               rst_n,
    input  logic                               in_data_vld,
    output logic                               in_data_rdy,
    input  logic                               in_data [INPUTS_NUM-1:0],
    output logic                               result_data,
    output logic                               result_vld
    );

  localparam WEIGHTS_WIDTH  = 20;
  localparam LAYERS_NUM     = 2;
  localparam MAX_NEURON_NUM = 9;

  // signals used only in learning mode
  logic                               mode; // 0-WORKING, 1-LEARNING
  logic                               expected_result_data;
  logic signed [WEIGHTS_WIDTH-1:0]    init_weights_data [LAYERS_NUM][MAX_NEURON_NUM][MAX_NEURON_NUM+1-1:0];
  logic                               init_weights_vld;
  logic signed [WEIGHTS_WIDTH-1:0]    result_weights [LAYERS_NUM][MAX_NEURON_NUM][MAX_NEURON_NUM+1-1:0];
  
  assign mode = 0;
  assign expected_result_data = 0;
  assign init_weights_data = '{default:0};
  assign init_weights_vld = 0;

    network_xor #(
    .INPUTS_NUM    (INPUTS_NUM),
    .FXP_FRAC      (14),
    .FXP_INT       (6),
    .LEARNING_RATE (17'b00000000000000000),
    .LAYERS_NUM    (LAYERS_NUM),
    .NEURON_NUM    ({1,9}),
    .MAX_NEURON_NUM(MAX_NEURON_NUM)
  )
  u_network_xor (
    .clk                 (clk),
    .rst_n               (rst_n),
    .mode                (mode), //0-WORKING, 1-LEARNING
    .expected_result_data(expected_result_data), //used only in learning mode
    .in_data             (in_data),
    .in_data_vld         (in_data_vld),
    .in_data_rdy         (in_data_rdy),
    .init_weights_data   (init_weights_data), //used only in learning mode
    .init_weights_vld    (init_weights_vld), //used only in learning mode
    .result_data         (result_data), 
    .result_vld          (result_vld),
    .result_weights      (result_weights) //used only in learning mode
    );

endmodule