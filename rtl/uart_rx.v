`timescale 1ns / 1ps

module uart_rx(
    input rx_clk, en, rst,
    input data_in,
    output reg [7:0] data_out,
    output reg start, busy, done
);

    parameter IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
    reg [1:0] state;

    (* DONT_TOUCH = "true" *) reg [3:0] sample_cnt;
    (* DONT_TOUCH = "true" *) reg [6:0] temp_reg;
    (* DONT_TOUCH = "true" *) reg [7:0] perm_reg;
    (* DONT_TOUCH = "true" *) reg [3:0] comparator;
    (* DONT_TOUCH = "true" *) reg [3:0] bit_cnt;

    always @(posedge rx_clk or posedge rst) begin
        if (rst) begin
            busy <= 0;
            done <= 0;
            start <= 0;
            sample_cnt <= 0;
            temp_reg <= 0;
            perm_reg <= 0;
            comparator <= 0;
            bit_cnt <= 0;
            data_out <= 8'b0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    busy <= 0;
                    done <= 0;
                    start <= 0;
                    sample_cnt <= 0;
                    temp_reg <= 0;
                    comparator <= 0;
                    bit_cnt <= 0;
                    data_out <= 8'b0;
                    if (en && data_in == 0) begin
                        start <= 1;
                        state <= START;
                    end
                end

                START: begin
                    if (sample_cnt >= 3) begin
                        sample_cnt <= 0;
                        start <= 0;
                        state <= DATA;
                        busy <= 1;
                    end else begin
                        sample_cnt <= sample_cnt + 1;
                    end
                end

                DATA: begin
                    temp_reg <= {data_in, temp_reg[6:1]};
                    sample_cnt <= sample_cnt + 1;
                                        
                    if (sample_cnt == 7) begin
                        comparator <= temp_reg[0] + temp_reg[1] + temp_reg[2] +
                                      temp_reg[3] + temp_reg[4] + temp_reg[5] + temp_reg[6];
                        if (comparator >= 4) begin
                            perm_reg <= {1'b1, perm_reg[7:1]};
                        end else begin
                            perm_reg <= {1'b0, perm_reg[7:1]};
                        end
                        sample_cnt <= 0;
                        bit_cnt <= bit_cnt + 1;
                    end

                    if (bit_cnt == 9) begin
                        state <= STOP;
                        data_out <= perm_reg;
                        done <= 1;
                        busy <= 0;
                    end
                end

                STOP: begin
                    if (sample_cnt < 4) begin
                        sample_cnt <= sample_cnt + 1;
                    end else begin
                        state <= IDLE;
                    end
                end
            endcase
        end
    end
endmodule
