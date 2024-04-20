module task_3_latency_meas #(parameter DATA_WIDTH = 8, parameter LAT_SIZE_IN_WIDTH = 3)
(i_clk, i_rst, i_in_enb, i_out_valid, o_lat, o_valid);
	
	input i_clk;
	input i_rst;
	input i_in_enb;
	input i_out_valid;
	
	output [LAT_SIZE_IN_WIDTH*DATA_WIDTH-1:0] o_lat;
	output o_valid;
	
	reg [LAT_SIZE_IN_WIDTH*DATA_WIDTH-1:0] r_lat = '0;
	reg r_flag = 1'b0;
	reg r_out_valid_lat = 1'b0;
	
	always@(posedge i_clk) begin
		if(i_rst) begin
			r_lat <= '0;
			r_flag <= 1'b0;
		end
		else begin
			if(i_in_enb)
				r_flag <= 1'b1;
			if(i_out_valid)
				r_flag <= 1'b0;
			
			if(r_flag)
				r_lat <= r_lat + 1'b1;
		end			
	end
	
	always@(posedge i_clk) begin
		if(i_rst)
			r_out_valid_lat <= 1'b0;
		else
			r_out_valid_lat <= i_out_valid;
	end
	
	assign o_valid = (!r_out_valid_lat && i_out_valid);
	assign o_lat = r_lat;
	
endmodule 