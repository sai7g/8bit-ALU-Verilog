module rotate_unit (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire        rotate_sel,
    output reg  [7:0] result
);

    localparam ROTATE_LEFT  = 1'b0;
    localparam ROTATE_RIGHT = 1'b1;

    wire [2:0] rotamt = B[2:0];

    always @(*) begin
        if (rotamt == 3'd0) begin
            result = A;
        end
        else begin
            case (rotate_sel)
                ROTATE_LEFT : result = (A << rotamt) | (A >> (4'd8 - rotamt));
                ROTATE_RIGHT: result = (A >> rotamt) | (A << (4'd8 - rotamt));
                default     : result = 8'd0;
            endcase
        end
    end

endmodule
