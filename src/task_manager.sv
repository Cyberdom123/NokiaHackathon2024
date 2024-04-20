import tasks_parameters::*;

module task_manager
  #(parameter NUMBER_OF_TASKS  = 16, // MAXIMUM number 32!
    parameter TASK_DIN_WIDTH   = 8,
    parameter TASK_DOUT_WIDTH  = 32,
    parameter M_AXI_DATA_WIDTH = 32,
    parameter M_AXI_ADDR_WIDTH = 32,
    parameter SMEM_TV_IN_BASEADDR  = 32'hA000_0000,
    parameter SMEM_TV_OUT_BASEADDR = 32'hA000_0800
  ) (
    // sys 
    input         i_clk,
    input         i_rst,
    input         start_tests,
    input  [31:0] current_task_number,
    output        tasks_done,
    output [31:0] enabled_tasks,
    // Test vectors incoming from AXI interface to tasks 
    input [TASK_DIN_WIDTH-1:0] TV_IN_DATA,
    output logic               TV_IN_FIFO_RD_EN,
    input                      TV_IN_FIFO_NOT_EMPTY,
    // Test vectors outgoing from tasks to AXI interface 
    output logic [M_AXI_DATA_WIDTH-1:0] TV_OUT_DATA,
    output logic [M_AXI_DATA_WIDTH-1:0] TV_OUT_ADDR,
    output logic                        TV_OUT_WR_EN,
    input                               TV_OUT_READY,
    // Test vectors request
    output logic [M_AXI_ADDR_WIDTH-1:0] TV_REQ_ADDR,
    input                               TV_REQ_READY,
    output logic                        TV_REQ_WR_EN,
    // Task interfaces
    task_in_interface.master  tim [NUMBER_OF_TASKS:1],
    task_out_interface.master tom [NUMBER_OF_TASKS:1]
  );

typedef enum bit [2:0] {
    IDLE        = 3'd0,
    SEND_TV_IN  = 3'd1,
    SEND_TV_OUT = 3'd2
} state_enum;

state_enum state;
state_enum next_state;

typedef struct packed {
    logic task32;
    logic task31;
    logic task30;
    logic task29;
    logic task28;
    logic task27;
    logic task26;
    logic task25;

    logic task24;
    logic task23;
    logic task22;
    logic task21;
    logic task20;
    logic task19;
    logic task18;
    logic task17;

    logic task16;
    logic task15;
    logic task14;
    logic task13;
    logic task12;
    logic task11;
    logic task10;
    logic task9;

    logic task8;
    logic task7;
    logic task6;
    logic task5;
    logic task4;
    logic task3;
    logic task2;
    logic task1;
} task_enabler;

localparam task_enabler enable = '{
                                  task1 :  1'd1,
                                  task2 :  1'd0,
                                  task3 :  1'd0,
                                  task4 :  1'd0,
                                  task5 :  1'd0,
                                  task6 :  1'd0,
                                  task7 :  1'd0,
                                  task8 :  1'd0,

                                  task9 :  1'd0,
                                  task10 : 1'd1,
                                  task11 : 1'd0,
                                  task12 : 1'd0,
                                  task13 : 1'd0,
                                  task14 : 1'd0,
                                  task15 : 1'd0,
                                  task16 : 1'd0,

                                  task17 : 1'd0,
                                  task18 : 1'd0,
                                  task19 : 1'd0,
                                  task20 : 1'd0,
                                  task21 : 1'd0,
                                  task22 : 1'd0,
                                  task23 : 1'd0,
                                  task24 : 1'd0,

                                  task25 : 1'd0,
                                  task26 : 1'd0,
                                  task27 : 1'd0,
                                  task28 : 1'd0,
                                  task29 : 1'd0,
                                  task30 : 1'd0,
                                  task31 : 1'd0,
                                  task32 : 1'd0
};
assign enabled_tasks = enable;


logic w_task_done;
logic [TASK_DOUT_WIDTH-1:0] task_answer_data;
logic task_data_valid;
logic task_manager_ready;
logic task_answer_ready;
logic task_answer_data_last;
logic task_data_request;
logic [3:0] tv_out_wr_en_reg;

logic [4:0] granted_task_number;
logic [11:0] tv_req_cnt,  tv_in_cnt,  tv_out_cnt;
logic        tv_req_sent, tv_in_sent, tv_out_sent;
logic                     tv_in_last, tv_out_last;

