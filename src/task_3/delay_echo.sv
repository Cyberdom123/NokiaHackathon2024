`timescale 1ns / 1ps
//----------------------------------------------------------------------------------------
// TASK 3: Echo 
// 
//----------------------------------------------------------------------------------------

module delay_echo #(
parameter DATA_WIDTH_IN = 32,
parameter DATA_WIDTH_OUT = 32
)(
        input i_clk,
        input i_rst,
        input i_valid,
        input [DATA_WIDTH_IN-1:0] i_data,
        output o_valid,
        output [DATA_WIDTH_OUT-1:0] o_data
    );

localparam DELAY_MAX = 100;
reg [DATA_WIDTH_OUT-1:0]tdata [DELAY_MAX:0];
reg delay_valid [DELAY_MAX:0];
reg loaded_delay=1'b0;
reg [DATA_WIDTH_OUT-1:0]idx;

reg [DATA_WIDTH_OUT-1:0]o_data_w;
reg o_valid_w;


always @(posedge i_clk)
begin
    if (i_rst)
    begin
        loaded_delay=1'b0;
        idx=32'b0;
        o_data_w=32'b0;
        o_valid_w=1'b0;
        tdata[0]<=32'b0;
        delay_valid[0]<=1'b0;
    end
    else
    begin
        if(!loaded_delay && i_valid)
        begin
            loaded_delay<=1'b1;
            idx<=i_data;
            tdata[0]<=32'b0;
            delay_valid[0]<=1'b0;
        end
        else if (loaded_delay)
        begin
            if (i_valid)
            begin
                o_data_w<=tdata[idx-2];
                o_valid_w<=delay_valid[idx-2];
                tdata[0]<=i_data;
                delay_valid[0]<=i_valid;
            end
            else
            begin
                o_data_w<=tdata[idx-2];
                o_valid_w<=delay_valid[idx-2];
                tdata[0]<=i_data;
                delay_valid[0]<=i_valid;
            end
        end
    end
end

assign o_data = o_data_w;
assign o_valid = o_valid_w;


genvar i;
generate
    for(i=0;i<DELAY_MAX;i=i+1)
    begin   
        register #(
            .N(DATA_WIDTH_IN)
        ) register_i (
            .clk(i_clk),
            .ce(1'b1),
            .rst(i_rst),
            .d(tdata[i]),
            .q(tdata[i+1])
        );
    end
endgenerate

genvar j;
generate
    for(j=0;j<DELAY_MAX;j=j+1)
    begin   
        register #(
            .N(DATA_WIDTH_IN)
        ) valid_i (
            .clk(i_clk),
            .ce(1'b1),
            .rst(i_rst),
            .d(delay_valid[j]),
            .q(delay_valid[j+1])
        );
    end
endgenerate
   
endmodule

