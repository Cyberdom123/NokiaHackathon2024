module task_12_deserializer #(parameter N=3, parameter DATA_WIDTH = 16)
(i_enb, i_clk, i_rst, i_data,
o_data, o_valid);
	
	input i_enb;
	input i_clk;
	input i_rst;
	input [DATA_WIDTH - 1:0] i_data;
	
	output reg [DATA_WIDTH - 1:0] o_data[N];
	output o_valid;
	
	reg [DATA_WIDTH - 1:0] r_data[N];
	reg [$clog2(N):0] r_counter;
	
	reg r_enb[N];
	
	genvar i;

//--------------------------------------------------------------------------	
	always@(posedge i_clk) begin
		if (i_rst == 1'b1)
			r_data[N-1] <= '0;
		else
			r_data[N-1] <= i_data;
	end
	
	generate
		for (i = N-2; i >= 0; i = i - 1) begin: r_data_for
			always@(posedge i_clk) begin
				if (i_rst == 1'b1)
					r_data[i] <= '0;
				else
					r_data[i] <= r_data[i+1];
			end
		end
	endgenerate
//--------------------------------------------------------------------------		
	always@(posedge i_clk) begin
		if(i_enb && !i_rst)
			r_counter <= r_counter + 1'b1;
		else
			r_counter <= {$clog2(N)+1{1'b1}};
			
		if(r_counter == N-1)
			r_counter <= 0;
	end
//--------------------------------------------------------------------------		
	generate
		for (i = 0; i<N; i=i+1) begin: o_data_for
			always@(posedge i_clk) begin
				if (i_rst == 1'b1)
					o_data[i] <= '0;
				else
					if(r_counter == N-1)
						o_data[i] <= r_data[i];
			end
		end
	endgenerate	
//--------------------------------------------------------------------------		
	always@(posedge i_clk) begin
		if (i_rst)
			r_enb[0] <= 1'b0;
		else
			r_enb[0] <= i_enb;	
	end
	
	generate
		for (i = 1; i < N; i = i + 1) begin: r_enb_for
			always@(posedge i_clk) begin
				if (i_rst)
					r_enb[i] <= 1'b0;
				else
					r_enb[i] <= r_enb[i-1];
			end
		end
	endgenerate
//--------------------------------------------------------------------------		
	assign o_valid = (r_counter == 0 && r_enb[N-1]) ? 1'b1: 1'b0;
	
	
endmodule 