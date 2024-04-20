`timescale 1 ns / 1 ns
//----------------------------------------------------------------------------------------
// TASK 2: Digital circuit
// 
//----------------------------------------------------------------------------------------

module digital_circuit #(
    parameter DATA_WIDTH_IN = 8,
    parameter DATA_WIDTH_OUT = 16
)
(
        input i_clk,
        input i_rst,
        input i_valid,
        input [DATA_WIDTH_IN-1:0] i_data,
        output logic o_valid,
        output logic [DATA_WIDTH_OUT-1:0] o_data
    );

    reg [DATA_WIDTH_OUT-1:0]accumulated=0;

    always @(posedge i_clk)
    begin
        if(i_rst)
        begin
            accumulated<=0;
        end else
        begin
            if(i_valid)
            begin
                accumulated<=accumulated+i_data;
            end
        end
    end
  
    assign o_valid = i_valid;
    assign o_data = accumulated >> 1;
endmodule

