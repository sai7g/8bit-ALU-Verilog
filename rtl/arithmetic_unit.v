//=====================================================================
// Module      : arithmetic_unit
// Description : Performs ADD, SUB, INC, DEC on 8-bit operands A and B.
//               Pure combinational logic. Generates Carry/Borrow and
//               Overflow flags for the selected operation.
//=====================================================================
module arithmetic_unit (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [1:0] arith_sel,
    output reg  [7:0] result,
    output reg         carry,
    output reg         overflow
);

    // Arithmetic operation select codes
    localparam ARITH_ADD = 2'b00;
    localparam ARITH_SUB = 2'b01;
    localparam ARITH_INC = 2'b10;
    localparam ARITH_DEC = 2'b11;

    reg [8:0] temp; // 9-bit to capture carry/borrow out

    always @(*) begin
        temp     = 9'd0;
        result   = 8'd0;
        carry    = 1'b0;
        overflow = 1'b0;

        case (arith_sel)
            ARITH_ADD: begin
                temp     = {1'b0, A} + {1'b0, B};
                result   = temp[7:0];
                carry    = temp[8];
                overflow = (A[7] == B[7]) && (result[7] != A[7]);
            end

            ARITH_SUB: begin
                temp     = {1'b0, A} - {1'b0, B};
                result   = temp[7:0];
                carry    = temp[8]; // borrow flag: 1 => A < B
                overflow = (A[7] != B[7]) && (result[7] != A[7]);
            end

            ARITH_INC: begin
                temp     = {1'b0, A} + 9'd1;
                result   = temp[7:0];
                carry    = temp[8];
                overflow = (A == 8'h7F);
            end

            ARITH_DEC: begin
                temp     = {1'b0, A} - 9'd1;
                result   = temp[7:0];
                carry    = temp[8];
                overflow = (A == 8'h80);
            end

            default: begin
                result   = 8'd0;
                carry    = 1'b0;
                overflow = 1'b0;
            end
        endcase
    end

endmodule
