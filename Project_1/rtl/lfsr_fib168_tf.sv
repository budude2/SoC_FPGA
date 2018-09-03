`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2018 05:38:43 PM
// Design Name: 
// Module Name: lfsr_fib168_tf
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lfsr_fib168_tf;

logic clk=0, reset=0;
logic [27:0] seed;
logic [3:0] r;

LFSR_fib168pi DUT(
 .clk(clk),
  .reset(reset),
  .seed(seed),
  .r(r)
);

always
    #5 clk=!clk;
    
initial
begin
seed<=28'b11101100011111100111011011001;
#1 reset<=1;
#1 reset<=0;
end

endmodule
