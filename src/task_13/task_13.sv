
module task_13 
#(parameter DATA_WIDTH_IN = 8,
 parameter DATA_WIDTH_OUT = 16,
 parameter NUM_WORDS_IN = 256,
 parameter NUM_WORDS_OUT = 256
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
  wire w_valid_output;
  wire w_enb_input; 
  
  reg [8:0] r_counter = 0; 
  reg [DATA_WIDTH_IN-1:0] r_data_input = 0;
  reg r_enb_input = 0; 
  
  assign i_tmanager_ready = tos.task_manager_ready;
  assign i_tdata_last = tis.task_data_last;
  assign i_tdata_valid = tis.task_data_valid;
  assign i_tdata = tis.task_data;

  assign tos.task_answer_ready = o_tanswer_ready;
  assign tos.task_answer_data = o_tanswer_data;
  assign tos.task_answer_data_last = o_tanswer_data_last;
  assign tis.task_data_request = o_tready;
  assign tos.task_answer_packet_size_in_bytes = o_packet_size_in_bytes;


  task_13_in #(
    .WRITE_DATA_WIDTH(8),
    .READ_DATA_WIDTH(DATA_WIDTH_IN),
    .NUM_WORDS(NUM_WORDS_IN)
    ) task_13_in_u(
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
  
  always@(posedge i_clk) begin
    if(i_rst)
        r_counter <= 0;
    else if(w_enb_input)
        r_counter <= r_counter + 1'b1;
  end
  
  always@(posedge i_clk) begin
    if(i_rst) begin
        r_data_input <= 0;
        r_enb_input <= 0;
    end else if(r_counter <= 3 && w_enb_input) begin
        r_data_input <= w_data_input;
        r_enb_input <= w_enb_input;
    end else begin
        r_data_input <= 0;
        r_enb_input <= 0;
    end
  end
    
  dct_1d #(		
    .DATA_WIDTH_IN(DATA_WIDTH_IN),
    .DATA_WIDTH_OUT(DATA_WIDTH_OUT)
    ) 
    dct_1d_u (		
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_valid(r_enb_input),
    .i_data(r_data_input),
    .o_data(w_data_output),
    .o_valid(w_valid_output)
  );  

  task_13_out #(
    .WRITE_DATA_WIDTH(DATA_WIDTH_OUT),
    .READ_DATA_WIDTH(32),
    .NUM_WORDS(NUM_WORDS_OUT)
    ) task_13_out_u(
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