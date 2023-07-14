`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2023 10:10:38
// Design Name: 
// Module Name: FIFO_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FIFO_tb(

    );
reg rst;
reg clk;
reg wr_en;
reg rd_en;
reg[7:0] buf_in;
wire[7:0] buf_out;
wire buf_empty;
wire buf_full;
wire[7:0] fifo_counter;

FIFO uut(.rst(rst), .clk(clk), .wr_en(wr_en), .rd_en(rd_en), .buf_in(buf_in), .buf_out(buf_out), .buf_empty(buf_empty), .buf_full(buf_full), .fifo_counter(fifo_counter));
initial
begin
    rst = 1; #5
    rst = 0; #500
    rst = 1; #20
    rst = 0;
end

initial 
begin
    repeat(15)
    begin
        clk = 0; #10
        clk = 1; #10;
    end
end

initial
begin
    buf_in = 100; #20
    buf_in = 64; #20
    buf_in = 36; #20
    buf_in = 12; #10
    buf_in = 55; #10
    buf_in = 100; #20
    buf_in = 64; #20
    buf_in = 36; 
end

initial
begin
    wr_en = 1;
    rd_en = 0; 
    #80
    rd_en = 1;
    wr_en = 0;
    #80
    wr_en = 1;
    rd_en = 0;
end

endmodule
