`timescale 1ns / 1ps

module baud_gen_tb();

    reg clk;
    reg rst;
    wire tx_clk,rx_clk;

    // Clock divider örneği
    baud_gen #(
        .INITIAL_CLOCK(100000000),
        .BAUD(115200),
        .OVERSAMPLE_TIME(8)
    ) uut (
        .clk(clk),
        .rst(rst),
        .tx_clk(tx_clk),
        .rx_clk(rx_clk)
    );

    // Clock üretici (50 MHz clock)
    initial clk = 0;
    always #5 clk = ~clk;
    // Test senaryosu
    initial begin
        rst = 1;
        #20 rst = 0; // Reset kaldırılıyor
    end

endmodule
