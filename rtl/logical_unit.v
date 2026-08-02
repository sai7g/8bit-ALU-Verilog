// Description : Performs bitwise AND, OR, XOR, NOT on 8-bit operands.

module logical_unit (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [1:0] logic_sel,
    output reg  [7:0] result
);

    localparam LOGIC_AND = 2'b00;
    localparam LOGIC_OR  = 2'b01;
    localparam LOGIC_XOR = 2'b10;
    localparam LOGIC_NOT = 2'b11;

    always @(*) begin
        case (logic_sel)
            LOGIC_AND: result = A & B;
            LOGIC_OR : result = A | B;
            LOGIC_XOR: result = A ^ B;
            LOGIC_NOT: result = ~A;
            default  : result = 8'd0;
        endcase
    end

endmodule
