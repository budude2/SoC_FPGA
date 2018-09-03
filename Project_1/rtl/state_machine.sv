`timescale 1ns / 1ps

module state_machine
( 
    input logic clk, rst, start_btn, clear_btn, stop_btn,
    output logic ltr_flag, led0,
    output logic [3:0] digit0, digit1, digit2, digit3
);

typedef enum logic [4:0] {init = 5'b00001, start = 5'b00010, delay = 5'b00100, count = 5'b01000} state_type;

state_type curr_state, next_state;
logic load_counter, clear_counter, enable_counter, zero_count;
logic [3:0] random_val;

univ_bin_counter #(.N(32)) counter(.clk(clk), .reset(rst), .syn_clr(clear_counter), .load(load_counter), .en(enable_counter), .up(0), .d(100000000*random_val), .max_tick(), .min_tick(zero_count), .q());
LFSR_fib168pi rng(.clk(clk), .reset(rst), .seed(28'b1110_1100_0111_1110_0111_0110_1100), .r(random_val));

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
    case(curr_state)
        init:
            begin
                ltr_flag = 1;
                digit0 = 4'b1010;
                digit1 = 4'b0101;
                digit2 = 4'b1111;
                digit3 = 4'b1111;
                led0 = 0;
                
                enable_counter = 0;
                load_counter = 0;
                clear_counter = 1;
                
                if(start_btn == 1'b1) begin
                    next_state = start;
                end
            end
        start:
            begin
                ltr_flag = 0;
                digit0 = 4'b1111;
                digit1 = 4'b1111;
                digit2 = 4'b1111;
                digit3 = 4'b1111;
                led0 = 0;
                
                enable_counter = 0;
                clear_counter = 0;
                load_counter = 1;
                
                next_state = delay;
            end
        delay:
            begin
                ltr_flag = 0;
                digit0 = 4'b1111;
                digit1 = 4'b1111;
                digit2 = 4'b1111;
                digit3 = 4'b1111;
                led0 = 0;
            
                load_counter = 0;
                enable_counter = 1;
                clear_counter = 0;
                
                if(zero_count == 1)
                    next_state = count;
            end
        count:
            begin
                ltr_flag = 0;
                digit0 = 4'b1111;
                digit1 = 4'b1111;
                digit2 = 4'b1111;
                digit3 = 4'b1111;
                led0 = 1;
            
                load_counter = 0;
                enable_counter = 0;
                clear_counter = 0;
            end
//        stop:
//            begin
//                // Do stuff
//            end
        default:
            begin
                next_state = init;
                ltr_flag = 0;
                digit0 = 4'b1111;
                digit1 = 4'b1111;
                digit2 = 4'b1111;
                digit3 = 4'b1111;
                led0 = 0;
                
                load_counter = 0;
                enable_counter = 0;
                clear_counter = 0;
            end
    endcase
end


endmodule
