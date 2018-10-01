`timescale 1ns / 1ps

module eight_digit_scroller(
    input logic CLK100MHZ, CPU_RESETN,
    output logic [7:0] SSEG, AN
);

logic wea, prog_btn, write_btn, load_en, shift_en, addrb, clk_div, tick;
logic [1:0] addra;
logic [3:0] hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7;
logic [15:0] dina;
logic [31:0] d_int;

disp_hex_mux disp_mux(.clk(CLK100MHZ), .reset(~CPU_RESETN), .hex7(hex7), .hex6(hex6), .hex5(hex5), .hex4(hex4), .hex3(hex3), .hex2(hex2), .hex1(hex1), .hex0(hex0), .an(AN), .sseg(SSEG));
circle_shift_reg shifter(.clk(CLK100MHZ), .rst(~CPU_RESETN), .load_en(load_en), .shift_en(shift_en & tick), .d_load(d_int), .seg0(hex0), .seg1(hex1), .seg2(hex2), .seg3(hex3), .seg4(hex4), .seg5(hex5), .seg6(hex6), .seg7(hex7));
state_maching controller (.clk(CLK100MHZ), .rst(~CPU_RESETN), .prog_btn(prog_btn), .write_btn(write_btn), .wea(wea), .addrb(addrb), .load_en(load_en), .shift_en(shift_en), .addra(addra), .data(d_int));
blk_mem_gen_0 bram0 (.clka(CLK100MHZ), .ena(1), .wea(wea), .addra(addra), .dina(dina), .clkb(CLK100MHZ), .enb(1), .addrb(addrb), .doutb(d_int));
ClkDivider div(.clk(CLK100MHZ), .rst(~CPU_RESETN), .clk_div(clk_div));
edge_detect_gate pulse_gen(.clk(CLK100MHZ), .reset(~CPU_RESETN), .level(clk_div), .tick(tick));

endmodule
