`timescale 1ns / 1ps
//----------------------------------------------------------------------------------------
// TASK 10: Dot product
// 
//----------------------------------------------------------------------------------------

module dot_prod
#(  parameter DATA_WIDTH_IN = 16,
    parameter DATA_WIDTH_OUT = 38,
    parameter N_IN = 8
)
(
        input i_clk,
        input i_rst,
        input i_valid,
        input [DATA_WIDTH_IN-1:0] i_data[N_IN],
        output [DATA_WIDTH_OUT-1:0] o_data,
        output o_valid
    );
    
    // wire [DATA_WIDTH_IN+2-1:0] w_prod_0 [N_IN];
    wire [2*(DATA_WIDTH_IN+2)-1:0] w_prod_1 [N_IN/2];
    // wire [2*(DATA_WIDTH_IN+2):0] w_sum [N_IN/4];
    wire [2*(DATA_WIDTH_IN+2)+1:0]  w_data;
    wire [2*(DATA_WIDTH_IN+2)+1:0]  w_data_prod;
    
    reg [DATA_WIDTH_OUT-1:0] r_data_out = 0;
    reg  r_valid = 0;
    
    genvar i;

    
    // // Multiplication stage 0
    // generate
    //     for(i=0;i<N_IN;i++) begin: multiplication_stage_0
    //         assign w_prod_0[i] = i_data[i] * 3;
    //     end
    // endgenerate
    
     // Multiplication stage 1 
    generate
        for(i=0;i<N_IN/2;i++) begin: multiplication_stage_1
            assign w_prod_1[i] = i_data[i] * i_data[i + 4];
        end
    endgenerate
    
    // // Addiiton stage 0
    // generate
    //     for(i=0;i<N_IN/4;i++) begin: addition_stage_0
    //         assign w_sum[i] = w_prod_1[2*i] + w_prod_1[2*i+1];
    //     end
    // endgenerate
    
    // Addiiton stage 1
    assign w_data = w_prod_1[0] + w_prod_1[1] + w_prod_1[2] + w_prod_1[3];
    assign w_data_prod = 9 * w_data;
    
    // Zero padding the output
    always@(posedge i_clk) begin
        if(i_rst)
            r_data_out <= '0;
        else
            r_data_out <= w_data_prod;  
    end
    
    assign o_data = r_data_out;
    
    // Valid output is the input enable signal delayed by one clock cycles, 
    // because dot product operation takes one clock cycle.
    always@(posedge i_clk) begin
        if(i_rst)
            r_valid <= 0;
        else 
            r_valid <= i_valid;
    end
    
    assign o_valid = r_valid;
    
endmodule
