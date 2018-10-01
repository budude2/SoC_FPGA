// Listing 5.5
module edge_detect_gate
   (
    input  logic clk, reset,
    input  logic level,
    output logic tick
   );

   // signal declaration
   logic delay_reg;

   // delay register
    always_ff @(posedge clk, posedge reset)
       if (reset)
          delay_reg <= 1'b0;
       else
          delay_reg <= level;

   // decoding logic
   assign tick = ~delay_reg & level;
endmodule