`timescale 1ns / 1ps

module baud_gen #(
    INITIAL_CLOCK = 100000000,
    BAUD = 9600,
    OVERSAMPLE_TIME = 8
) (
    input clk,rst,
    output reg tx_clk,rx_clk
);
    
    localparam BAUD_DIV_RX = (INITIAL_CLOCK / (2 * BAUD * OVERSAMPLE_TIME)) -1; //Multiplied by 2 because we are calculating form posedge to posedge. 

    (* DONT_TOUCH = "true" *) reg [63:0] rx_cnt;
    (* DONT_TOUCH = "true" *) reg [4:0] tx_cnt;    

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rx_cnt <= 0;
            rx_clk <= 0;
        end else begin
            if (rx_cnt >= BAUD_DIV_RX) begin
                rx_cnt <= 0;
                rx_clk <= ~rx_clk;
            end else begin
                rx_cnt <= rx_cnt + 1;
            end
        end
    end

    always @(posedge rx_clk or posedge rst) begin
        if (rst) begin
            tx_cnt <= 0;
            tx_clk <= 0;
        end else begin
            if (tx_cnt < OVERSAMPLE_TIME/2) begin
                tx_clk <= 1;
                tx_cnt <= tx_cnt +1;
            end else if ((OVERSAMPLE_TIME/2 <= tx_cnt) && (tx_cnt < OVERSAMPLE_TIME)) begin
                tx_clk <= 0;
                tx_cnt <= tx_cnt + 1;
                if (tx_cnt == OVERSAMPLE_TIME -1) begin
                    tx_cnt <= 0;
                end
            end 
        end
    end
endmodule