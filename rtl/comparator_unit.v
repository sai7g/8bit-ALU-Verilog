module comparator_unit (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [1:0] compare_sel,
    output reg  [7:0] result
);

    localparam COMPARE_EQ = 2'b00;
    localparam COMPARE_GT = 2'b01;
    localparam COMPARE_LT = 2'b10;

    localparam [7:0] CMP_EQUAL   = 8'b0000_0001;
    localparam [7:0] CMP_GREATER = 8'b0000_0010;
    localparam [7:0] CMP_LESS    = 8'b0000_0100;

    always @(*) begin
        case (compare_sel)
            COMPARE_EQ: result = (A == B) ? CMP_EQUAL   : 8'b0;
            COMPARE_GT: result = (A >  B) ? CMP_GREATER : 8'b0;
            COMPARE_LT: result = (A <  B) ? CMP_LESS    : 8'b0;
            default   : result = 8'b0;
        endcase
    end

endmodule
