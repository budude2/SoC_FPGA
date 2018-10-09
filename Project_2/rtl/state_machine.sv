`timescale 1ns / 1ps

module state_maching
(
    input logic clk, rst, prog_btn, write_btn,
    input logic [31:0] data,
    output logic wea, addrb, load_en, shift_en,
    output logic [1:0] addra, disp_src
);

typedef enum logic [7:0] {init = 8'b00000001, load = 8'b00000010, run = 8'b00000100, prog0 = 8'b00001000, prog1 = 8'b00010000, inter0 = 8'b00100000, inter1 = 8'b01000000, load_reg = 8'b10000000} state_type;
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
                next_state = prog0;
            end
        end
        
        prog0:
        begin
            disp_src = 1;
        
            if(write_btn == 1) begin
                wea = 1;
                next_state = prog1;
            end
        end
        
        prog1:
        begin
            disp_src = 2;
            addra = 1;
            
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
