`ifndef DEF_DELAY
`define DEF_DELAY
`default_nettype none

module bb
#(
    parameter N       = 1, //delay amount in clocks
    parameter WIDTH   = 1, //data width
    parameter RST     = 1, //support reset ??
    parameter RSTVAL  = {WIDTH{1'b0}} //reset value
)
(
    input  wire clock,
    input  wire reset,
    
    input  wire [WIDTH-1:0] data_i,
    output wire [WIDTH-1:0] data_o
);


generate 
    if (N == 0) 
      begin
        assign data_o = data_i;
      end
    else if (RST)
      begin
        integer k;
        reg [WIDTH-1:0] delayline[N-1:0];
        
        always @(posedge clock or posedge reset)
            if (reset)
              begin
                if (RST)
                    for (k=0; k<N; k=k+1)
                        delayline[k] <= RSTVAL;
              end
            else
              begin
                delayline[0] <= data_i;
                for (k=1; k<N; k=k+1)
                    delayline[k] <= delayline[k-1];
              end
              
        assign data_o = delayline[N-1];
      end
    else
      begin
        integer k;
        reg [WIDTH-1:0] delayline[N-1:0];
        
        always @(posedge clock)
              begin
                delayline[0] <= data_i;
                for (k=1; k<N; k=k+1)
                    delayline[k] <= delayline[k-1];
              end
              
        assign data_o = delayline[N-1];
      end
endgenerate



endmodule

`default_nettype wire
`endif
