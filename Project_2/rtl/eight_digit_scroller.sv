`timescale 1ns / 1ps

module eight_digit_scroller(
    input logic CLK100MHZ, CPU_RESETN,
    output logic [7:0] SSEG, AN
);

logic [3:0] hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7;
logic[31:0] d_int;

disp_hex_mux disp_mux(.clk(CLK100MHZ), .reset(~CPU_RESETN), .hex7(hex7), .hex6(hex6), .hex5(hex5), .hex4(hex4), .hex3(hex3), .hex2(hex2), .hex1(hex1), .hex0(hex0), .an(AN), .sseg(SSEG));
circle_shift_reg shifter(.clk(CLK100MHZ), .rst(~CPU_RESETN), .load_en(), .shift_en(), .d_load(d_int), .seg0(hex0), .seg1(hex1), .seg2(hex2), .seg3(hex3), .seg4(hex4), .seg5(hex5), .seg6(hex6), .seg7(hex7));

blk_mem_gen_0 bram0 (.clka(CLK100MHZ), .ena(ena), .wea(wea), .addra(addra), .dina(dina), .clkb(CLK100MHZ), .enb(enb), .addrb(addrb), .doutb(d_int));

endmodule