logic [NUMBER_OF_TASKS:1] [TASK_DOUT_WIDTH-1:0] tom_task_answer_data;
logic [NUMBER_OF_TASKS:1] tom_task_answer_ready;
logic [NUMBER_OF_TASKS:1] tom_task_answer_data_last;
logic [NUMBER_OF_TASKS:1] tim_task_data_request;

assign task_answer_ready     = granted_task_number==0 ? 0 : tom_task_answer_ready[granted_task_number];
assign task_answer_data      = granted_task_number==0 ? 0 : tom_task_answer_data[granted_task_number];
assign task_answer_data_last = granted_task_number==0 ? 0 : tom_task_answer_data_last[granted_task_number];
assign task_data_request     = granted_task_number==0 ? 0 : tim_task_data_request[granted_task_number];


assign tasks_done = w_task_done;
assign granted_task_number = current_task_number;


always_ff @(posedge i_clk) begin
  task_data_valid <= TV_IN_FIFO_NOT_EMPTY;
  TV_OUT_WR_EN <= tv_out_wr_en_reg[3];
end


always_ff @(posedge i_clk) begin : tv_out_write_enable_pipeline
  if (i_rst == 1)
    tv_out_wr_en_reg <= '0;
  else
    tv_out_wr_en_reg <= {(tv_out_wr_en_reg[2] && task_answer_ready),(tv_out_wr_en_reg[1] && task_answer_ready),(tv_out_wr_en_reg[0] && task_answer_ready),(task_answer_ready && TV_OUT_READY)};

end : tv_out_write_enable_pipeline


always_ff @(posedge i_clk) begin : task_done_control
  if (i_rst == 1)
    w_task_done <= 0;
  else begin
    if (tv_out_last==1 || tv_out_sent==1)
      w_task_done <= 1;
    else
      w_task_done <= w_task_done;
  end
end : task_done_control


always_ff @(posedge i_clk) begin
  task_manager_ready <= (task_answer_ready && TV_OUT_READY);
  TV_OUT_DATA <= task_answer_data;
  tv_out_last <= task_answer_data_last;
end

genvar i, j;

generate for (i=1; i <= NUMBER_OF_TASKS; i++) begin : TIM_TOM1
    always_ff @(posedge i_clk) begin
      if (i_rst) begin
        tom_task_answer_ready[i]     <= 0;
        tom_task_answer_data[i]      <= 0;
        tom_task_answer_data_last[i] <= 0;
        tim_task_data_request[i]     <= 0;
      end
      else begin
        tom_task_answer_ready[i]     <= tom[i].task_answer_ready;
        tom_task_answer_data[i]      <= tom[i].task_answer_data;
        tom_task_answer_data_last[i] <= tom[i].task_answer_data_last;
        tim_task_data_request[i]     <= tim[i].task_data_request;
      end
    end
  end : TIM_TOM1
endgenerate


generate for (j=1; j <= NUMBER_OF_TASKS; j++) begin : TIM_TOM2
    always_ff @(posedge i_clk) begin
      if (i_rst) begin
        tim[j].task_data_valid    <= 0;
        tim[j].task_data          <= '0;
        tim[j].task_data_last     <= 0;
        tom[j].task_manager_ready <= 0;
      end
      else begin
        if (j==granted_task_number) begin
          tim[j].task_data_valid    <= task_data_valid;
          tim[j].task_data          <= TV_IN_DATA;
          tim[j].task_data_last     <= tv_in_last;
          tom[j].task_manager_ready <= task_manager_ready;
        end else begin
          tim[j].task_data_valid    <= 0;
          tom[j].task_manager_ready <= 0;
          tim[j].task_data          <= '0;
          tim[j].task_data_last     <= 0;
        end
      end
    end
  end  : TIM_TOM2
endgenerate


always_comb begin : fsm_transitions
  case(state)
    IDLE: begin
      if (start_tests == 1)
        next_state = SEND_TV_IN;
      else
        next_state = state;
    end
    SEND_TV_IN: begin
      if (tv_in_sent == 1)
        next_state = SEND_TV_OUT;
      else
        next_state = state;
    end
    SEND_TV_OUT: begin
      if (tv_out_sent == 1 || tv_out_last==1)
        next_state = IDLE;
      else
        next_state = state;
    end
    default: next_state = IDLE;
  endcase
end : fsm_transitions


