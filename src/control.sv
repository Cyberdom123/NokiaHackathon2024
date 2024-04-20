`timescale 1ns/1ns
`include "task_parameters.svh"
import tasks_parameters::*;

parameter TASK_DIN_WIDTH  = 8;
parameter TASK_DOUT_WIDTH = 32;

interface task_in_interface ();
  logic                      task_data_request;
  logic                      task_data_valid;
  logic [TASK_DIN_WIDTH-1:0] task_data;
  logic                      task_data_last;

  modport master (input task_data_request,
                  output task_data_valid, task_data, task_data_last);

  modport  slave (input task_data_valid, task_data, task_data_last,
                  output task_data_request);
endinterface

interface task_out_interface ();
  logic                       task_answer_ready;
  logic                       task_manager_ready;
  logic [TASK_DOUT_WIDTH-1:0] task_answer_data;
  logic                       task_answer_data_last;
  logic [0:0] task_answer_packet_size_in_bytes;

  modport master (input task_answer_ready, task_answer_data, task_answer_data_last, task_answer_packet_size_in_bytes,
                  output task_manager_ready);

  modport  slave (input task_manager_ready,
                  output task_answer_ready, task_answer_data, task_answer_data_last, task_answer_packet_size_in_bytes);
endinterface

module control
  #(
    parameter NUMBER_OF_TASKS = 15,
    parameter TASK_DIN_WIDTH  = TASK_DIN_WIDTH,
    parameter TASK_DOUT_WIDTH = TASK_DOUT_WIDTH,
    parameter M_AXI_ADDR_WIDTH = 32,
    parameter M_AXI_DATA_WIDTH = 32,
    parameter SMEM_TV_IN_BASEADDR  = 32'hA000_0000,
    parameter SMEM_TV_OUT_BASEADDR = 32'hA000_0800
  ) (
    //  sys
    input i_clk,
    input i_rst,
    // control signals
    input         start_tests,
    input  [31:0] current_task_number,
    output [31:0] enabled_tasks,
    output logic  tasks_done,
    // axi master
    input m_axi_aclk,
    input m_axi_aresetn,
    output [M_AXI_ADDR_WIDTH-1:0] m_axi_awaddr,
    output                        m_axi_awvalid,
    input                         m_axi_awready,
    output [M_AXI_DATA_WIDTH-1:0] m_axi_wdata,
    output                        m_axi_wvalid,
    input                         m_axi_wready,
    input [1:0]                   m_axi_bresp,
    input                         m_axi_bvalid,
    output                        m_axi_bready,
    output [M_AXI_ADDR_WIDTH-1:0] m_axi_araddr,
    output                        m_axi_arvalid,
    input                         m_axi_arready,
    input [M_AXI_DATA_WIDTH-1:0]  m_axi_rdata,
    input [1:0]                   m_axi_rresp,
    input                         m_axi_rvalid,
    output                        m_axi_rready
  );

task_in_interface  tasks_in_interface  [NUMBER_OF_TASKS:1] ();
task_out_interface tasks_out_interface [NUMBER_OF_TASKS:1] ();

logic [M_AXI_DATA_WIDTH-1:0] tx_fifo_data_in;
logic [M_AXI_DATA_WIDTH-1:0] tx_fifo_addr_in;
logic                        tx_fifo_wr_en;
logic                        tx_fifo_full;
logic [TASK_DIN_WIDTH-1:0]   rx_fifo_data_out;
logic                        rx_fifo_rd_en;
logic                        rx_fifo_empty;
logic [M_AXI_ADDR_WIDTH-1:0] req_addr_fifo_in;
logic                        req_addr_fifo_wr_en;
logic                        req_addr_fifo_full;

logic task_manager_done;
logic tx_fifo_empty;

always_ff @(posedge i_clk) begin
  if (i_rst)
    tasks_done <= 0;
  else begin
    if (task_manager_done && tx_fifo_empty) 
      tasks_done <= 1;
    else
      tasks_done <= tasks_done;
  end
