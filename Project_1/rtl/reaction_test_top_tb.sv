`timescale 1ns / 1ps

module reaction_test_top_tb(    );

logic BTNL, BTNC, BTNR, BTND, clk, led0;
logic [7:0] AN, SSEG;

reaction_test_top dut(.BTNL(BTNL), .BTNC(BTNC), .BTNR(BTNR), .BTND(BTND), .CLK100MHZ(clk), .AN(AN), .SSEG(SSEG), .led0(led0));

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    BTNL = 0;
    BTNC = 0;
    BTNR = 0;
    BTND = 1;
    
    repeat(5) @(posedge clk);
    
    BTND = 0;
    
    repeat(10) @(posedge clk);
    
    BTNC = 1;
   
    $finish; 
end

endmodule
