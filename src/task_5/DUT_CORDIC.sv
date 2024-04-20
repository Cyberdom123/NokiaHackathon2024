`timescale 1 ns / 1 ns
//----------------------------------------------------------------------------------------
// TASK 5: CORDIC 
// 
//----------------------------------------------------------------------------------------

module DUT_CORDIC
          (clk,
           reset,
           data_in,
           enable_in,
           X_out,
           Y_out,
           valid_out);


  input   clk;
  input   reset;
  input   signed [19:0] data_in;  // sfix20_En12
  input   enable_in;
  output  logic [14:0] X_out;
  output  logic [14:0] Y_out;
  output  logic valid_out;
  
  

  always @(posedge clk) begin
    X_out <= data_in[14:0];	// Just a dummy assignement. Replace with your code.
    Y_out <= data_in[14:0];	// Just a dummy assignement. Replace with your code.
    valid_out <= enable_in;	// Just a dummy assignement. Replace with your code.
  end
    

endmodule

