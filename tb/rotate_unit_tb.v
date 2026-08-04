`timescale 1ns/1ps

module rotate_unit_tb;

    reg  [7:0] A, B;
    reg        rotate_sel;
    wire [7:0] result;

    rotate_unit dut (
        .A(A), .B(B), .rotate_sel(rotate_sel), .result(result)
    );

    initial begin
        $dumpfile("rotate_unit_tb.vcd");
        $dumpvars(0, rotate_unit_tb);

        $monitor("t=%0t A=%h rotamt=%0d sel=%b | result=%h", $time, A, B[2:0], rotate_sel, result);

        // Rotate Left
        A = 8'h81; B = 8'd1; rotate_sel = 1'b0; #10; // -> 03
        A = 8'h01; B = 8'd0; rotate_sel = 1'b0; #10; // -> 01 (no rotate)
        A = 8'hF0; B = 8'd4; rotate_sel = 1'b0; #10; // -> 0F

        // Rotate Right
        A = 8'h81; B = 8'd1; rotate_sel = 1'b1; #10; // -> C0
        A = 8'h01; B = 8'd0; rotate_sel = 1'b1; #10; // -> 01 (no rotate)
        A = 8'h0F; B = 8'd4; rotate_sel = 1'b1; #10; // -> F0

        $display("rotate_unit_tb: All test vectors applied.");
        $finish;
    end

endmodule
