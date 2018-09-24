`timescale 1ns / 1ps

module eight_digit_scroller(
    input logic CLK100MHZ, CPU_RESETN,
    output logic [7:0] SSEG, AN
);

disp_hex_mux disp_mux
(
.clk(CLK100MHZ), .reset(~CPU_RESETN),
 .hex7(8), .hex6(7), .hex5(6), .hex4(5), .hex3(4), .hex2(3), .hex1(2), .hex0(1), .an(AN),
 .sseg(SSEG));

endmodule
