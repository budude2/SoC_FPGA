`timescale 1ns / 1ps
module custom_ff_tb();

logic clk = 0;
logic rst, load_en, shift_en;
logic [3:0] d_load, d, q;

custom_ff dut(.clk(clk), .rst(rst), .load_en(load_en), .shift_en(shift_en), .d_load(d_load), .d(d), .q(q));

always begin
    #5 clk = ~clk;
end

initial begin
    rst = 1;
    load_en = 0;
    shift_en = 0;
    d_load = 0;
    d = 0;
    
    #20
    rst = 0;
    d_load = 4'ha;
    load_en = 1;
    #10
    load_en = 0;
    #10
    shift_en = 1;
    
end

endmodule
