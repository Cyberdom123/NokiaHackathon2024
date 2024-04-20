
module task_12 
#(parameter DATA_WIDTH_IN = 16,
 parameter DATA_WIDTH_OUT = 32,
 parameter NUM_WORDS_IN = 3,
 parameter NUM_WORDS_OUT = 6,
 parameter N_IN = 3,
 parameter N_OUT = 3
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
  wire [DATA_WIDTH_OUT-1:0] w_data_output [N_OUT];
  wire w_valid_output;
  wire w_enb_input; 
  wire w_int_rst;
  wire [DATA_WIDTH_IN-1:0] w_data_des [N_IN];
  wire w_valid_des;
  wire [DATA_WIDTH_OUT-1:0] w_x;
  wire [DATA_WIDTH_OUT-1:0] w_y;
  wire [DATA_WIDTH_OUT-1:0] w_z; 
  wire [DATA_WIDTH_OUT-1:0] w_data_ser;
  wire w_valid_ser;
  reg r_flag = 0;
  reg [DATA_WIDTH_IN-1:0] r_data_des [N_IN] = '{default:0};
  reg r_valid_des = 0;
  
  assign i_tmanager_ready = tos.task_manager_ready;
  assign i_tdata_last = tis.task_data_last;
  assign i_tdata_valid = tis.task_data_valid;
  assign i_tdata = tis.task_data;

  assign tos.task_answer_ready = o_tanswer_ready;
  assign tos.task_answer_data = o_tanswer_data;
  assign tos.task_answer_data_last = o_tanswer_data_last;
  assign tis.task_data_request = o_tready;
  assign tos.task_answer_packet_size_in_bytes = o_packet_size_in_bytes;

  task_12_in #(
    .WRITE_DATA_WIDTH(8),
    .READ_DATA_WIDTH(DATA_WIDTH_IN),
    .NUM_WORDS(NUM_WORDS_IN)
    ) task_12_in_u(
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
  
  task_12_deserializer #(.N(N_IN), .DATA_WIDTH(DATA_WIDTH_IN)) deserializer(
    .i_enb(w_enb_input),
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_data(w_data_input),
    .o_data(w_data_des),
    .o_valid(w_valid_des)
  );
 
  always@(posedge i_clk) begin
    if(i_rst) begin
        r_flag <= 0;
    end else if(w_valid_des) begin
        r_flag <= 1;
    end
  end 
  
  always@(posedge i_clk) begin
    if(i_rst) begin
        r_valid_des <= 0;
        r_data_des <= '{default:0};
    end else if(r_flag == 0 && w_valid_des)begin
        r_valid_des <=  w_valid_des;
        r_data_des <= w_data_des;        
    end else begin
        r_valid_des <= 0;
        r_data_des <= '{default:0};     
    end
  end
    
  robot_arm
    robot_arm_u (		
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_thi_valid(r_valid_des),
    .i_thi1(r_data_des[0]),
    .i_thi2(r_data_des[1]),
    .i_thi3(r_data_des[2]),
    .o_x(w_x),
    .o_y(w_y),
    .o_z(w_z),
    .o_xyz_valid(w_valid_output)
  );
  
  assign w_data_output[0] = w_x;
  assign w_data_output[1] = w_y;
  assign w_data_output[2] = w_z;
  
  task_12_serializer #(.N_OUT(N_OUT), .DATA_WIDTH(DATA_WIDTH_OUT)) serializer(
    .i_valid(w_valid_output),
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_data(w_data_output),
    .o_data(w_data_ser),
    .o_valid(w_valid_ser)
  );  
    
  task_12_out #(
    .WRITE_DATA_WIDTH(DATA_WIDTH_OUT),
    .READ_DATA_WIDTH(32),
    .NUM_WORDS(NUM_WORDS_OUT)
    ) task_12_out_u(
    .i_clk(i_clk),
	 .i_rst(i_rst),
    .i_tmanager_ready(i_tmanager_ready),
    .i_data(w_data_ser),
    .i_data_valid(w_valid_ser),
    .i_input_last(i_tdata_last),
    .o_tanswer_ready(o_tanswer_ready),
    .o_tdata(o_tanswer_data),
    .o_tanswer_data_last(o_tanswer_data_last),
    .o_packet_size_in_bytes(o_packet_size_in_bytes)
  );

endmodule 
