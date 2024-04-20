`timescale 1ns / 1ps

module task_12_serializer #(
    parameter DATA_WIDTH = 32,
    parameter N_OUT = 3
)   (
        input i_clk,
        input i_rst,
        input [DATA_WIDTH-1:0] i_data [N_OUT],
        input i_valid,
        output [DATA_WIDTH-1:0] o_data,
        output o_valid
    );
    
    reg [DATA_WIDTH-1:0] r_buffer [N_OUT] = '{default:0};
    reg [N_OUT-1:0] r_valid_del = 0;
    reg [DATA_WIDTH-1:0] r_output_data = 0;
    reg r_valid_output = 0;
    genvar i;
    
    generate
        for(i=0;i<N_OUT;i++) begin: capture_input
            always@(posedge i_clk) begin
                if(i_rst)
                    r_buffer[i] <= 0;
                else if(i_valid)
                    r_buffer[i] <= i_data[i];                   
            end
        end
    endgenerate
    
    always@(posedge i_clk) begin
        if(i_rst)
            r_valid_del[0] <= 0;
        else
            r_valid_del[0] <= i_valid;            
    end
    
    generate
        for(i=1;i<N_OUT;i++) begin: input_valid_del
            always@(posedge i_clk) begin
                if(i_rst)
                    r_valid_del[i] <= 0;
                else
                    r_valid_del[i] <= r_valid_del[i-1];
            end
        end
    endgenerate
    
    always@(posedge i_clk) begin
        case(r_valid_del)
            3'b000: r_output_data <= 0;
            3'b001: r_output_data <= r_buffer[0];
            3'b010: r_output_data <= r_buffer[1];
            3'b100: r_output_data <= r_buffer[2];
            default: r_output_data <= 0;
        endcase
    end
    
    always@(posedge i_clk) begin
        if(i_rst)
            r_valid_output <= 1'b0;
        else if(r_valid_del > 0)
            r_valid_output <= 1'b1;
        else
            r_valid_output <= 1'b0;                       
    end
    
    assign o_data = r_output_data;
    assign o_valid = r_valid_output;
    
endmodule
