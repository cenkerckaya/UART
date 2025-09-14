`timescale 1ns / 1ps

module top_module(
    input clk,en,rst,
    input [7:0] data_in,
    output [7:0] data_out,
    output done_out
    );
    
    (* DONT_TOUCH = "true" *) wire bit_data;
    (* DONT_TOUCH = "true" *) wire tx_clk;
    (* DONT_TOUCH = "true" *) wire rx_clk;

    (* DONT_TOUCH = "true" *) wire start_tx, busy_tx, done_tx;
    (* DONT_TOUCH = "true" *) wire start_rx, busy_rx,done_rx;

        (* DONT_TOUCH = "true" *)
        uart_tx tx(
        .tx_clk(tx_clk),
        .en(en),
        .rst(rst),
        .data_in(data_in),
        .data_out(bit_data),
        .start(start_tx),
        .busy(busy_tx),
        .done(done_tx)
    );

    assign done_out = done_rx;

        (* DONT_TOUCH = "true" *)
        uart_rx rx(
        .rx_clk(rx_clk),
        .en(en),
        .rst(rst),
        .data_in(bit_data),
        .data_out(data_out),
        .start(start_rx),
        .busy(busy_rx),
        .done(done_rx)
    );


        (* DONT_TOUCH = "true" *)
        baud_gen baud (
        .clk(clk),
        .rst(rst),
        .tx_clk(tx_clk),
        .rx_clk(rx_clk)
    );
    
    
endmodule
