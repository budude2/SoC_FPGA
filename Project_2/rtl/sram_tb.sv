`timescale 1ns / 1ps
module sram_tb( );

logic clk = 0;
logic ena, wea, enb, addrb;
logic [1:0] addra;
logic [15:0] dina;
logic [31:0] doutb;

blk_mem_gen_0 bram0(.clka(clk), .ena(ena), .wea(wea), .addra(addra), .dina(dina), .clkb(clk), .enb(enb), .addrb(addrb), .doutb(doutb));

always begin
    #5 clk = ~clk;
end


initial begin
    addra = 0;
    ena = 1;
    enb = 1;
    addrb = 0;
    dina = 16'hbeef;
    #10;
    
    wea = 1;
    #10;
    wea = 0;
end
endmodule
