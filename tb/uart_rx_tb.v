`timescale 1ns / 1ps

module uart_rx_tb();

    reg rx_clk,en,rst,data_in;
    wire [7:0] data_out;
    wire start,busy,done;

    uart_rx uut(
        .rx_clk(rx_clk),
        .en(en),
        .rst(rst),
        .data_in(data_in),
        .data_out(data_out),
        .start(start),
        .busy(busy),
        .done(done)
    );

    initial rx_clk = 0;
    initial data_in = 0;
    always #5 rx_clk=~rx_clk;

    initial begin
        rst = 1'b1;
        en = 1'b0;
        #10;
        rst = 1'b0;
        en = 1'b1;
        data_in = 1'b1;
        #80;
        data_in = 1'b0;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = 1'b1;
        #80;
        rst = 1'b1;
        en = 1'b0;
        #10;
        rst = 1'b0;
        en = 1'b1;
        data_in = 1'b1;
        #80;
        data_in = 1'b0;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = 1'b1;
        #80;
        rst = 1'b1;
        en = 1'b0;
        #10;
        rst = 1'b0;
        en = 1'b1;
        data_in = 1'b1;
        #80;
        data_in = 1'b0;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = 1'b1;
        #80;
        rst = 1'b1;
        en = 1'b0;
        #10;
        rst = 1'b0;
        en = 1'b1;
        data_in = 1'b1;
        #80;
        data_in = 1'b0;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = $random % 2;
        #80;
        data_in = 1'b1;
        #80;
        
    end

endmodule
