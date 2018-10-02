`timescale 1ns / 1ps

module state_maching
(
    input logic clk, rst, prog_btn, write_btn,
    input logic [31:0] data,
    output logic wea, addrb, load_en, shift_en, disp_src,
    output logic [1:0] addra
);

typedef enum logic [6:0] {init = 7'b0000001, load = 7'b0000010, run = 7'b0000100, prog = 7'b0001000, inter0 = 7'b0010000, inter1 = 7'b0100000, load_reg = 7'b1000000} state_type;
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
                wea = 1;
                next_state = inter0;
            end
        end
        
        inter0:
        begin
            next_state = inter1;
        end
        
        inter1:
        begin
            next_state = load_reg;
        end
        
        load_reg:
        begin
            disp_src = 1;
            load_en = 1;
            next_state = run;
        end
    endcase
end

endmodule
