`timescale 1ns / 1ps

module circular_shift_reg_tb();

logic clk = 0;
logic rst, load_en, shift_en;
logic [31:0] d_load;
logic [3:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7;

circle_shift_reg dut(.clk(clk), .rst(rst), .load_en(load_en), .shift_en(shift_en), .d_load(d_load), .seg0(seg0), .seg1(seg1), .seg2(seg2), .seg3(seg3), .seg4(seg4), .seg5(seg5), .seg6(seg6), .seg7(seg7));

always begin
    #5 clk = ~clk;
end

initial begin
    rst = 1;
    load_en = 0;
    shift_en = 0;
    d_load = 0;
    #20
    rst = 0;
    d_load = 32'hdeadbeef;
    load_en = 1;
    #10
    load_en = 0;
    #10
    shift_en = 1;
    
end
endmodule
