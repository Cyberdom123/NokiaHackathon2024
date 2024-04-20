
module task_3 
#(parameter DATA_WIDTH_IN = 32,
 parameter DATA_WIDTH_OUT = 32,
 parameter NUM_WORDS_IN = 128,
 parameter N_OUT = 1,
 parameter N_IN = 1,
 parameter NUM_WORDS_OUT = 128
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
  wire [11:0] o_packet_size_in_bytes;
  
  wire [DATA_WIDTH_IN-1:0] w_data_input;
  wire [DATA_WIDTH_OUT-1:0] w_data_output;
  wire [DATA_WIDTH_OUT-1:0] w_fifo_out_data;
  wire w_fifo_out_valid;
  wire [DATA_WIDTH_OUT-1:0] w_lat;
  wire w_lat_valid;
  wire w_valid_output;
  wire w_enb_input; 
  
  reg [DATA_WIDTH_OUT-1:0] r_data_output_del = 0;
  reg r_valid_del = 0; 
  
  assign i_tmanager_ready = tos.task_manager_ready;
  assign i_tdata_last = tis.task_data_last;
  assign i_tdata_valid = tis.task_data_valid;
  assign i_tdata = tis.task_data;

  assign tos.task_answer_ready = o_tanswer_ready;
  assign tos.task_answer_data = o_tanswer_data;
  assign tos.task_answer_data_last = o_tanswer_data_last;
  assign tis.task_data_request = o_tready;
  assign tos.task_answer_packet_size_in_bytes = o_packet_size_in_bytes;

  task_3_in #(
    .WRITE_DATA_WIDTH(8),
    .READ_DATA_WIDTH(DATA_WIDTH_IN),
    .NUM_WORDS(NUM_WORDS_IN)
    ) task_3_in_u(
    .i_clk(i_clk),
	 .i_rst(i_rst),
    .i_tdata_valid(i_tdata_valid),
    .i_tdata(i_tdata),
    .i_tdata_last(i_tdata_last),
    .i_output_last(o_tanswer_data_last),
    .o_tready(o_tready),
    .o_data(w_data_input),
    .o_enb(w_enb_input)
  );
    
  delay_echo #(		
    .DATA_WIDTH_IN(DATA_WIDTH_IN),
    .DATA_WIDTH_OUT(DATA_WIDTH_OUT)
    ) 
    delay_echo_u (		
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_valid(w_enb_input),
    .i_data(w_data_input),
    .o_data(w_data_output),
    .o_valid(w_valid_output)
  );
  
  always@(posedge i_clk) begin
    if(i_rst) begin
        r_data_output_del <= 0;
        r_valid_del <= 0;
    end else begin
        r_data_output_del <= w_data_output;
        r_valid_del <= w_valid_output;      
    end   
  end
  
  task_3_latency_meas #(
  .DATA_WIDTH(DATA_WIDTH_OUT),
  .LAT_SIZE_IN_WIDTH(1)
  )
  task_3_latency_meas_u (
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_in_enb(w_enb_input),
    .i_out_valid(w_valid_output),
    .o_lat(w_lat),
    .o_valid(w_lat_valid)
  );
  
  assign w_fifo_out_data = w_lat_valid ? w_lat : r_data_output_del;  
  assign w_fifo_out_valid = w_lat_valid || r_valid_del;  
    
  task_3_out #(
    .WRITE_DATA_WIDTH(DATA_WIDTH_OUT),
    .READ_DATA_WIDTH(32),
    .NUM_WORDS(NUM_WORDS_OUT)
    ) task_3_out_u(
    .i_clk(i_clk),
	 .i_rst(i_rst),
    .i_tmanager_ready(i_tmanager_ready),
    .i_data(w_fifo_out_data),
    .i_data_valid(w_fifo_out_valid),
    .i_input_last(i_tdata_last),
    .o_tanswer_ready(o_tanswer_ready),
    .o_tdata(o_tanswer_data),
    .o_tanswer_data_last(o_tanswer_data_last),
    .o_packet_size_in_bytes(o_packet_size_in_bytes)
  );

endmodule 