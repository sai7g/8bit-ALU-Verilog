module control_unit (
    input  wire [3:0] Opcode,
    output reg  [1:0] arith_sel,
    output reg  [1:0] logic_sel,
    output reg  [1:0] shift_sel,
    output reg        rotate_sel,
    output reg  [1:0] compare_sel,
    output reg  [2:0] result_sel
);

    // Opcode map
    localparam OP_ADD = 4'b0000;
    localparam OP_SUB = 4'b0001;
    localparam OP_INC = 4'b0010;
    localparam OP_DEC = 4'b0011;
    localparam OP_AND = 4'b0100;
    localparam OP_OR  = 4'b0101;
    localparam OP_XOR = 4'b0110;
    localparam OP_NOT = 4'b0111;
    localparam OP_SHL = 4'b1000;
    localparam OP_SHR = 4'b1001;
    localparam OP_SRA = 4'b1010;
    localparam OP_ROL = 4'b1011;
    localparam OP_ROR = 4'b1100;
    localparam OP_EQ  = 4'b1101;
    localparam OP_GT  = 4'b1110;
    localparam OP_LT  = 4'b1111;

    // result_sel encoding
    localparam RESULT_ARITH   = 3'b000;
    localparam RESULT_LOGIC   = 3'b001;
    localparam RESULT_SHIFT   = 3'b010;
    localparam RESULT_ROTATE  = 3'b011;
    localparam RESULT_COMPARE = 3'b100;

    always @(*) begin
        // Safe defaults - avoid latches
        arith_sel   = 2'b00;
        logic_sel   = 2'b00;
        shift_sel   = 2'b00;
        rotate_sel  = 1'b0;
        compare_sel = 2'b00;
        result_sel  = RESULT_ARITH;

        case (Opcode)
            OP_ADD: begin arith_sel = 2'b00; result_sel = RESULT_ARITH; end
            OP_SUB: begin arith_sel = 2'b01; result_sel = RESULT_ARITH; end
            OP_INC: begin arith_sel = 2'b10; result_sel = RESULT_ARITH; end
            OP_DEC: begin arith_sel = 2'b11; result_sel = RESULT_ARITH; end

            OP_AND: begin logic_sel = 2'b00; result_sel = RESULT_LOGIC; end
            OP_OR : begin logic_sel = 2'b01; result_sel = RESULT_LOGIC; end
            OP_XOR: begin logic_sel = 2'b10; result_sel = RESULT_LOGIC; end
            OP_NOT: begin logic_sel = 2'b11; result_sel = RESULT_LOGIC; end

            OP_SHL: begin shift_sel = 2'b00; result_sel = RESULT_SHIFT; end
            OP_SHR: begin shift_sel = 2'b01; result_sel = RESULT_SHIFT; end
            OP_SRA: begin shift_sel = 2'b10; result_sel = RESULT_SHIFT; end

            OP_ROL: begin rotate_sel = 1'b0; result_sel = RESULT_ROTATE; end
            OP_ROR: begin rotate_sel = 1'b1; result_sel = RESULT_ROTATE; end

            OP_EQ : begin compare_sel = 2'b00; result_sel = RESULT_COMPARE; end
            OP_GT : begin compare_sel = 2'b01; result_sel = RESULT_COMPARE; end
            OP_LT : begin compare_sel = 2'b10; result_sel = RESULT_COMPARE; end

            default: begin
                arith_sel   = 2'b00;
                result_sel  = RESULT_ARITH;
            end
        endcase
    end

endmodule
