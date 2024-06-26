// -------------------------------------------------------------
// 
// File Name: hdl_prj/hdlsrc/Task_6_template/Algorithm.v
// Created: 2024-04-21 07:44:44
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: Algorithm
// Source Path: Task_6_template/DUT/Algorithm
// Hierarchy Level: 1
// Model version: 1.107
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module Algorithm
          (clk,
           reset,
           pre,
           Enable,
           outBuff,
           detected);


  input   clk;
  input   reset;
  input   signed [24:0] pre;  // sfix25_En16
  input   Enable;
  output  signed [7:0] outBuff;  // int8
  output  detected;


  wire Enable_out2;
  reg signed [24:0] Delay_out1;  // sfix25_En16
  reg signed [24:0] Delay1_out1;  // sfix25_En16
  wire signed [7:0] val;  // int8
  wire detected_1;
  wire signed [7:0] Constant_out1;  // int8
  wire signed [7:0] Subtract_out1;  // int8
  reg signed [7:0] Subtract_out1_hold;  // int8
  reg  Data_Type_Conversion_out1_hold;


  assign Enable_out2 = Enable;

  always @(posedge clk)
    begin : Delay_process
      if (reset == 1'b1) begin
        Delay_out1 <= 25'sb0000000000000000000000000;
      end
      else begin
        if (Enable_out2) begin
          Delay_out1 <= pre;
        end
      end
    end



  always @(posedge clk)
    begin : Delay1_process
      if (reset == 1'b1) begin
        Delay1_out1 <= 25'sb0000000000000000000000000;
      end
      else begin
        if (Enable_out2) begin
          Delay1_out1 <= Delay_out1;
        end
      end
    end



  MATLAB_Function u_MATLAB_Function (.x0(Delay1_out1),  // sfix25_En16
                                     .x1(Delay_out1),  // sfix25_En16
                                     .x2(pre),  // sfix25_En16
                                     .val(val),  // int8
                                     .detected(detected_1)
                                     );

  assign Constant_out1 = 8'sb00000101;



  assign Subtract_out1 = val - Constant_out1;



  always @(posedge clk)
    begin : outBuff_hold_process
      if (reset == 1'b1) begin
        Subtract_out1_hold <= 8'sb00000000;
      end
      else begin
        if (Enable_out2) begin
          Subtract_out1_hold <= Subtract_out1;
        end
      end
    end



  assign outBuff = Subtract_out1_hold;

  always @(posedge clk)
    begin : detected_hold_process
      if (reset == 1'b1) begin
        Data_Type_Conversion_out1_hold <= 1'b0;
      end
      else begin
        if (Enable_out2) begin
          Data_Type_Conversion_out1_hold <= detected_1;
        end
      end
    end



  assign detected = Data_Type_Conversion_out1_hold;

endmodule  // Algorithm

