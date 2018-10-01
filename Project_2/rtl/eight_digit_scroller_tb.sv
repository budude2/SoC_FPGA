`timescale 1ns / 1ps

module eight_digit_scroller_tb( );

logic clk = 0, rst = 0;
logic [7:0] sseg, an;

eight_digit_scroller DUT(.CLK100MHZ(clk), .CPU_RESETN(rst), .SSEG(sseg), .AN(an));

always begin
    #5 clk = ~clk;
end

initial begin
    #20;
    rst = 1;
end

endmodule
