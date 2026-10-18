`timescale 1ns / 1ps

module tb_adder_4bit;

    logic [3:0] A, B;
    logic Cin;
    logic [3:0] Sum;
    logic Cout;

    adder_4bit uut (
        .A(A), .B(B), .Cin(Cin),
        .Sum(Sum), .Cout(Cout)
    );

    initial begin
        // Init
        A = 0; B = 0; Cin = 0;
        #10;
        
        // Test 1: 5 + 3 = 8 
        A = 4'b0101; B = 4'b0011; Cin = 0;
        #10;
        
        // Test 2: 15 + 1 = 16 
        A = 4'b1111; B = 4'b0001; Cin = 0;
        #10;
        
        // Test 3: 10 + 10 + 1 = 21 
        A = 4'b1010; B = 4'b1010; Cin = 1;
        #10;

        $display("Test tamamlandi.");
        $finish; 
    end

endmodule
