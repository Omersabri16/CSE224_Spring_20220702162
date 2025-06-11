
module ProgramCounter(
    input clk,
    input reset,
    input control,
    input [31:0] next_pc,
    output reg [31:0] pc
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 32'b0;
        else if (control)
            pc <= next_pc;
    end
endmodule

module ALU(
    input [31:0] A, B,
    input [2:0] ALUop,
    output reg [31:0] Result,
    output zero
);
    always @(*) begin
        case (ALUop)
            3'b000: Result = 32'b0;
            3'b001: Result = 32'b0;
            3'b010: Result = A + B;
            3'b011: Result = A - B;
            3'b100: Result = A << B[4:0];
            3'b101: Result = A >> B[4:0];
            3'b110: Result = A + B;
            3'b111: Result = A - B;
            default: Result = 32'b0;
        endcase
    end
    assign zero = (Result == 0);
endmodule

module InstructionMemory(
    input [31:0] address,
    output reg [31:0] instruction
);
    always @(*) begin
        case (address)
            32'h00000000: instruction = 32'h00a00513;
            32'h00000004: instruction = 32'h00f00793;
            32'h00000008: instruction = 32'h00f505b3;
            32'h0000000c: instruction = 32'hffb58613;
            32'h00000010: instruction = 32'h00200293;
            32'h00000014: instruction = 32'h005596b3;
            default: instruction = 32'b0;
        endcase
    end
endmodule

module RegFile(
    input clk,
    input reset,
    input [4:0] read_reg1, read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    input reg_write,
    output [31:0] read_data1, read_data2
);
    reg [31:0] registers [0:31];
    integer i;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'b0;
        end else if (reg_write && write_reg != 0) begin
            registers[write_reg] <= write_data;
        end
    end
    assign read_data1 = (read_reg1 != 0) ? registers[read_reg1] : 32'b0;
    assign read_data2 = (read_reg2 != 0) ? registers[read_reg2] : 32'b0;
endmodule

module InstructionDecoder(
    input [31:0] instruction,
    output reg [4:0] rs1, rs2, rd,
    output reg [31:0] imm,
    output reg [2:0] ALUop,
    output reg [1:0] pc_sel
);
    wire [6:0] opcode = instruction[6:0];
    wire [2:0] funct3 = instruction[14:12];
    always @(*) begin
        rs1 = instruction[19:15];
        rs2 = instruction[24:20];
        rd  = instruction[11:7];
        imm = 32'b0;
        pc_sel = 2'b00;
        case (opcode)
            7'b0010011: begin
                imm = {{20{instruction[31]}}, instruction[31:20]};
                ALUop = 3'b110;
            end
            7'b0110011: begin
                case (funct3)
                    3'b000: ALUop = 3'b010;
                    3'b001: ALUop = 3'b100;
                    3'b101: ALUop = 3'b101;
                    default: ALUop = 3'b000;
                endcase
            end
            7'b1100011: begin
                imm = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
                ALUop = 3'b011;
                pc_sel = 2'b01;
            end
            7'b1101111: begin
                imm = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
                ALUop = 3'b000;
                pc_sel = 2'b10;
            end
            default: ALUop = 3'b000;
        endcase
    end
endmodule

module SevenSegmentDisplay(
    input clk,
    input [31:0] data,
    output reg [6:0] seg,
    output reg [7:0] an
);
    reg [19:0] counter;
    reg [3:0] digit;
    reg [2:0] digit_sel;
    initial begin
        counter = 0;
        digit_sel = 0;
        an = 8'b11111110;
    end
    always @(posedge clk) begin
        counter <= counter + 1;
        if (counter == 20'hFFFFF) begin
            digit_sel <= digit_sel + 1;
            if (digit_sel == 3'b111) digit_sel <= 3'b0;
        end
        case (digit_sel)
            3'b000: begin digit = data[3:0];   an = 8'b11111110; end
            3'b001: begin digit = data[7:4];   an = 8'b11111101; end
            3'b010: begin digit = data[11:8];  an = 8'b11111011; end
            3'b011: begin digit = data[15:12]; an = 8'b11110111; end
            3'b100: begin digit = data[19:16]; an = 8'b11101111; end
            3'b101: begin digit = data[23:20]; an = 8'b11011111; end
            3'b110: begin digit = data[27:24]; an = 8'b10111111; end
            3'b111: begin digit = data[31:28]; an = 8'b01111111; end
            default: begin digit = 4'b0000; an = 8'b11111111; end
        endcase
        case (digit)
            4'h0: seg = 7'b1000000;
            4'h1: seg = 7'b1111001;
            4'h2: seg = 7'b0100100;
            4'h3: seg = 7'b0110000;
            4'h4: seg = 7'b0011001;
            4'h5: seg = 7'b0010010;
            4'h6: seg = 7'b0000010;
            4'h7: seg = 7'b1111000;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0010000;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b0000011;
            4'hC: seg = 7'b1000110;
            4'hD: seg = 7'b0100001;
            4'hE: seg = 7'b0000110;
            4'hF: seg = 7'b0001110;
            default: seg = 7'b1111111;
        endcase
    end
endmodule

module CPU(
    input clk,
    input reset,
    input control,
    output [6:0] seg,
    output [7:0] an
);
    wire [31:0] pc_out, instruction;
    wire [4:0] rs1, rs2, rd;
    wire [31:0] imm, reg_data1, reg_data2, alu_result;
    wire [2:0] ALUop;
    wire [1:0] pc_sel;
    wire zero_flag;
    reg prev_control;
    wire pulse = control && !prev_control;
    always @(posedge clk) prev_control <= control;
    wire [31:0] next_pc;
    assign next_pc = (pc_sel == 2'b01 && zero_flag) ? pc_out + imm :
                     (pc_sel == 2'b10)              ? pc_out + imm :
                                                      pc_out + 4;
    ProgramCounter pc(.clk(clk), .reset(reset), .control(pulse), .next_pc(next_pc), .pc(pc_out));
    InstructionMemory imem(.address(pc_out), .instruction(instruction));
    InstructionDecoder decoder(.instruction(instruction), .rs1(rs1), .rs2(rs2), .rd(rd), .imm(imm), .ALUop(ALUop), .pc_sel(pc_sel));
    RegFile reg_file(.clk(clk), .reset(reset), .read_reg1(rs1), .read_reg2(rs2), .write_reg(rd), .write_data(alu_result),
                     .reg_write(pulse && (instruction != 32'b0) && (rd != 0) && pc_sel == 2'b00),
                     .read_data1(reg_data1), .read_data2(reg_data2));
    ALU alu(.A(reg_data1), .B((ALUop == 3'b110 || ALUop == 3'b111) ? imm : reg_data2), .ALUop(ALUop), .Result(alu_result), .zero(zero_flag));
    SevenSegmentDisplay display(.clk(clk), .data(alu_result), .seg(seg), .an(an));
endmodule
