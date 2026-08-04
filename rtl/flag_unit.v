module flag_unit (
    input  wire [7:0] final_result,
    input  wire        arith_carry,
    input  wire        arith_overflow,
    input  wire [2:0] result_sel,
    output wire        zero_flag,
    output wire        carry_flag,
    output wire        overflow_flag,
    output wire        negative_flag,
    output wire        parity_flag
);

    localparam RESULT_ARITH = 3'b000;

    assign zero_flag     = (final_result == 8'd0);
    assign carry_flag    = (result_sel == RESULT_ARITH) ? arith_carry    : 1'b0;
    assign overflow_flag = (result_sel == RESULT_ARITH) ? arith_overflow : 1'b0;
    assign negative_flag = final_result[7];
    assign parity_flag   = ~^final_result; // 1 = even parity (even number of 1s)

endmodule
