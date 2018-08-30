`timescale 1ns / 1ps

module display_decoder(
    input logic [3:0] data_i,
    input logic ltr_i,
    output logic [7:0] data_o
    );
    
    always_comb
    begin
        if(ltr_i == 0)
            case(data_i)
                4'b0000: data_o = 8'b00000011; // 0
                4'b0001: data_o = 8'b10011111; // 1
                4'b0010: data_o = 8'b00100101; // 2
                4'b0011: data_o = 8'b00001101; // 3
                4'b0100: data_o = 8'b10011001; // 4
                4'b0101: data_o = 8'b01001001; // 5
                4'b0110: data_o = 8'b11000001; // 6
                4'b0111: data_o = 8'b00011111; // 7
                4'b1000: data_o = 8'b00000001; // 8
                4'b1001: data_o = 8'b00011001; // 9
                default: data_o = 8'b11111111; // Light up no segments
            endcase
        else
            case(data_i)
                4'b0101: data_o = 8'b10010001; // H
                4'b1010: data_o = 8'b10011111; // I
                default: data_o = 8'b11111111; // Light up no segments
            endcase
    end                
endmodule
