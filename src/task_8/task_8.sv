
module task_8 
#(parameter DATA_WIDTH_IN = 8,
 parameter DATA_WIDTH_OUT = 8,
 parameter NUM_WORDS_IN = 3,
 parameter NUM_WORDS_OUT = 6
 )
(input i_clk, input i_rst,
  task_in_interface.slave  tis,
  task_out_interface.slave tos);
  
  wire i_tmanager_ready;
  wire i_tdata_last;
  wire i_tdata_valid;
  wire [7:0] i_tdata;
  wire o_tanswer_ready;
  wire [31:0] o_tanswer_data;
  wire o_tanswer_data_last;
  wire o_tready;
  wire [11:0] o_packet_size_in_bytes;;
  wire w_output_valid;
  wire w_neuron_result;
  wire w_neuron_input[3];
  
  wire [DATA_WIDTH_IN-1:0] w_data_input;
  wire [DATA_WIDTH_OUT-1:0] w_data_output;
  wire w_enb_input; 
  wire w_int_rst;
  wire w_data_req;
  
  genvar i;
  
  assign i_tmanager_ready = tos.task_manager_ready;
  assign i_tdata_last = tis.task_data_last;
  assign i_tdata_valid = tis.task_data_valid;
  assign i_tdata = tis.task_data;

  assign tos.task_answer_ready = o_tanswer_ready;
  assign tos.task_answer_data = o_tanswer_data;
  assign tos.task_answer_data_last = o_tanswer_data_last;
  assign tis.task_data_request = o_tready;
  assign tos.task_answer_packet_size_in_bytes = o_packet_size_in_bytes;

  task_8_in #(
    .WRITE_DATA_WIDTH(8),
    .READ_DATA_WIDTH(8),
    .NUM_WORDS(24)
    ) task_8_in_u(
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_tdata_valid(i_tdata_valid),
    .i_tdata(i_tdata),
    .i_tdata_last(i_tdata_last),
    .i_output_last(o_tanswer_data_last),
    .i_data_req(w_data_req),
    .o_tready(o_tready),
    .o_data(w_data_input),
    .o_enb(w_enb_input)
  );
   
   
  assign w_neuron_input[0] = w_data_input[2];
  assign w_neuron_input[1] = w_data_input[1]; 
  assign w_neuron_input[2] = w_data_input[0]; 
      
  neuron_wrapper	
    neuron_wrapper_u (		
  .clk(i_clk),
  .rst_n(~(i_rst)),
  .mode('0),
  .in_data_vld(w_enb_input),
  .in_data(w_neuron_input),
  .in_data_rdy(w_data_req),
  .expected_result_data('0),
  .result_data(w_neuron_result),
  .result_vld(w_output_valid),
  .result_weights()
  );
  
  assign w_data_output = {7'b0000000, w_neuron_result};
    
  task_8_out #(
    .WRITE_DATA_WIDTH(DATA_WIDTH_OUT),
    .READ_DATA_WIDTH(32),
    .NUM_WORDS(8)
    ) task_8_out_u(
    .i_clk(i_clk),
	 .i_rst(i_rst),
    .i_tmanager_ready(i_tmanager_ready),
    .i_data(w_data_output),
    .i_data_valid(w_output_valid),
    .i_input_last(i_tdata_last),
    .o_tanswer_ready(o_tanswer_ready),
    .o_tdata(o_tanswer_data),
    .o_tanswer_data_last(o_tanswer_data_last),
    .o_packet_size_in_bytes(o_packet_size_in_bytes)
  );

endmodule 
