// Listing 4.21
module stop_watch_test();
   
    // signal declaration
    logic [3:0]  d3, d2, d1, d0;
    logic clk, clr, go;
   
    // instantiate stopwatch
    stop_watch_if counter_unit (.clk(clk), .go(go), .clr(clr), .d3(d3), .d2(d2), .d1(d1), .d0(d0));
   
   initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        clr = 1;
        #30
        clr = 0;
        go = 1;
    end
   
endmodule
