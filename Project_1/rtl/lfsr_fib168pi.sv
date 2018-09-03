// LFSR Fibonacci 168 bit pseudorandom number generator
//     maximal poly for 168 is 168,166,153,151
//     don't forget to subtract 1 since we are 0-167
//     key1-4 are binary digits of pi used to add initial information
//     Note this is pseudorandom, and linear.  It won't repeat for a long time
//     but it is predictable after a much shorter time so it should not be used
//     for apps needing true randomness, such as cryptography, gambling, etc.

module LFSR_fib168pi(
  input logic clk,
  input logic reset,
  input logic [27:0] seed,
  output logic [3:0] r
);
  localparam key1=28'b1100100100001111110110101010;
  localparam key2=28'b0010001000010110100011000010;
  localparam key3=28'b0011010011000100110001100110;
  localparam key4=28'b0010100010111000000011011100;
  logic [167:0] state, next_state;
  logic [3:0] polynomial, polynomial_truncated;

  assign polynomial = state[167:164]^state[163:160]^state[159:156]^state[155:152];
  assign next_state = {state[166:0],polynomial};

  always_ff @(posedge(clk), posedge(reset))
    if(reset)
      state <= {seed,~seed,key1^seed,key2^seed,key3^seed,key4^seed};
    else
      state <= next_state;

  always_comb begin
    if(polynomial[3] & polynomial[2] & polynomial[1])
        polynomial_truncated = polynomial & 4'b1101;
    else
        polynomial_truncated = polynomial;
  end
    

  assign r = polynomial_truncated + 2;
  endmodule
