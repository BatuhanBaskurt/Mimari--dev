module full_adder(
    input  logic a, b, cin,
    output logic sum, cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule

module adder_4bit (
    input  logic [3:0] A, B,
    input  logic Cin,
    output logic [3:0] Sum,
    output logic Cout
);
    logic c1, c2, c3; 

    // 4-bit Ripple Carry Adder
    full_adder fa0 (.a(A[0]), .b(B[0]), .cin(Cin), .sum(Sum[0]), .cout(c1));
    full_adder fa1 (.a(A[1]), .b(B[1]), .cin(c1),  .sum(Sum[1]), .cout(c2));
    full_adder fa2 (.a(A[2]), .b(B[2]), .cin(c2),  .sum(Sum[2]), .cout(c3));
    full_adder fa3 (.a(A[3]), .b(B[3]), .cin(c3),  .sum(Sum[3]), .cout(Cout));

endmodule
