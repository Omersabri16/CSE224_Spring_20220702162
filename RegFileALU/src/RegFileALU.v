module RegFileALU (
    input clk,
    input we3,
    input [4:0] a1, a2, a3,
    input [31:0] wd3,
    input [1:0] alu_op,
    output [31:0] rd1,
    output [31:0] rd2,
    output reg [31:0] alu_result
);

    reg [31:0] registers [0:31];

    // Read operations 
    assign rd1 = registers[a1];
    assign rd2 = registers[a2];

    // Write operation 
    always @(posedge clk) begin
        if (we3)
            registers[a3] <= wd3;
    end

    // ALU operation 
    always @(*) begin
        case (alu_op)
            2'b00: alu_result = rd1 + rd2; // ADD
            2'b01: alu_result = rd1 - rd2; // SUB
            2'b10: alu_result = rd1 << rd2; // SHIFT LEFT
            2'b11: alu_result = rd1 >> rd2; // SHIFT RIGHT
            default: alu_result = 32'd0;
        endcase
    end

endmodule
