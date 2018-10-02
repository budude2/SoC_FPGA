`timescale 1ns / 1ps

module eight_digit_scroller(
    input logic CLK100MHZ, CPU_RESETN, BTNC,
    input logic [15:0] SW,
    output logic [7:0] SSEG, AN
);

logic wea, load_en, shift_en, addrb, clk_div, tick, disp_src, BTNC_db, BTNC_pulse;
logic [1:0] addra;
logic [3:0] hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7, seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7;
logic [31:0] d_int;

disp_hex_mux disp_mux(.clk(CLK100MHZ), .reset(~CPU_RESETN), .hex7(hex7), .hex6(hex6), .hex5(hex5), .hex4(hex4), .hex3(hex3), .hex2(hex2), .hex1(hex1), .hex0(hex0), .an(AN), .sseg(SSEG));
circle_shift_reg shifter(.clk(CLK100MHZ), .rst(~CPU_RESETN), .load_en(load_en), .shift_en(shift_en & tick), .d_load(d_int), .seg0(seg0), .seg1(seg1), .seg2(seg2), .seg3(seg3), .seg4(seg4), .seg5(seg5), .seg6(seg6), .seg7(seg7));
state_maching controller (.clk(CLK100MHZ), .rst(~CPU_RESETN), .prog_btn(BTNC_pulse), .write_btn(BTNC_pulse), .disp_src(disp_src), .wea(wea), .addrb(addrb), .load_en(load_en), .shift_en(shift_en), .addra(addra), .data(d_int));
blk_mem_gen_0 bram0 (.clka(CLK100MHZ), .ena(1), .wea(wea), .addra(addra), .dina(SW), .clkb(CLK100MHZ), .enb(1), .addrb(addrb), .doutb(d_int));
ClkDivider div(.clk(CLK100MHZ), .rst(~CPU_RESETN), .clk_div(clk_div));
edge_detect_gate pulse_gen(.clk(CLK100MHZ), .reset(~CPU_RESETN), .level(clk_div), .tick(tick));
edge_detect_gate pulse_gen2(.clk(CLK100MHZ), .reset(~CPU_RESETN), .level(BTNC_db), .tick(BTNC_pulse));
db_fsm debouncer(.clk(CLK100MHZ), .reset(~CPU_RESETN), .sw(BTNC), .db(BTNC_db));

always_comb begin
    case(disp_src)
        0:
        begin
            hex0 = seg0;
            hex1 = seg1;
            hex2 = seg2;
            hex3 = seg3;
            hex4 = seg4;
            hex5 = seg5;
            hex6 = seg6;
            hex7 = seg7;
        end
        
        1:
        begin
            hex0 = SW[3:0];
            hex1 = SW[7:4];
            hex2 = SW[11:8];
            hex3 = SW[15:12];
            hex4 = 0;
            hex5 = 0;
            hex6 = 0;
            hex7 = 0;
        end
    endcase
end

endmodule
