class my_transaction extends uvm_sequence_item;

  `uvm_object_utils(my_transaction)

  rand bit cmd;
  rand int a;
  rand int b;

  constraint c_a { a >= 0; a < 256; }
  constraint c_b { b >= 0; b < 256; }

  function new (string name = "");
    super.new(name);
  endfunction

endclass: my_transaction

class my_sequence extends uvm_sequence#(my_transaction);

  `uvm_object_utils(my_sequence)

  function new (string name = "");
    super.new(name);
  endfunction

  task body;
    repeat(10) begin
      req = my_transaction::type_id::create("req");
      start_item(req);

      if (!req.randomize()) begin
        `uvm_error("MY_SEQUENCE", "Randomize failed.");
      end

      // If using ModelSim, which does not support randomize(),
      // we must randomize item using traditional methods, like
      // req.cmd = $urandom;
      // req.addr = $urandom_range(0, 255);
      // req.data = $urandom_range(0, 255);

      finish_item(req);
    end
  endtask: body

endclass: my_sequence
