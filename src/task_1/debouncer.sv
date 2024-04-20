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
    
    enum {STABLE, UNSTABLE} is_stable;
    logic [7:0] counter;
    logic prev_input;
    logic stable_high;
    logic stable_low;
    logic impulse_sent;

    initial begin 
        o_data <= 1'b0;
        counter <= 8'b0;
        prev_input <= 1'b0;
        is_stable <= UNSTABLE;
        stable_high <= 1'b0;
        stable_low  <= 1'b0;
        impulse_sent <= 1'b0;
        
    end

    always @(posedge i_clk) begin
    if(i_rst) begin 
            o_data <= 1'b0;
            counter <= 8'b0;
            prev_input <= 1'b0;
            is_stable <= UNSTABLE;
            stable_high <= 1'b0;
            stable_low  <= 1'b0;
            impulse_sent <= 1'b0;
        end else begin
            if(i_data == prev_input) begin
                if(counter < (19 - 1) ) begin 
                    counter <= counter + 1;
                end else begin
                    counter <= 0;

                    if(i_data == 1'b1) begin
                        stable_low  <= 1'b0;
                        stable_high <= 1'b1;
                    end else if(i_data == 1'b0) begin
                        stable_low <= 1'b1;
                        if(impulse_sent == 1'b0 && stable_high == 1'b1) begin
                            o_data <= 1'b1;
                            impulse_sent <= 1'b1;
                            stable_high <= 1'b0;
                            stable_low  <= 1'b0;
                            counter <= 0;
                        end 
                                
                    end   

                end

                if (impulse_sent == 1'b1) begin 
                    o_data <= 1'b0;
                    impulse_sent <= 1'b0;
                end
                
            end else begin
                counter <= 0;
            end

            prev_input <= i_data;
        end
    end

    
endmodule
