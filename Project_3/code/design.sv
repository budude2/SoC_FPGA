// This is the SystemVerilog interface that we will use to connect
// our design to our UVM testbench.
interface dut_if;
  logic clock, reset;
  logic cmd, cout;
  logic [7:0] a, b, ans;
endinterface

`include "uvm_macros.svh"

// This is our design module.
// 
// It is an empty design that simply prints a message whenever
// the clock toggles.
module dut(dut_if dif);
  import uvm_pkg::*;
  always @(posedge dif.clock)
    if (dif.reset != 1) begin
      if(dif.cmd == 0)
      	{dif.cout, dif.ans} = dif.a + dif.b;
      else
      	{dif.cout, dif.ans} = dif.a - dif.b;
      
      `uvm_info("DUT", $sformatf("Received cmd = %b, a = %d, b = %d", dif.cmd, dif.a, dif.b), UVM_MEDIUM)
      `uvm_info("DUT", $sformatf("Result ans = %d, cout = %d", dif.ans, dif.cout), UVM_MEDIUM)
    end
endmodule
