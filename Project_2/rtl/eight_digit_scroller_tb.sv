`timescale 1ns / 1ps

module eight_digit_scroller_tb( );

logic clk = 0, rst = 0, BTNC;
logic [7:0] sseg, an;
logic [15:0] SW;

eight_digit_scroller DUT(.CLK100MHZ(clk), .CPU_RESETN(rst), .SSEG(sseg), .AN(an), .SW(SW), .BTNC(BTNC));

always begin
    #5 clk = ~clk;
end

initial begin
    BTNC = 0;
    SW = 0;
    #20;
    rst = 1;
    #60;
    BTNC = 1;
    #60;
    BTNC = 0;
    #60;
    BTNC = 1;
    #60
    BTNC = 0;
end

endmodule
