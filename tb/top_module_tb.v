`timescale 1ns / 1ps


module top_module_tb();

    reg clk;
    reg en,rst;

    reg [7:0] data_in;
    wire done_out;
    wire [7:0] data_out;

    top_module uut(
        .clk(clk),
        .en(en),
        .rst(rst),
        .data_in(data_in),
        .data_out(data_out),
        .done_out(done_out)
    );


    initial clk = 0;
    initial data_in = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1'b1;
        en = 1'b0;
        #15;
        rst = 1'b0;
        en = 1'b1;
        data_in = $random % 256;
        @(negedge done_out);
        data_in = $random % 256;
        @(negedge done_out);
        data_in = $random % 256;
        @(negedge done_out);
        data_in = $random % 256;
    end
endmodule
