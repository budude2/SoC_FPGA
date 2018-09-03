`timescale 1ns / 1ps

module stop_watch_top
    (
        input logic BTNL, BTNC, BTNR, CLK100MHZ,
        output logic [7:0] AN, SSEG
    );
    
    logic [3:0] d2, d1, d0;
    
    sev_seg_driver driver(.clk(CLK100MHZ), .rst(BTNR), .ltr_i(0), .in3_i(10), .in2_i(d2), .in1_i(d1), .in0_i(d0), .an_o(AN[3:0]), .sseg_o(SSEG));
    stop_watch_if stop_watch(.clk(CLK100MHZ), .go(BTNL), .clr(BTNC), .d2(d2), .d1(d1), .d0(d0));
    
    assign AN[7:4] = 4'b1111;
endmodule
