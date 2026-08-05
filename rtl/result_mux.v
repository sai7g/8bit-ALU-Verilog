module result_mux (
    input  wire [7:0] arith_result,
    input  wire [7:0] logic_result,
    input  wire [7:0] shift_result,
    input  wire [7:0] rotate_result,
    input  wire [7:0] compare_result,
    input  wire [2:0] result_sel,
    output reg  [7:0] final_result
);

    localparam RESULT_ARITH   = 3'b000;
    localparam RESULT_LOGIC   = 3'b001;
    localparam RESULT_SHIFT   = 3'b010;
    localparam RESULT_ROTATE  = 3'b011;
    localparam RESULT_COMPARE = 3'b100;

    always @(*) begin
        case (result_sel)
            RESULT_ARITH  : final_result = arith_result;
            RESULT_LOGIC  : final_result = logic_result;
            RESULT_SHIFT  : final_result = shift_result;
            RESULT_ROTATE : final_result = rotate_result;
            RESULT_COMPARE: final_result = compare_result;
            default       : final_result = 8'd0;
        endcase
    end

endmodule