always_ff @(posedge i_clk) begin : tv_req_addr_gen_wr_en_gen
  if (i_rst == 1) begin
    TV_REQ_ADDR  <= 0;
    TV_REQ_WR_EN <= 0;
  end else begin
    if (state == SEND_TV_IN && tv_req_sent == 0 ) begin
      if (TV_REQ_READY == 1) begin
        TV_REQ_ADDR <= SMEM_TV_IN_BASEADDR+tv_req_cnt*4;
      end else begin
        TV_REQ_ADDR <= TV_REQ_ADDR;
      end
      TV_REQ_WR_EN <= TV_REQ_READY;
    end else begin
      TV_REQ_ADDR <= 0;
      TV_REQ_WR_EN <= 0;
    end
  end
end : tv_req_addr_gen_wr_en_gen


always_ff @(posedge i_clk) begin : tv_in_rd_en_gen
  if (i_rst == 1) begin
    TV_IN_FIFO_RD_EN <= 0;
  end else begin
    if (state == SEND_TV_IN && tv_in_sent == 0) begin
      TV_IN_FIFO_RD_EN  <= task_data_request;
    end else begin
      TV_IN_FIFO_RD_EN  <= 0;
    end
  end
end : tv_in_rd_en_gen


always_ff @(posedge i_clk) begin : tv_req_cnt_sent_control
  case (state)
    default: begin
      tv_req_cnt  <= 0;
      tv_req_sent <= 0;
    end
    SEND_TV_IN: begin
      if (TV_REQ_READY == 1)
        if (tv_req_cnt < tasks_params_array[granted_task_number].TV_IN_NUM_TRANSACTIONS-1) begin
          tv_req_cnt <= tv_req_cnt + 1;
          tv_req_sent <= 0;
        end else begin
          tv_req_cnt <= tv_req_cnt;
          tv_req_sent <= 1;
        end
    end
  endcase
end : tv_req_cnt_sent_control


always_ff @(posedge i_clk) begin : tv_in_cnt_sent_last_control
  case (state)
    default: begin
      tv_in_cnt   <= 0;
      tv_in_sent  <= 0;
      tv_in_last  <= 0;
    end
    SEND_TV_IN: begin
      if (TV_IN_FIFO_RD_EN == 1 && TV_IN_FIFO_NOT_EMPTY == 1)
        if (tv_in_cnt < tasks_params_array[granted_task_number].TV_IN_BYTES-1) begin
          tv_in_cnt <= tv_in_cnt + 1;
          tv_in_sent <= 0;
          tv_in_last <= 0;
        end else begin
          tv_in_cnt <= tv_in_cnt;
          tv_in_sent <= 1;
          tv_in_last <= 1;
        end
      else begin
        if (tv_in_cnt == tasks_params_array[granted_task_number].TV_IN_BYTES-1)
          tv_in_last <= 0; 
      end
    end
  endcase
end : tv_in_cnt_sent_last_control


always_ff @(posedge i_clk) begin : tv_out_cnt_sent_control
  case (state)
    default: begin
      tv_out_cnt  <= 0;
      tv_out_sent <= 0;
      TV_OUT_ADDR <= SMEM_TV_OUT_BASEADDR;
    end
    SEND_TV_OUT: begin
      // if (tv_out_wr_en_reg[3])
      //   if (tv_out_cnt < tasks_params_array[granted_task_number].TV_OUT_NUM_TRANSACTIONS) begin
      //     tv_out_cnt <= tv_out_cnt + 1;
      //     tv_out_sent <= 0;
      //     TV_OUT_ADDR <= SMEM_TV_OUT_BASEADDR+tv_out_cnt*4;
      //   end else begin
      //     tv_out_cnt <= tv_out_cnt;
      //     tv_out_sent <= 1;
      //   end
      if (tv_out_cnt < tasks_params_array[granted_task_number].TV_OUT_NUM_TRANSACTIONS) begin
        if (tv_out_wr_en_reg[3]) begin
          tv_out_cnt <= tv_out_cnt + 1;
          tv_out_sent <= 0;
          TV_OUT_ADDR <= SMEM_TV_OUT_BASEADDR+tv_out_cnt*4;
        end else begin
          tv_out_cnt  <= tv_out_cnt;
          tv_out_sent <= tv_out_sent;
          TV_OUT_ADDR <= TV_OUT_ADDR;
        end
      end else begin
        tv_out_cnt  <= tv_out_cnt;
        tv_out_sent <= 1;
        TV_OUT_ADDR <= TV_OUT_ADDR;
      end
    end
  endcase
end : tv_out_cnt_sent_control


always_ff @(posedge i_clk) begin : fsm_next_state
  if (i_rst)
    state <= IDLE;
  else
    state <= next_state;
end : fsm_next_state

endmodule
