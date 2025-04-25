

module inverter(
    input [7:0] in,      // 8-bit input
    output [7:0] out     // 8-bit output
    );
    assign out = ~in + 1; // Taking 2's complement
endmodule
