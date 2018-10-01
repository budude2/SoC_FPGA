module ClkDivider (
    input logic clk, rst,
    output logic clk_div
    );

    localparam constNumber = 10000000;
    
    logic [31:0] count;
     
    always_ff @(posedge clk, posedge rst) begin
        if (rst == 1'b1)
            count <= 32'b0;
        else if (count == constNumber - 1)
            count <= 32'b0;
        else
            count <= count + 1;
    end
    
    always_ff @(posedge(clk), posedge(rst))
    begin
        if (rst == 1'b1)
            clk_div <= 1'b0;
        else if (count == constNumber - 1)
            clk_div <= ~clk_div;
        else
            clk_div <= clk_div;
    end

endmodule