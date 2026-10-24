// burası en temel yapı, full adder
module full_adder(
    input  logic a, b, cin,
    output logic sum, cout
);
    // xorlayıp toplamı buluyoz
    assign sum = a ^ b ^ cin;
    // burda da elde (carry) var mı ona bakıyoruz
    assign cout = (a & b) | (cin & (a ^ b));
endmodule

// 4 bitlik toplayıcı/çıkarıcı modülünü kuruyoz
module adder_subtractor_4bit (
    input  logic [3:0] A, B,
    input  logic sub, // sub 1 gelirse çıkarma, 0 gelirse toplama yapacak
    output logic [3:0] Sum,
    output logic Cout
);
    logic c1, c2, c3;
    logic [3:0] B_in; 

    // çıkarma yapacaksak b'nin bitlerini xor ile tersliyoz (2'ye tümleyen mantığı)
    assign B_in[0] = B[0] ^ sub;
    assign B_in[1] = B[1] ^ sub;
    assign B_in[2] = B[2] ^ sub;
    assign B_in[3] = B[3] ^ sub;

    // ripple carry adder olayı, carry leri birbirine bağlıyoz sırayla
    full_adder fa0 (.a(A[0]), .b(B_in[0]), .cin(sub), .sum(Sum[0]), .cout(c1));
    full_adder fa1 (.a(A[1]), .b(B_in[1]), .cin(c1),  .sum(Sum[1]), .cout(c2));
    full_adder fa2 (.a(A[2]), .b(B_in[2]), .cin(c2),  .sum(Sum[2]), .cout(c3));
    full_adder fa3 (.a(A[3]), .b(B_in[3]), .cin(c3),  .sum(Sum[3]), .cout(Cout));
endmodule

// asıl ALU'yu topladığımız yer burası
module alu_4bit(
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic [1:0] islem, // 00 topla, 01 çıkar, 10 and, 11 or olsun dedik
    output logic [4:0] sonuc // elde taşarsa diye 5 bit verdik
);
    logic [3:0] add_sub_sonuc;
    logic add_sub_cout;
    logic [3:0] and_sonuc;
    logic [3:0] or_sonuc;

    // islem[0] 1 ise çıkarıcı, 0 ise toplayıcı olarak çalışıyor alt modül
    adder_subtractor_4bit add_sub_inst (
        .A(a),
        .B(b),
        .sub(islem[0]), 
        .Sum(add_sub_sonuc),
        .Cout(add_sub_cout)
    );

    // and ve or kapıların
    assign and_sonuc = a & b;
    assign or_sonuc  = a | b;

    // mux mantığı, hangi işlem geldiyse onu sonuca basıyoz
    always_comb begin
        case(islem)
            2'b00: sonuc = {add_sub_cout, add_sub_sonuc}; // topla
            2'b01: sonuc = {add_sub_cout, add_sub_sonuc}; // çıkar
            2'b10: sonuc = {1'b0, and_sonuc};             // and, başına sıfır attık 5 bit olsun diye
            2'b11: sonuc = {1'b0, or_sonuc};              // or, buna da sıfır attık
            default: sonuc = 5'b00000;
        endcase
    end
endmodule