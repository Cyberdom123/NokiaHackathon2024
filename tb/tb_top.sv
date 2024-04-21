`timescale 1ns / 1ps
`define ZYNQ_VIP_0 tb_top.mpsoc_sys.design_1_i.zynq_ultra_ps_e_0.inst

module tb_top;

// SET YOUR TASK HERE!
`define TASK_1
`define TASK_2
`define TASK_3
//`define TASK_4
`define TASK_5
//`define TASK_6
//`define TASK_7
//`define TASK_8
//`define TASK_9
`define TASK_10
//`define TASK_11
//`define TASK_12
//`define TASK_13
//`define TASK_14
//`define TASK_15

`ifdef TASK_1
    localparam N_SAMPLES_IN = 250;
    localparam N_SAMPLES_OUT = 250;
    localparam TASK_NUMBER = 1;
    localparam DATA_WIDTH_OUT = 8;
    localparam NUM_WORDS_OUT = 1000;
    localparam TOLERANCE_MASK = {DATA_WIDTH_OUT{1'b1}};
`elsif TASK_2
    localparam N_SAMPLES_IN = 64;
    localparam N_SAMPLES_OUT = 128;
    localparam TASK_NUMBER = 2;
    localparam DATA_WIDTH_OUT = 16;
    localparam NUM_WORDS_OUT = 256;
    localparam TOLERANCE_MASK = {DATA_WIDTH_OUT{1'b1}};
`elsif TASK_3
    localparam N_SAMPLES_IN = 128;
    localparam N_SAMPLES_OUT = 128;
    localparam TASK_NUMBER = 3;
    localparam DATA_WIDTH_OUT = 32;
    localparam NUM_WORDS_OUT = 128;
    localparam TOLERANCE_MASK = {DATA_WIDTH_OUT{1'b1}};
`elsif TASK_4
    localparam N_SAMPLES_IN = 367;
    localparam N_SAMPLES_OUT = 256;
    localparam TASK_NUMBER = 4;
    localparam DATA_WIDTH_OUT = 16;
    localparam NUM_WORDS_OUT = 512;
    localparam TOLERANCE_MASK = {DATA_WIDTH_OUT{1'b1}};
`elsif TASK_5
    localparam N_SAMPLES_IN = 128;
    localparam N_SAMPLES_OUT = 128;
    localparam TASK_NUMBER = 5;
    localparam DATA_WIDTH_OUT = 32;
    localparam NUM_WORDS_OUT = 128;
    localparam TOLERANCE_MASK = {DATA_WIDTH_OUT{1'b1}};
`elsif TASK_6
    localparam N_SAMPLES_IN = 350;
    localparam N_SAMPLES_OUT = 5;
    localparam TASK_NUMBER = 6;
    localparam DATA_WIDTH_OUT = 32;
    localparam NUM_WORDS_OUT = 5;
    localparam TOLERANCE_MASK = {DATA_WIDTH_OUT{1'b1}};
`elsif TASK_7
    localparam N_SAMPLES_IN = 256;
    localparam N_SAMPLES_OUT = 1;
    localparam TASK_NUMBER = 7;
    localparam DATA_WIDTH_OUT = 32;
    localparam NUM_WORDS_OUT = 1;
    localparam TOLERANCE_MASK = {DATA_WIDTH_OUT{1'b1}};
`elsif TASK_8
    localparam N_SAMPLES_IN = 2;
    localparam N_SAMPLES_OUT = 2;
    localparam TASK_NUMBER = 8;
    localparam DATA_WIDTH_OUT = 8;
    localparam NUM_WORDS_OUT = 8;
    localparam TOLERANCE_MASK = {DATA_WIDTH_OUT{1'b1}};
`elsif TASK_9    
    localparam N_SAMPLES_IN = 2;
    localparam N_SAMPLES_OUT = 2;
    localparam TASK_NUMBER = 9;   
    localparam DATA_WIDTH_OUT = 8;
    localparam NUM_WORDS_OUT = 8;
    localparam TOLERANCE_MASK = {DATA_WIDTH_OUT{1'b1}};
`elsif TASK_10    
    localparam N_SAMPLES_IN = 128;
    localparam N_SAMPLES_OUT = 64;
    localparam TASK_NUMBER = 10;
    localparam DATA_WIDTH_OUT = 64;
    localparam NUM_WORDS_OUT = 32;
    localparam TOLERANCE_MASK = {DATA_WIDTH_OUT{1'b1}};
`elsif TASK_11    
    localparam N_SAMPLES_IN = 16;
    localparam N_SAMPLES_OUT = 1;
    localparam TASK_NUMBER = 11;
    localparam DATA_WIDTH_OUT = 32;
    localparam NUM_WORDS_OUT = 1;
    localparam TOLERANCE_MASK = {DATA_WIDTH_OUT{1'b1}};
`elsif TASK_12    
    localparam N_SAMPLES_IN = 2;
    localparam N_SAMPLES_OUT = 3;
    localparam TASK_NUMBER = 12;
    localparam DATA_WIDTH_OUT = 32;
    localparam NUM_WORDS_OUT = 3; 
    localparam TOLERANCE_MASK = 32'b11111111111111111100000000000000;
`elsif TASK_13  
    localparam N_SAMPLES_IN = 1;
    localparam N_SAMPLES_OUT = 2;
    localparam TASK_NUMBER = 13;
    localparam DATA_WIDTH_OUT = 16;
    localparam NUM_WORDS_OUT = 4;
    localparam TOLERANCE_MASK = 16'b1111111111111000;
`elsif TASK_14  
    localparam N_SAMPLES_IN = 4;
    localparam N_SAMPLES_OUT = 8;
    localparam TASK_NUMBER = 14;
    localparam DATA_WIDTH_OUT = 16;
    localparam NUM_WORDS_OUT = 16;
    localparam TOLERANCE_MASK = 16'b1111111111111000;
`elsif TASK_15  
    localparam N_SAMPLES_IN = 25;
    localparam N_SAMPLES_OUT = 25;
    localparam TASK_NUMBER = 15;
    localparam DATA_WIDTH_OUT = 16;
    localparam NUM_WORDS_OUT = 25;
    localparam TOLERANCE_MASK = {DATA_WIDTH_OUT{1'b1}};
`endif

reg resp;
reg [31:0] readdata;
reg [31:0] task_in [0:N_SAMPLES_IN-1];
reg [31:0] task_ref [0:N_SAMPLES_OUT-1];
reg [63:0] task_10_ref [0:N_SAMPLES_OUT-1];
reg [31:0] captured_data [0:N_SAMPLES_OUT-1];
reg [DATA_WIDTH_OUT-1:0] task_out[0:NUM_WORDS_OUT-1];

localparam TASK_1_TICKS = 1;
int tick_count = 0;
int err_count = 0;
int j;

localparam logic [31:0] SMEM_BASEADDR   = 32'hA000_0000;
localparam logic [31:0] TASK_IN_OFFSET  = SMEM_BASEADDR;
localparam logic [31:0] TASK_OUT_OFFSET = SMEM_BASEADDR + 32'h800;
localparam logic [31:0] TV_IN_READY     = SMEM_BASEADDR + 32'h1_000C;
localparam logic [31:0] PL_READY        = SMEM_BASEADDR + 32'h1_0000;
localparam logic [31:0] TV_OUT_READY    = SMEM_BASEADDR + 32'h1_0010;
localparam logic [31:0] ENABLED_TASKS   = SMEM_BASEADDR + 32'h1_0004;
localparam logic [31:0] CURRENT_TASK    = SMEM_BASEADDR + 32'h1_0008;

initial
begin
    $display ("running the tb");
case(TASK_NUMBER)
    1:begin
        $readmemh("task1.mem", task_in);
    end
    2:begin
        $readmemh("task2.mem", task_in);
        $readmemh("task2_ref.mem", task_ref);
    end
    3:begin
        $readmemh("task3.mem", task_in);
        $readmemh("task3_ref.mem", task_ref);
    end
    4:begin
        $readmemh("task4.mem", task_in);
        $readmemh("task4_ref.mem", task_ref);
    end
    5:begin
        $readmemh("task5.mem", task_in);
    end
    6:begin
        $readmemh("task6.mem", task_in);
        $readmemh("task6_ref.mem", task_ref);
    end
    7:begin
        $readmemh("task7.mem", task_in);
        $readmemh("task7_ref.mem", task_ref);
    end
    8:begin
        $readmemh("task8.mem", task_in);
        $readmemh("task8_ref.mem", task_ref);
    end
    9:begin  
        $readmemh("task9.mem", task_in);
        $readmemh("task9_ref.mem", task_ref);
    end
    10:begin    
        $readmemh("task10.mem", task_in);
        $readmemh("task10_ref.mem", task_10_ref);
    end
    11:begin    
        $readmemh("task11.mem", task_in);
        $readmemh("task11_ref.mem", task_ref);
    end
    12:begin  
        $readmemh("task12.mem", task_in);
        $readmemh("task12_ref.mem", task_ref);
    end
    13:begin  
        $readmemh("task13.mem", task_in);
        $readmemh("task13_ref.mem", task_ref);
    end
    14:begin  
        $readmemh("task14.mem", task_in);
        $readmemh("task14_ref.mem", task_ref);
    end
    15:begin   
        $readmemh("task15.mem", task_in);
    end

endcase
      
    `ZYNQ_VIP_0.por_srstb_reset(1'b1);
    #200;
    `ZYNQ_VIP_0.por_srstb_reset(1'b0);
    `ZYNQ_VIP_0.fpga_soft_reset(4'hf);
    #16;  // minimum 16 clock cycles.
    `ZYNQ_VIP_0.por_srstb_reset(1'b1);
    `ZYNQ_VIP_0.fpga_soft_reset(4'h0);
    
    // Set debug level info to off. For more info, set to 1.
    `ZYNQ_VIP_0.set_debug_level_info(0);
    `ZYNQ_VIP_0.M_AXI_HPM0_FPD.master.IF.set_xilinx_reset_check_to_warn();
    `ZYNQ_VIP_0.set_stop_on_error(1);
    // Set minimum port verbosity. Change to 32'd400 for maximum.
    `ZYNQ_VIP_0.M_AXI_HPM0_FPD.set_verbosity(32'd0);      
    
     #2000ns;
    while(1) begin
        `ZYNQ_VIP_0.read_data(PL_READY, 4, readdata, resp);
        if (resp != 0 || readdata != 1) 
            continue;
        else
            break;
    end

    for (int i=0; i<N_SAMPLES_IN; i++) begin
        `ZYNQ_VIP_0.write_data(TASK_IN_OFFSET+4*i, 4, task_in[i], resp);
    end
    `ZYNQ_VIP_0.write_data(CURRENT_TASK, 4, TASK_NUMBER, resp);
    `ZYNQ_VIP_0.write_data(TV_IN_READY, 4, 32'h0000_0001, resp);
    
    while(1) begin
        //#1us;
        `ZYNQ_VIP_0.read_data(TV_OUT_READY, 4, readdata, resp);
        if (resp != 0 || readdata != 1) 
            continue;
        else
            break;
    end
    
    for (int i=0; i<N_SAMPLES_OUT; i++) begin
        `ZYNQ_VIP_0.read_data(TASK_OUT_OFFSET+4*i, 4, readdata, resp);
    if(TASK_NUMBER == 1) begin   
        for(int j=0; j<32; j++)
            tick_count = tick_count + readdata[j];
        err_count = tick_count - TASK_1_TICKS;
     end else 
        captured_data[i] = readdata;
    end
    
    j = 0;
    case(TASK_NUMBER)
        2: begin  
            for(int i=0; i<NUM_WORDS_OUT; i=i+32/DATA_WIDTH_OUT) begin
                task_out[i] = captured_data[j][15:0];
                check_data(task_out[i], task_ref[j][15:0], i);
                task_out[i+1] = captured_data[j][31:16];
                check_data(task_out[i+1], task_ref[j][31:16], i+1);   
                j = j + 1;
            end
        end
        3: begin
            for(int i=0; i<NUM_WORDS_OUT; i=i+32/DATA_WIDTH_OUT) begin
                task_out[i] = captured_data[j][31:0];
                check_data(task_out[i], task_ref[j][31:0], i);  
                j = j + 1;
            end
        end 
        6: begin
            for(int i=0; i<NUM_WORDS_OUT; i=i+32/DATA_WIDTH_OUT) begin
                task_out[i] = captured_data[j][31:0];
                check_data(task_out[i], task_ref[j][31:0], i);  
                j = j + 1;
            end
        end 
        7: begin
            for(int i=0; i<NUM_WORDS_OUT; i=i+32/DATA_WIDTH_OUT) begin
                task_out[i] = captured_data[j][31:0];
                check_data(task_out[i], task_ref[j][31:0], i);  
                j = j + 1;
            end
        end
        8: begin
            for(int i=0; i<NUM_WORDS_OUT; i=i+32/DATA_WIDTH_OUT) begin
                task_out[i] = captured_data[j][7:0];
                check_data(task_out[i], task_ref[j][7:0], i);  
                task_out[i+1] = captured_data[j][15:8];
                check_data(task_out[i+1], task_ref[j][15:8], i+1);
                task_out[i+2] = captured_data[j][23:16];
                check_data(task_out[i+2], task_ref[j][23:16], i+2);  
                task_out[i+3] = captured_data[j][31:24];
                check_data(task_out[i+3], task_ref[j][31:24], i+3); 
                j = j + 1;
            end
        end
        9: begin
            for(int i=0; i<NUM_WORDS_OUT; i=i+32/DATA_WIDTH_OUT) begin
                task_out[i] = captured_data[j][7:0];
                check_data(task_out[i], task_ref[j][7:0], i);  
                task_out[i+1] = captured_data[j][15:8];
                check_data(task_out[i+1], task_ref[j][15:8], i+1);
                task_out[i+2] = captured_data[j][23:16];
                check_data(task_out[i+2], task_ref[j][23:16], i+2);  
                task_out[i+3] = captured_data[j][31:24];
                check_data(task_out[i+3], task_ref[j][31:24], i+3); 
                j = j + 1;
            end
        end
        10: begin  
            for(int i=0; i<NUM_WORDS_OUT; i++) begin
                task_out[i][31:0] = captured_data[j][31:0];
                task_out[i][63:32] = captured_data[j+1][31:0];
                check_data(task_out[i], 9*task_10_ref[i][63:0], i);   
                j = j + 2;
            end
        end
        11: begin  
                task_out[0][31:0] = captured_data[0][31:0];
                check_data(task_out[0], task_ref[0][31:0], 0);   
        end
        12: begin
            for(int i=0; i<NUM_WORDS_OUT; i=i+32/DATA_WIDTH_OUT) begin
                task_out[i] = captured_data[j][31:0];
                check_data(task_out[i], task_ref[j][31:0], i);  
                j = j + 1;
            end
        end
        13: begin  
            for(int i=0; i<NUM_WORDS_OUT; i=i+32/DATA_WIDTH_OUT) begin
                task_out[i] = captured_data[j][15:0];
                check_data(task_out[i], task_ref[j][15:0], i);
                task_out[i+1] = captured_data[j][31:16];
                check_data(task_out[i+1], task_ref[j][31:16], i+1);   
                j = j + 1;
            end
        end 
        14: begin  
            for(int i=0; i<NUM_WORDS_OUT; i=i+32/DATA_WIDTH_OUT) begin
                task_out[i] = captured_data[j][15:0];
                check_data(task_out[i], task_ref[j][15:0], i);
                task_out[i+1] = captured_data[j][31:16];
                check_data(task_out[i+1], task_ref[j][31:16], i+1);   
                j = j + 1;
            end
        end           
    endcase
        
        
        
    $display("---------------------------------------------");
    $display("----          TESTBENCH RESULTS          ----");
    $display("---------------------------------------------");
        
    if(TASK_NUMBER != 5 && TASK_NUMBER != 15 && TASK_NUMBER != 4) begin
        if (err_count > 0) begin
            $display("TEST FAILED!");
            $display("NUMBER OF MISMATCHES: %d", err_count);
        end else begin
            $display("TEST PASSED!");
        end
        if(TASK_NUMBER == 1) begin
            $display("REFERENCE NUMBER OF TICKS: %d", TASK_1_TICKS);
            $display("CAPTURED NUMBER OF TICKS: %d", tick_count);
        end
    end else begin
        $display("THERE IS NO REFERENCE DATA FOR THIS TASK");
    end
        
    #10us $display("Testbench finished");   
    $finish;
   

end

    design_1_wrapper mpsoc_sys();

function check_data(input reg [DATA_WIDTH_OUT-1:0] task_out_i, input reg [DATA_WIDTH_OUT-1:0] task_ref_j, input int i);
    if((task_out_i & TOLERANCE_MASK) != (task_ref_j & TOLERANCE_MASK)) begin
        $display("TASK_OUT[%d]: %h | TASK_REF[%d]: %h | MISMATCH!", i, task_out_i, i, task_ref_j);
        err_count++;
    end else
        $display("TASK_OUT[%d]: %h | TASK_REF[%d]: %h | OK!", i, task_out_i, i, task_ref_j);
endfunction

endmodule
