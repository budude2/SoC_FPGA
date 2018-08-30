`timescale 1ns / 1ps

module stop_watch_top
    (
    input logic BTNC, CLK100MHZ,
    output logic CA, CB, CC, CD, CE, CF, CG, DP,
    output logic [3:0] AN
    );
    
    logic [7:0] sseg;
    
    sev_seg_driver driver(.clk(CLK100MHZ), .rst(BTNC), .ltr_i(0), .in3_i(3), .in2_i(2), .in1_i(1), .in0_i(0), .an_o(AN), .sseg_o(sseg));
    
    assign sseg[0] = DP;
    assign sseg[1] = CG;
    assign sseg[2] = CF;
    assign sseg[3] = CE;
    assign sseg[4] = CD;
    assign sseg[5] = CC;
    assign sseg[6] = CB;
    assign sseg[7] = CA;    
endmodule
