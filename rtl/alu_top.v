module alu_top (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [3:0] Opcode,
    output wire [7:0] Result,
    output wire        Zero_Flag,
    output wire        Carry_Flag,
    output wire        Overflow_Flag,
    output wire        Negative_Flag,
    output wire        Parity_Flag
);

    // Control signals
    wire [1:0] arith_sel;
    wire [1:0] logic_sel;
    wire [1:0] shift_sel;
    wire        rotate_sel;
    wire [1:0] compare_sel;
    wire [2:0] result_sel;

    // Sub-unit result buses
    wire [7:0] arith_result;
    wire        arith_carry;
    wire        arith_overflow;

    wire [7:0] logic_result;
    wire [7:0] shift_result;
    wire [7:0] rotate_result;
    wire [7:0] compare_result;

    // ---------------------------------------------------------------
    // Control Unit
    // ---------------------------------------------------------------
    control_unit u_control_unit (
        .Opcode      (Opcode),
        .arith_sel   (arith_sel),
        .logic_sel   (logic_sel),
        .shift_sel   (shift_sel),
        .rotate_sel  (rotate_sel),
        .compare_sel (compare_sel),
        .result_sel  (result_sel)
    );

    // ---------------------------------------------------------------
    // Functional Sub-Units
    // ---------------------------------------------------------------
    arithmetic_unit u_arithmetic_unit (
        .A         (A),
        .B         (B),
        .arith_sel (arith_sel),
        .result    (arith_result),
        .carry     (arith_carry),
        .overflow  (arith_overflow)
    );

    logical_unit u_logical_unit (
        .A         (A),
        .B         (B),
        .logic_sel (logic_sel),
        .result    (logic_result)
    );

    shift_unit u_shift_unit (
        .A         (A),
        .B         (B),
        .shift_sel (shift_sel),
        .result    (shift_result)
    );

    rotate_unit u_rotate_unit (
        .A          (A),
        .B          (B),
        .rotate_sel (rotate_sel),
        .result     (rotate_result)
    );

    comparator_unit u_comparator_unit (
        .A           (A),
        .B           (B),
        .compare_sel (compare_sel),
        .result      (compare_result)
    );

    // ---------------------------------------------------------------
    // Result Multiplexer
    // ---------------------------------------------------------------
    result_mux u_result_mux (
        .arith_result   (arith_result),
        .logic_result   (logic_result),
        .shift_result   (shift_result),
        .rotate_result  (rotate_result),
        .compare_result (compare_result),
        .result_sel     (result_sel),
        .final_result   (Result)
    );

    // ---------------------------------------------------------------
    // Flag Unit
    // ---------------------------------------------------------------
    flag_unit u_flag_unit (
        .final_result    (Result),
        .arith_carry     (arith_carry),
        .arith_overflow  (arith_overflow),
        .result_sel      (result_sel),
        .zero_flag       (Zero_Flag),
        .carry_flag      (Carry_Flag),
        .overflow_flag   (Overflow_Flag),
        .negative_flag   (Negative_Flag),
        .parity_flag     (Parity_Flag)
    );

endmodule
