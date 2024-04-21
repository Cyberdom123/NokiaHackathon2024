`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/06/2024 05:42:53 PM
// Design Name: 
// Module Name: wired_register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module register #
(
    parameter N=8
)
(
    input clk,
    input ce,
    input rst,
    input [N-1:0]d,
    output [N-1:0]q
);
reg [N-1:0]val=1'b0;

always @(posedge clk)
begin
    if(rst) val<=0;
    else if(ce) val<=d;
    else val<=val;
end

assign q=val;

endmodule

module delay #
(
    parameter N=8,
    parameter DELAY=0
)
(
    input [N-1:0]idata,
    input master_clk,
    input master_ce,
    input master_rst,
    output [N-1:0]odata
);

wire [N-1:0]tdata [DELAY:0];

genvar i;
assign tdata[0]=idata;
generate
    if (DELAY==0) begin
        assign odata=idata;
    end else begin
        for(i=0;i<DELAY;i=i+1)
        begin
            register #(.N(N)) register_i
            (
                .clk(master_clk),
                .ce(master_ce),
                .rst(master_rst),
                .d(tdata[i]),
                .q(tdata[i+1])
            );
        end
        assign odata=tdata[DELAY];
    end
endgenerate
    
endmodule
