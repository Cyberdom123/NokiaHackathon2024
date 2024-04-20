`default_nettype none
module nco_ii (
  input  wire                       clk,
  input  wire                       rst,
  input  wire                       clken,
  input  wire  signed [15:0]        phase_incr_i,
  output logic signed [15:0]        cos_o,
  output logic signed [15:0]        sin_o,
  output logic                      out_valid
);


  localparam ADDR_WIDTH = 14; // only 1st quadrant is stored in memory
  localparam DATA_WIDTH = 32;
  localparam MODULUS = 9217;
  localparam V_MODULUS = 36864;

  logic [ADDR_WIDTH-1:0]  raddr = '0;
  logic [ADDR_WIDTH-1:0]  raddr_final;
  logic  rden;
  logic [DATA_WIDTH-1:0]  rddata;
  
  logic unsigned [ADDR_WIDTH+1:0] phase_incr_abs_pre = 0;
  logic unsigned [ADDR_WIDTH+1:0] phase_incr_abs;
  logic phase_incr_is_negative;
  
  logic [15:0] sinpart_out;
  logic [15:0] cospart_out;
  
  logic signed [15:0] phase_incr;
  assign phase_incr = phase_incr_i;
  
  // phase increment absolute value
  always @(posedge clk) begin
    phase_incr_is_negative <= phase_incr_i<0;
    phase_incr_abs <= (phase_incr_is_negative)? (-phase_incr) : phase_incr;
    
  end
  
  // read-enable set when NCO frequency is non-zero
  always @(posedge clk) begin
      rden <= (phase_incr_abs!=0); 
  end
  
  logic [ADDR_WIDTH+1:0] vadr = '0;
  logic [ADDR_WIDTH+1:0] vadr_align = '0;
  logic [1:0] quadrant = '0;
  logic [1:0] quadrant_d = '0;
  logic  overflow;
  logic  overflow_r;
  logic  vld;
  
  assign vld = clken;
  
  always @(posedge clk) begin
      overflow <= ((vadr+phase_incr_abs) > V_MODULUS-1) & rden; // overflow is coming
      if (vld) begin
        // "virtual" address of a sample
        if (overflow) begin  // overflow
        // if ((vadr+phase_incr_abs) > V_MODULUS-1) begin  // overflow
          vadr <= vadr + phase_incr_abs - V_MODULUS;
          overflow <= 1'b0;
        end else
          vadr <= vadr + phase_incr_abs; 
      end
      // detect quadrant based on virtual address
      if (vadr<MODULUS)
        quadrant <= 2'h0;
      else if (vadr<2*MODULUS-2)
        quadrant <= 2'h1;
      else if (vadr<3*MODULUS-3)
        quadrant <= 2'h2;
      else
        quadrant <= 2'h3;
      // align nr of quadrant and virtual address
      vadr_align <= vadr;
  end
  
  logic [ADDR_WIDTH-1:0]  raddr_pre = '0; 
  logic [ADDR_WIDTH-1:0]  raddr_pre0 = '0; 
  logic [ADDR_WIDTH-1:0]  raddr_pre1 = '0; 
  logic [ADDR_WIDTH-1:0]  raddr_pre2 = '0; 
  logic [ADDR_WIDTH-1:0]  raddr_pre3 = '0; 
  
  always @(posedge clk) begin
    // translate virtual address into ROM address
    // (ROM contains only samples of 1st quadrant)
      raddr_pre0 <= vadr_align;  // increment address
      raddr_pre1 <= 2*MODULUS-2-vadr_align;  // decrement address
      raddr_pre2 <= vadr_align - 2*MODULUS + 2;  // increment address
      raddr_pre3 <= 4*MODULUS-4-vadr_align; // decrement address
      quadrant_d <= quadrant;  // alignment
      unique case (quadrant_d)
        2'h0    : raddr_pre <= raddr_pre0 < MODULUS ? raddr_pre0 : 0;
        2'h1    : raddr_pre <= raddr_pre1;
        2'h2    : raddr_pre <= raddr_pre2;
        default : raddr_pre <= raddr_pre3 < MODULUS ? raddr_pre3 : 0;
      endcase
  end
  
  logic [1:0] quadrant_dly;
  bb#(
    .N        (4+1),
    .WIDTH    (4) //data width
    ) 
  qdrt(
    .clock    (clk),
    .reset    (rst),
    .data_i   (quadrant_d),
    .data_o   (quadrant_dly)
  );
  
  logic [1:0] vld_align;
  bb#(
    .N        (5+2+1), 
    .WIDTH    (2) //data width
    ) 
  vld_vld(
    .clock    (clk),
    .reset    (rst),
    .data_i   (clken),
    .data_o   (vld_align)
  );
  
  bb#(
    .N        (3), 
    .WIDTH    (2) //data width
    ) 
  vldout(
    .clock    (clk),
    .reset    (rst),
    .data_i   (vld_align),
    .data_o   (out_valid)
  );
  
  
  logic signed [15:0] cospart_pre = 0;
  logic signed [15:0] sinpart_pre = 0;
  
  // multiply by -1 or 1 depending on quadrant
  always @(posedge clk) begin
      if (vld_align) begin
        if (quadrant_dly==0 || quadrant_dly==3) 
          cospart_pre <= $signed(rddata[31:16]);
        else 
          cospart_pre <= -$signed(rddata[31:16]);
        if (quadrant_dly==0 || quadrant_dly==1) 
          sinpart_pre <= $signed(rddata[15:0]);
        else 
          sinpart_pre <= -$signed(rddata[15:0]);
      end
  end
  
  // multiply Q by -1 when frequency is negative
  always @(posedge clk) begin
      cospart_out <= cospart_pre;
      sinpart_out <= (phase_incr_is_negative)? (-sinpart_pre) : sinpart_pre;
    // send (1+1i*0) when NCO ROM is disabled
    cos_o <= rden? cospart_out : 16'h7fff;
    sin_o <= rden? sinpart_out : 16'h0000;
  end

  // turn off BRAM when frequency is 0 
  // (when both read-enable ports are 0)
  logic sleep = '1;
  always @(posedge clk) begin
    sleep <= !(|rden);
  end
  
  // dual port ROM
  sin_cos_rom sin_cos_rom(
    .clka(clk),
    .ena(1'b1),
    .addra(raddr_pre),
    .douta(rddata),
    .sleep(sleep)
  );
  
endmodule
`default_nettype wire
