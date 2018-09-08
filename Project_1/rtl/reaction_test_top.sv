`timescale 1ns / 1ps

module reaction_test_top
(
    input logic BTNL, BTNC, BTNR, CPU_RESETN, CLK100MHZ,
    output logic led0,
    output logic [7:0] AN, SSEG
);

    logic ltr_flag;
    logic [3:0] digit0, digit1, digit2, digit3;

    state_machine state_logic(.clk(CLK100MHZ), .rst(~CPU_RESETN), .start_btn(BTNC), .clear_btn(BTNL), .stop_btn(BTNR), .ltr_flag(ltr_flag), .digit0(digit0), .digit1(digit1), .digit2(digit2), .digit3(digit3), .led0(led0));
    sev_seg_driver driver(.clk(CLK100MHZ), .rst(~CPU_RESETN), .ltr_i(ltr_flag), .in3_i(digit3), .in2_i(digit2), .in1_i(digit1), .in0_i(digit0), .an_o(AN[3:0]), .sseg_o(SSEG));
    
    assign AN[7:4] = 4'b1111;

endmodule
