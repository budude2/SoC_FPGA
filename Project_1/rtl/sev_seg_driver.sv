`timescale 1ns / 1ps

module sev_seg_driver(
    input  logic clk, rst, ltr_i,
    input  logic [3:0] in3_i, in2_i, in1_i, in0_i,
    output logic [3:0] an_o,   // enable
    output logic [7:0] sseg_o  // led segments
    );
    
    logic [7:0] in0, in1, in2, in3;
    
    disp_mux mux(.clk(clk), .reset(rst), .in3(in3), .in2(in2), .in1(in1), .in0(in0), .an(an_o), .sseg(sseg_o));
    
    display_decoder decoder0(.data_i(in0_i), .ltr_i(ltr_i), .data_o(in0));
    display_decoder decoder1(.data_i(in1_i), .ltr_i(ltr_i), .data_o(in1));
    display_decoder decoder2(.data_i(in2_i), .ltr_i(ltr_i), .data_o(in2));
    display_decoder decoder3(.data_i(in3_i), .ltr_i(ltr_i), .data_o(in3));
endmodule