end

  axi_mm_master #(
    .C_M_AXI_ADDR_WIDTH(M_AXI_ADDR_WIDTH),
    .C_M_AXI_DATA_WIDTH(M_AXI_DATA_WIDTH),
    .C_TX_FIFO_DEPTH   (128),
    .C_RX_FIFO_DEPTH   (128),
    .C_REQ_FIFO_DEPTH  (128)
  ) axi_mm_0 (
    .M_AXI_ACLK(m_axi_aclk),
    .M_AXI_ARESETN(m_axi_aresetn),
    .M_AXI_AWADDR(m_axi_awaddr),
    .M_AXI_AWVALID(m_axi_awvalid),
    .M_AXI_AWREADY(m_axi_awready),
    .M_AXI_WDATA(m_axi_wdata),
    .M_AXI_WVALID(m_axi_wvalid),
    .M_AXI_WREADY(m_axi_wready),
    .M_AXI_BRESP(m_axi_bresp),
    .M_AXI_BVALID(m_axi_bvalid),
    .M_AXI_BREADY(m_axi_bready),
    .M_AXI_ARADDR(m_axi_araddr),
    .M_AXI_ARVALID(m_axi_arvalid),
    .M_AXI_ARREADY(m_axi_arready),
    .M_AXI_RDATA(m_axi_rdata),
    .M_AXI_RRESP(m_axi_rresp),
    .M_AXI_RVALID(m_axi_rvalid),
    .M_AXI_RREADY(m_axi_rready),
    .TX_FIFO_DATA_IN(tx_fifo_data_in),
    .TX_FIFO_ADDR_IN(tx_fifo_addr_in),
    .TX_FIFO_WR_EN(tx_fifo_wr_en),
    .TX_FIFO_FULL(tx_fifo_full),
    .TX_FIFO_EMPTY(tx_fifo_empty),
    .RX_FIFO_DATA_OUT(rx_fifo_data_out),
    .RX_FIFO_RD_EN(rx_fifo_rd_en),
    .RX_FIFO_EMPTY(rx_fifo_empty),
    .REQ_ADDR_FIFO_IN(req_addr_fifo_in),
    .REQ_ADDR_FIFO_WR_EN(req_addr_fifo_wr_en),
    .REQ_ADDR_FIFO_FULL(req_addr_fifo_full)
    );
  
  task_manager # (
    .NUMBER_OF_TASKS (NUMBER_OF_TASKS),
    .TASK_DIN_WIDTH  (TASK_DIN_WIDTH),
    .TASK_DOUT_WIDTH (TASK_DOUT_WIDTH),
    .M_AXI_DATA_WIDTH(M_AXI_DATA_WIDTH),
    .M_AXI_ADDR_WIDTH(M_AXI_ADDR_WIDTH),
    .SMEM_TV_IN_BASEADDR (SMEM_TV_IN_BASEADDR),
    .SMEM_TV_OUT_BASEADDR(SMEM_TV_OUT_BASEADDR)
  ) task_manager_0 (
    .i_clk(i_clk),
    .i_rst(i_rst),
    .tim (tasks_in_interface),
    .tom (tasks_out_interface),
    .TV_IN_DATA   (rx_fifo_data_out),
    .TV_IN_FIFO_RD_EN  (rx_fifo_rd_en),
    .TV_IN_FIFO_NOT_EMPTY(~rx_fifo_empty),
    .TV_OUT_DATA  (tx_fifo_data_in),
    .TV_OUT_ADDR  (tx_fifo_addr_in),
    .TV_OUT_WR_EN (tx_fifo_wr_en),
    .TV_OUT_READY (~tx_fifo_full),
    .TV_REQ_ADDR  (req_addr_fifo_in),
    .TV_REQ_READY (~req_addr_fifo_full),
    .TV_REQ_WR_EN (req_addr_fifo_wr_en),
    .enabled_tasks(enabled_tasks),
    .start_tests  (start_tests),
    .tasks_done   (task_manager_done),
    .current_task_number(current_task_number)
  );
  
  
    task_1 #(
      .DATA_WIDTH_IN(TASK_1_DATA_WIDTH_IN),
      .DATA_WIDTH_OUT(TASK_1_DATA_WIDTH_OUT),
      .NUM_WORDS_IN(TASK_1_NUM_WORDS_IN),
      .NUM_WORDS_OUT(TASK_1_NUM_WORDS_OUT)
    ) task_1 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[1]),
      .tos   (tasks_out_interface[1])
    );
    
     task_2 #(
      .DATA_WIDTH_IN(TASK_2_DATA_WIDTH_IN),
      .DATA_WIDTH_OUT(TASK_2_DATA_WIDTH_OUT),
      .NUM_WORDS_IN(TASK_2_NUM_WORDS_IN),
      .NUM_WORDS_OUT(TASK_2_NUM_WORDS_OUT)
    ) task_2 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[2]),
      .tos   (tasks_out_interface[2])
    );
    
     task_3 #(
      .DATA_WIDTH_IN(TASK_3_DATA_WIDTH_IN),
      .DATA_WIDTH_OUT(TASK_3_DATA_WIDTH_OUT),
      .NUM_WORDS_IN(TASK_3_NUM_WORDS_IN),
      .NUM_WORDS_OUT(TASK_3_NUM_WORDS_OUT),
      .N_IN(TASK_3_N_IN),
      .N_OUT(TASK_3_N_OUT)    
    ) task_3 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[3]),
      .tos   (tasks_out_interface[3])
    );
    
     task_4 #(
      .DATA_WIDTH_IN(TASK_4_DATA_WIDTH_IN),
      .DATA_WIDTH_OUT(TASK_4_DATA_WIDTH_OUT),
      .NUM_WORDS_IN(TASK_4_NUM_WORDS_IN),
      .NUM_WORDS_OUT(TASK_4_NUM_WORDS_OUT)   
    ) task_4 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[4]),
      .tos   (tasks_out_interface[4])
    );
    
    task_5 #(
      .DATA_WIDTH_IN(TASK_5_DATA_WIDTH_IN),
      .DATA_WIDTH_OUT(TASK_5_DATA_WIDTH_OUT),
      .NUM_WORDS_IN(TASK_5_NUM_WORDS_IN),
      .NUM_WORDS_OUT(TASK_5_NUM_WORDS_OUT)   
    ) task_5 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[5]),
      .tos   (tasks_out_interface[5])
    );
    
    task_6 #(
      .DATA_WIDTH_IN(TASK_6_DATA_WIDTH_IN),
      .DATA_WIDTH_OUT(TASK_6_DATA_WIDTH_OUT),
      .NUM_WORDS_IN(TASK_6_NUM_WORDS_IN),
      .NUM_WORDS_OUT(TASK_6_NUM_WORDS_OUT)   
    ) task_6 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[6]),
      .tos   (tasks_out_interface[6])
    );
    
     task_7 #(
      .DATA_WIDTH_IN(TASK_7_DATA_WIDTH_IN),
      .DATA_WIDTH_OUT(TASK_7_DATA_WIDTH_OUT),
      .NUM_WORDS_IN(TASK_7_NUM_WORDS_IN),
      .NUM_WORDS_OUT(TASK_7_NUM_WORDS_OUT)   
    ) task_7 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[7]),
      .tos   (tasks_out_interface[7])
    );
    
    task_8 #(
      .DATA_WIDTH_IN(TASK_8_DATA_WIDTH_IN),
      .DATA_WIDTH_OUT(TASK_8_DATA_WIDTH_OUT),
      .NUM_WORDS_IN(TASK_8_NUM_WORDS_IN),
      .NUM_WORDS_OUT(TASK_8_NUM_WORDS_OUT)   
    ) task_8 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[8]),
      .tos   (tasks_out_interface[8])
    );
    
     task_9 #(
      .DATA_WIDTH_IN(TASK_9_DATA_WIDTH_IN),
      .DATA_WIDTH_OUT(TASK_9_DATA_WIDTH_OUT),
      .NUM_WORDS_IN(TASK_9_NUM_WORDS_IN),
      .NUM_WORDS_OUT(TASK_9_NUM_WORDS_OUT)   
    ) task_9 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[9]),
      .tos   (tasks_out_interface[9])
    );
    
    task_10 #(
      .DATA_WIDTH_IN(TASK_10_DATA_WIDTH_IN),
      .DATA_WIDTH_OUT(TASK_10_DATA_WIDTH_OUT),
      .NUM_WORDS_IN(TASK_10_NUM_WORDS_IN),
      .NUM_WORDS_OUT(TASK_10_NUM_WORDS_OUT),
      .N_IN(TASK_10_N_IN),
      .N_OUT(TASK_10_N_OUT) 
    ) task_10 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[10]),
      .tos   (tasks_out_interface[10])
    );
    
    task_11 #(
      .DATA_WIDTH_IN(2),
      .DATA_WIDTH_OUT(16),
      .NUM_WORDS_IN(64),
      .NUM_WORDS_OUT(TASK_11_NUM_WORDS_OUT)  
    ) task_11 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[11]),
      .tos   (tasks_out_interface[11])
    );
    
    task_12 #(
      .DATA_WIDTH_IN(TASK_12_DATA_WIDTH_IN),
      .DATA_WIDTH_OUT(TASK_12_DATA_WIDTH_OUT),
      .NUM_WORDS_IN(TASK_12_NUM_WORDS_IN),
      .NUM_WORDS_OUT(TASK_12_NUM_WORDS_OUT),
      .N_IN(TASK_12_N_IN),
      .N_OUT(TASK_12_N_OUT)   
    ) task_12 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[12]),
      .tos   (tasks_out_interface[12])
    );
    
     task_13 #(
      .DATA_WIDTH_IN(TASK_13_DATA_WIDTH_IN),
      .DATA_WIDTH_OUT(TASK_13_DATA_WIDTH_OUT),
      .NUM_WORDS_IN(TASK_13_NUM_WORDS_IN),
      .NUM_WORDS_OUT(TASK_13_NUM_WORDS_OUT) 
    ) task_13 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[13]),
      .tos   (tasks_out_interface[13])
    );
    
     task_14 #(
      .DATA_WIDTH_IN(TASK_14_DATA_WIDTH_IN),
      .DATA_WIDTH_OUT(TASK_14_DATA_WIDTH_OUT),
      .NUM_WORDS_IN(TASK_14_NUM_WORDS_IN),
      .NUM_WORDS_OUT(TASK_14_NUM_WORDS_OUT) 
    ) task_14 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[14]),
      .tos   (tasks_out_interface[14])
    );

     task_15 #(
      .DATA_WIDTH_IN(TASK_15_DATA_WIDTH_IN),
      .DATA_WIDTH_OUT(TASK_15_DATA_WIDTH_OUT),
      .NUM_WORDS_IN(TASK_15_NUM_WORDS_IN),
      .NUM_WORDS_OUT(TASK_15_NUM_WORDS_OUT) 
    ) task_15 (
      .i_clk (i_clk),
      .i_rst (i_rst),
      .tis   (tasks_in_interface[15]),
      .tos   (tasks_out_interface[15])
    );
    
    
endmodule



