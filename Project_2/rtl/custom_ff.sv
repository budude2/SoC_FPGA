`timescale 1ns / 1ps

module custom_ff(
    input load_en,
    input shift_en,
    input clk,
    input rst,
    input [3:0] d_load,
    input [3:0] d,
    output [3:0] q
    );
    
    logic [3:0] q_internal;
    
    always_ff @(posedge clk)
    begin
        if(rst == 1)
            q_internal <= 0;
        else if(load_en == 1)
            q_internal <= d_load;
        else if(shift_en == 1)
            q_internal <= d;
        else
            q_internal <= q_internal;
    end
    
    assign q = q_internal;
endmodule
