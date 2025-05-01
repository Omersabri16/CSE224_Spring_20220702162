module alu (
    input [7:0] A,
    input [7:0] B,
    input [2:0] OPCODE,
    output reg [7:0] OUT
);

    always @(*) begin
        case (OPCODE)
            3'b000: OUT = ~A;                        // Invert A
            3'b001: OUT = A | B;                     // OR
            3'b010: OUT = A ^ B;                     // XOR
            3'b011: OUT = A & B;                     // AND
            3'b100: OUT = (A[3:0] * B[3:0]);         // 4x4 Multiplier
            3'b101: OUT = A + B;                     // 8-bit Addition
            3'b110: OUT = A - B;                     // 8-bit Subtraction
            default: OUT = 8'b00000000;              // Default/Reserved
        endcase
    end

endmodule