
module task_11 
#(parameter DATA_WIDTH_IN = 16,
 parameter DATA_WIDTH_OUT = 8,
 parameter NUM_WORDS_IN = 256,
 parameter NUM_WORDS_OUT = 8
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
  wire [7:0] w_tdata;
  wire [11:0] o_packet_size_in_bytes;
  
  wire [DATA_WIDTH_IN-1:0] w_data_input;
  wire [31:0] w_data_output;
  wire [9:0] w_phase_output;
  wire w_valid_output;
  wire w_enb_input;
  wire w_clk_1;
  wire w_clk_2;
  wire w_clk_sampl; 
  
  assign i_tmanager_ready = tos.task_manager_ready;
  assign i_tdata_last = tis.task_data_last;
  assign i_tdata_valid = tis.task_data_valid;
  assign i_tdata = tis.task_data;

  assign tos.task_answer_ready = o_tanswer_ready;
  assign tos.task_answer_data = o_tanswer_data;
  assign tos.task_answer_data_last = o_tanswer_data_last;
  assign tis.task_data_request = o_tready;
  assign tos.task_answer_packet_size_in_bytes = o_packet_size_in_bytes;
  


  assign w_tdata[0] = i_tdata[6];
  assign w_tdata[1] = i_tdata[7];
  assign w_tdata[2] = i_tdata[4];
  assign w_tdata[3] = i_tdata[5];
  assign w_tdata[4] = i_tdata[2];
  assign w_tdata[5] = i_tdata[3];
  assign w_tdata[6] = i_tdata[0];
  assign w_tdata[7] = i_tdata[1];
  
  task_11_in #(
    .WRITE_DATA_WIDTH(8),
    .READ_DATA_WIDTH(DATA_WIDTH_IN),
    .NUM_WORDS(NUM_WORDS_IN)
    ) task_11_in_u(
    .i_clk(i_clk),
	 .i_rst(i_rst),
    .i_tdata_valid(i_tdata_valid),
    .i_tdata(w_tdata),
    .i_tdata_last(i_tdata_last),
    .i_output_last(o_tanswer_data_last),
    .o_tready(o_tready),
    .o_clk_1(w_clk_1),
    .o_clk_2(w_clk_2),
    .o_clk_sampl(w_clk_sampl),
    .o_enb(w_enb_input)
  );
    
  phase_detector
    phase_detector_u (		
    .i_clk(i_clk),
    .i_rstn(~(i_rst)),
    .i_clk_1(w_clk_2),
    .i_clk_2(w_clk_1),
    .clk_sampl(w_clk_sampl),
    .o_out(w_phase_output),
    .o_valid(w_valid_output)
  );
  
  assign w_data_output = {22'b0000000000000000000000, w_phase_output};  

  task_11_out #(
    .WRITE_DATA_WIDTH(32),
    .READ_DATA_WIDTH(32),
    .NUM_WORDS(NUM_WORDS_OUT)
    ) task_11_out_u(
    .i_clk(i_clk),
	 .i_rst(i_rst),
    .i_tmanager_ready(i_tmanager_ready),
    .i_data(w_data_output),
    .i_data_valid(w_valid_output),
    .i_input_last(i_tdata_last),
    .o_tanswer_ready(o_tanswer_ready),
    .o_tdata(o_tanswer_data),
    .o_tanswer_data_last(o_tanswer_data_last),
    .o_packet_size_in_bytes(o_packet_size_in_bytes)
  );

endmodule 