// -------------------------------------------------------------
// 
// File Name: hdlsrc/cos_sin_CORDIC/Rotation_Cell_2.v
// Created: 2024-04-21 00:20:10
// 
// Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: Rotation_Cell_2
// Source Path: cos_sin_CORDIC/DUT_CORDIC/ALGORITHM/Rotation _Cell_2
// Hierarchy Level: 2
// Model version: 2.31
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module Rotation_Cell_2
          (X_In,
           Y_In,
           Z_In,
           X_Out,
           Y_Out,
           Z_Out);


  input   signed [14:0] X_In;  // sfix15_En12
  input   signed [14:0] Y_In;  // sfix15_En12
  input   signed [19:0] Z_In;  // sfix20_En12
  output  signed [14:0] X_Out;  // sfix15_En12
  output  signed [14:0] Y_Out;  // sfix15_En12
  output  signed [19:0] Z_Out;  // sfix20_En12


  wire Bit_Slice_out1;  // ufix1
  wire Logical_Operator_out1;
  wire signed [14:0] Bit_Shift1_out1;  // sfix15_En12
  wire signed [15:0] Unary_Minus1_cast;  // sfix16_En12
  wire signed [15:0] Unary_Minus1_cast_1;  // sfix16_En12
  wire signed [14:0] Unary_Minus1_out1;  // sfix15_En12
  wire signed [14:0] Switch1_out1;  // sfix15_En12
  wire signed [14:0] Add_out1;  // sfix15_En12
  wire signed [14:0] Bit_Shift_out1;  // sfix15_En12
  wire signed [15:0] Unary_Minus2_cast;  // sfix16_En12
  wire signed [15:0] Unary_Minus2_cast_1;  // sfix16_En12
  wire signed [14:0] Unary_Minus2_out1;  // sfix15_En12
  wire signed [14:0] Switch2_out1;  // sfix15_En12
  wire signed [14:0] Add1_out1;  // sfix15_En12
  wire signed [19:0] Constant_out1;  // sfix20_En12
  wire signed [20:0] Unary_Minus_cast;  // sfix21_En12
  wire signed [20:0] Unary_Minus_cast_1;  // sfix21_En12
  wire signed [19:0] Unary_Minus_out1;  // sfix20_En12
  wire signed [19:0] Switch_out1;  // sfix20_En12
  wire signed [19:0] Add2_out1;  // sfix20_En12


  assign Bit_Slice_out1 = Z_In[19];


  assign Logical_Operator_out1 =  ~ Bit_Slice_out1;


  assign Bit_Shift1_out1 = Y_In >>> 8'd2;


  assign Unary_Minus1_cast = {Bit_Shift1_out1[14], Bit_Shift1_out1};
  assign Unary_Minus1_cast_1 =  - (Unary_Minus1_cast);
  assign Unary_Minus1_out1 = Unary_Minus1_cast_1[14:0];


  assign Switch1_out1 = (Logical_Operator_out1 == 1'b0 ? Bit_Shift1_out1 :
              Unary_Minus1_out1);


  assign Add_out1 = X_In + Switch1_out1;


  assign X_Out = Add_out1;

  assign Bit_Shift_out1 = X_In >>> 8'd2;


  assign Unary_Minus2_cast = {Bit_Shift_out1[14], Bit_Shift_out1};
  assign Unary_Minus2_cast_1 =  - (Unary_Minus2_cast);
  assign Unary_Minus2_out1 = Unary_Minus2_cast_1[14:0];


  assign Switch2_out1 = (Bit_Slice_out1 == 1'b0 ? Bit_Shift_out1 :
              Unary_Minus2_out1);


  assign Add1_out1 = Y_In + Switch2_out1;


  assign Y_Out = Add1_out1;

  assign Constant_out1 = 20'sb00001110000010010100;


  assign Unary_Minus_cast = {Constant_out1[19], Constant_out1};
  assign Unary_Minus_cast_1 =  - (Unary_Minus_cast);
  assign Unary_Minus_out1 = Unary_Minus_cast_1[19:0];


  assign Switch_out1 = (Logical_Operator_out1 == 1'b0 ? Constant_out1 :
              Unary_Minus_out1);


  assign Add2_out1 = Z_In + Switch_out1;


  assign Z_Out = Add2_out1;

endmodule  // Rotation_Cell_2
