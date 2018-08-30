`timescale 1ns / 1ps

module display_decoder_tb;

    logic [3:0] data_i;
    logic ltr_i;
    logic [7:0] data_o;
    
    display_decoder DUT(.data_i(data_i), .data_o(data_o), .ltr_i(ltr_i));

    initial begin
        data_i = 0;
        ltr_i = 0;
        #10
        data_i = 1;
        #10
        data_i = 2;
        #10
        data_i = 3;
        #10
        data_i = 4;
        #10
        data_i = 5;
        #10
        data_i = 6;
        #10
        data_i = 7;
        #10
        data_i = 8;
        #10
        data_i = 9;
        #10
        data_i = 10;
        #10
        data_i = 4'b0101;
        ltr_i = 1;
        #10;
        data_i = 4'b1010;
        #10
        data_i = 4'b1111;        
        $finish;
    end

endmodule
