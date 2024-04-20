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
  output  logic signed [7:0] post;  // int8
  output  logic detected;

    always @(posedge clk) begin
        detected <= enable;	// Just a dummy assignement. Replace with your code.
        post <= pre;		// Just a dummy assignement. Replace with your code.
    end
endmodule

