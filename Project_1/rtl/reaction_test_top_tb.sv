`timescale 1ns / 1ps

module reaction_test_top_tb(    );

logic BTNL, BTNC, BTNR, CPU_RESETN, clk, led0;
logic [7:0] AN, SSEG;

reaction_test_top dut(.BTNL(BTNL), .BTNC(BTNC), .BTNR(BTNR), .CPU_RESETN(CPU_RESETN), .CLK100MHZ(clk), .AN(AN), .SSEG(SSEG), .led0(led0));

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
    CPU_RESETN = 0;
    
    repeat(5) @(posedge clk);
    
    CPU_RESETN = 1;
    
    repeat(10) @(posedge clk);
    
    BTNC = 1;
   
    repeat(2) @(posedge clk)
    BTNC = 0;
    
    repeat(10) @(posedge clk);
    
    BTNR = 1;
    
    repeat(2) @(posedge clk);
    BTNR = 0;
    
    repeat(5) @(posedge clk);
    BTNL = 1;
    
    repeat(2) @(posedge clk);
    BTNL = 0;

    $finish; 
end

endmodule
