`timescale 1ns / 1ps

module uart_tx(
    input tx_clk,en,rst,
    input [7:0] data_in,
    output reg data_out,
    output reg start,busy,done
    );

    reg [1:0] state;
    (* DONT_TOUCH = "true" *) reg [2:0] bit_index;
     
    parameter IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;


    always @(posedge tx_clk or posedge rst) begin
        if(rst) begin
            busy <= 1'b0;
            done <= 1'b0;
            start <= 1'b0;
            data_out <= 1'b1;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    bit_index <= 3'b0;
                    busy <= 1'b0;
                    done <= 1'b0;
                    start <= 1'b0;
                    data_out <= 1'b1; //To show receiver that we are in IDLE state.
                    if(en) begin
                        state <= START;
                    end 
                end

                START: begin
                    data_out <= 1'b0;
                    start <= 1'b1;
                    state <= DATA;
                end

                DATA: begin
                    start <= 1'b0;
                    busy <= 1'b1;
                    data_out <= data_in[bit_index];
                    bit_index <= bit_index + 1;
                    if(bit_index == 7) begin
                        bit_index <= 3'b0;
                        state <= STOP;
                    end 
                end

                STOP: begin
                    busy <= 1'b0;
                    done <= 1'b1;
                    data_out <= 1'b1;
                    state <= IDLE;
                end 
            endcase
        end
    end


endmodule
