// Listing 4.16
module disp_mux_test;
    
    logic clk, rst;
    logic [3:0] an;
    logic [7:0] sseg, d0, d1, d2, d3;

    // instantiate 7-seg LED display time-multiplexing module
    disp_mux disp_unit(.clk(clk), .reset(rst), .in0(d0), .in1(d1), .in2(d2), .in3(d3), .an(an), .sseg(sseg));
    
    always begin
        clk = 0;
        forever begin
            #5 clk =! clk;
        end
    end
    
    initial begin
        rst = 1;
        repeat(5) @(posedge clk);
        rst = 0;
        d0 = 8'b10101010;
        d1 = 8'b01010101;
        d2 = 8'b11110000;
        d3 = 8'b00001111;
    end
    

endmodule