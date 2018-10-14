module circle_shift_reg
   (
       input clk,
       input rst,
       input load_en,
       input shift_en,
       input [31:0] d_load,
       output [3:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7
   );

logic [3:0] int0, int1, int2, int3, int4, int5, int6, int7;

custom_ff reg0(.clk(clk), .rst(rst), .load_en(load_en), .shift_en(shift_en), .d_load(d_load[3:0]), .d(int7), .q(int0));
custom_ff reg1(.clk(clk), .rst(rst), .load_en(load_en), .shift_en(shift_en), .d_load(d_load[7:4]), .d(int0), .q(int1));
custom_ff reg2(.clk(clk), .rst(rst), .load_en(load_en), .shift_en(shift_en), .d_load(d_load[11:8]), .d(int1), .q(int2));
custom_ff reg3(.clk(clk), .rst(rst), .load_en(load_en), .shift_en(shift_en), .d_load(d_load[15:12]), .d(int2), .q(int3));
custom_ff reg4(.clk(clk), .rst(rst), .load_en(load_en), .shift_en(shift_en), .d_load(d_load[19:16]), .d(int3), .q(int4));
custom_ff reg5(.clk(clk), .rst(rst), .load_en(load_en), .shift_en(shift_en), .d_load(d_load[23:20]), .d(int4), .q(int5));
custom_ff reg6(.clk(clk), .rst(rst), .load_en(load_en), .shift_en(shift_en), .d_load(d_load[27:24]), .d(int5), .q(int6));
custom_ff reg7(.clk(clk), .rst(rst), .load_en(load_en), .shift_en(shift_en), .d_load(d_load[31:28]), .d(int6), .q(int7));

assign seg0 = int0;
assign seg1 = int1;
assign seg2 = int2;
assign seg3 = int3;
assign seg4 = int4;
assign seg5 = int5;
assign seg6 = int6;
assign seg7 = int7;

endmodule