`timescale 1 ns / 1 ns
//----------------------------------------------------------------------------------------
// TASK 6: Digital filter 
// 
//----------------------------------------------------------------------------------------

module DUT
          (clk,
           reset,
           enable,
           pre,
           post,
           detected);


 input   clk;
  input   reset;
  input   enable;
  input   signed [7:0] pre;  // int8
  output  signed [7:0] post;  // int8
  output  detected;


  reg signed [7:0] pre_1;  // int8
  wire signed [24:0] Filter_out1;  // sfix25_En16
  reg  enable_1;
  wire signed [7:0] post_1;  // int8
  wire Algorithm_out2;


  always @(posedge clk)
    begin : in_1_pipe_process
      if (reset == 1'b1) begin
        pre_1 <= 8'sb00000000;
      end
      else begin
        pre_1 <= pre;
      end
    end



  Filter_block u_Filter (.clk(clk),
                         .reset(reset),
                         .In(pre_1),  // int8
                         .Out(Filter_out1)  // sfix25_En16
                         );

  always @(posedge clk)
    begin : in_0_pipe_process
      if (reset == 1'b1) begin
        enable_1 <= 1'b0;
      end
      else begin
        enable_1 <= enable;
      end
    end



  Algorithm u_Algorithm (.clk(clk),
                         .reset(reset),
                         .pre(Filter_out1),  // sfix25_En16
                         .Enable(enable_1),
                         .outBuff(post_1),  // int8
                         .detected(Algorithm_out2)
                         );

  assign post = post_1;

  assign detected = Algorithm_out2;

endmodule  // DUT
