`timescale 1ns / 1ps

module state_maching
(
    input logic clk, rst, prog_btn, write_btn,
    input logic [31:0] data,
    output logic wea, addrb, load_en, shift_en, disp_src,
    output logic [1:0] addra
);

typedef enum logic [3:0] {init = 4'b0001, load = 4'b0010, run = 4'b0100, prog = 4'b1000} state_type;
state_type curr_state, next_state;

always_ff @(posedge clk, posedge rst) begin
    if(rst == 1'b1) begin
        curr_state <= init;
    end
    else begin
        curr_state <= next_state;
    end
end

always_comb begin
    next_state = curr_state;
    
    wea = 0;
    addra = 0;
    addrb = 0;
    load_en = 0;
    shift_en = 0;
    disp_src = 0;
    
    case(curr_state)
        init:
        begin
            if(data == 32'hdeadbeef)
                next_state = load;
        end
        
        load:
        begin
            load_en = 1;
            
            next_state = run;
        end
        
        run:
        begin
            shift_en = 1;
            
            if(prog_btn == 1) begin
                next_state = prog;
            end
        end
        
        prog:
        begin
            disp_src = 1;
        
            if(write_btn == 1) begin
                load_en = 1;
                wea = 1;
                next_state = run;
            end
        end
    endcase
end

endmodule
