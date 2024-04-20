`timescale 1 ns / 1 ns

module task_15_system
          (  input logic clk,
             input logic reset_x,
             input logic enb,
             input logic signed [15:0] u_port  /* sfix16_En14 */,
             output logic signed [15:0] y_port  /* sfix16_En14 */,
             output o_valid);


  logic signed [15:0] u_sig;  /* sfix16_En14 */
  logic signed [15:0] Delay2_out1;  /* sfix16_En14 */
  logic signed [63:0] s_state_out2;  /* sfix64_En53 */
  logic signed [127:0] nume_gain2_mul_temp;  /* sfix128_En106 */
  logic signed [63:0] s_nume_gain2;  /* sfix64_En53 */
  logic signed [63:0] s_state_out1;  /* sfix64_En53 */
  logic signed [15:0] Data_Type_Conversion1_out1;  /* sfix16_En14 */
  logic signed [15:0] Delay_out1;  /* sfix16_En14 */
  logic signed [16:0] Sum_sub_cast;  /* sfix17_En14 */
  logic signed [16:0] Sum_sub_cast_1;  /* sfix17_En14 */
  logic signed [16:0] Sum_out1;  /* sfix17_En14 */
  logic signed [16:0] Delay3_out1;  /* sfix17_En14 */
  logic signed [63:0] PID_out1;  /* sfix64_En53 */
  logic signed [63:0] Delay1_out1;  /* sfix64_En53 */
  logic signed [63:0] s_denom_acc_out1;  /* sfix64_En53 */
  logic signed [63:0] s_denom_acc_out2;  /* sfix64_En53 */
  logic signed [63:0] s_nume_acc_out1;  /* sfix64_En53 */
  logic signed [63:0] y_sig;  /* sfix64_En53 */


  assign u_sig = u_port;

  always_ff @(posedge clk or posedge reset_x)
    begin : Delay2_process
      if (reset_x == 1'b1) begin
        Delay2_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay2_out1 <= u_sig;
        end
      end
    end



  assign nume_gain2_mul_temp = 64'sh0060000000000000 * s_state_out2;
  assign s_nume_gain2 = nume_gain2_mul_temp[116:53];



  always_ff @(posedge clk or posedge reset_x)
    begin : s_state_out2_1_process
      if (reset_x == 1'b1) begin
        s_state_out2 <= 64'sh0000000000000000;
      end
      else begin
        if (enb) begin
          s_state_out2 <= s_state_out1;
        end
      end
    end



  always_ff @(posedge clk or posedge reset_x)
    begin : Delay_process
      if (reset_x == 1'b1) begin
        Delay_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay_out1 <= Data_Type_Conversion1_out1;
        end
      end
    end



  assign Sum_sub_cast = {Delay2_out1[15], Delay2_out1};
  assign Sum_sub_cast_1 = {Delay_out1[15], Delay_out1};
  assign Sum_out1 = Sum_sub_cast - Sum_sub_cast_1;



  always_ff @(posedge clk or posedge reset_x)
    begin : Delay3_process
      if (reset_x == 1'b1) begin
        Delay3_out1 <= 17'sb00000000000000000;
      end
      else begin
        if (enb) begin
          Delay3_out1 <= Sum_out1;
        end
      end
    end



  UFO u_UFO (.i_clk(clk),
             .i_rst(reset_x),
             .i_enb(enb),
             .i_data(Delay3_out1),  /* sfix17_En14 */
             .o_data(PID_out1),  /* sfix64_En53 */
             .o_valid(o_valid)
             );

  always_ff @(posedge clk or posedge reset_x)
    begin : Delay1_process
      if (reset_x == 1'b1) begin
        Delay1_out1 <= 64'sh0000000000000000;
      end
      else begin
        if (enb) begin
          Delay1_out1 <= PID_out1;
        end
      end
    end



  assign s_denom_acc_out1 = Delay1_out1 - s_state_out1;



  assign s_denom_acc_out2 = s_denom_acc_out1 - s_state_out2;



  always_ff @(posedge clk or posedge reset_x)
    begin : s_state_out1_1_process
      if (reset_x == 1'b1) begin
        s_state_out1 <= 64'sh0000000000000000;
      end
      else begin
        if (enb) begin
          s_state_out1 <= s_denom_acc_out2;
        end
      end
    end



  assign s_nume_acc_out1 = s_state_out1 + s_nume_gain2;



  assign y_sig = s_nume_acc_out1;

  assign Data_Type_Conversion1_out1 = y_sig[54:39];



  assign y_port = Data_Type_Conversion1_out1;

endmodule  // pid_controller

