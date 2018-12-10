module seven_seg
   (
    input  logic clk,
    input  logic reset,
    // slot interface
    input  logic cs,
    input  logic read,
    input  logic write,
    input  logic [4:0] addr,
    input  logic [31:0] wr_data,
    output logic [31:0] rd_data,
	output logic [7:0] an,
	output logic [7:0] sseg
   );

    // declaration
    logic [31:0] buf_reg0;
    logic [31:0] buf_reg1;
    logic wr_en;
    logic [1:0] wr_reg_en;

   // body
   // output buffer register
    always_ff @(posedge clk, posedge reset)
        if (reset) begin
            buf_reg0 <= 0;
			buf_reg1 <= 0;
		end
        else
            if (wr_en && wr_reg_en[0])
                buf_reg0 <= wr_data;
            else if (wr_en && wr_reg_en[1])
                buf_reg1 <= wr_data;
   // decoding logic
    assign wr_en = cs && write;

    always_comb begin
        case(addr)
            4'h0: begin
                wr_reg_en = 2'b01;
            end

            4'h1 : begin
                wr_reg_en = 2'b10;
            end

            default : begin
                wr_reg_en = 2'b00;
            end
        endcase
    end

   disp_hex_mux inst (
        .clk(clk), .reset(reset), .hex7(buf_reg0[31:28]), .hex6(buf_reg0[27:24]), .hex5(buf_reg0[23:20]), .hex4(buf_reg0[19:16]),
		.hex3(buf_reg0[15:12]), .hex2(buf_reg0[11:8]), .hex1(buf_reg0[7:4]), .hex0(buf_reg0[3:0]), .thresh(buf_reg1), .an(an), .sseg(sseg)
   );

endmodule