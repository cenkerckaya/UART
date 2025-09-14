`timescale 1us / 1ns

module uart_tx_tb();

reg tx_clk,en,rst;
reg [7:0] data_in;

wire data_out,start,busy,done;

uart_tx uut(
    .tx_clk(tx_clk),
    .en(en),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .start(start),
    .busy(busy),
    .done(done)
);

initial tx_clk = 0;
initial data_in = 0;
always #52.08333 tx_clk = ~tx_clk;


initial begin
    rst = 1'b1;
    en = 1'b0;
    #5;
    data_in = $random % 256;
    rst = 1'b0;
    en = 1'b1;
    @(posedge done);
    #5;
    rst = 1'b1;
    en = 1'b0;
    #5;
    data_in = $random % 256;
    rst = 1'b0;
    en = 1'b1;
    @(posedge done);
    #5;
    rst = 1'b1;
    en = 1'b0;
    #5;
    data_in = $random % 256;
    rst = 1'b0;
    en = 1'b1;
    @(posedge done);
    #5
    rst = 1'b1;
    en = 1'b0;
    #5;
    data_in = $random % 256;
    rst = 1'b0;
    en = 1'b1;
    @(posedge done);
    #5;
    rst = 1'b1;
    en = 1'b0;
end
endmodule
