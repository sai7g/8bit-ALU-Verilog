module shift_unit (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [1:0] shift_sel,
    output reg  [7:0] result
);

    localparam SHIFT_LEFT          = 2'b00;
    localparam SHIFT_RIGHT_LOGICAL = 2'b01;
    localparam SHIFT_RIGHT_ARITH   = 2'b10;

    wire [2:0] shamt = B[2:0];

    always @(*) begin
        case (shift_sel)
            SHIFT_LEFT         : result = A << shamt;
            SHIFT_RIGHT_LOGICAL: result = A >> shamt;
            SHIFT_RIGHT_ARITH  : result = $signed(A) >>> shamt;
            default            : result = 8'd0;
        endcase
    end

endmodule
