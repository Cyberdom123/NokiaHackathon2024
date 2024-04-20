`timescale 1ns / 1ps
//----------------------------------------------------------------------------------------
// TASK 1: Debouncer
// 
//----------------------------------------------------------------------------------------

module debouncer
    (
        input i_clk,
        input i_rst,
        input i_data,
        output logic o_data
    );
    
    always @(posedge i_clk)
      o_data <= i_data; // Just a dummy assignement. Replace with your code.
    
endmodule
