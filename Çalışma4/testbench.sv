module tb_multiplier();

// test giriş çıkışları
logic [3:0] A_test;
logic [3:0] B_test;
logic [7:0] P_test;

// devreyi çağırdık
multiplier_4bit uut (
    .A(A_test),
    .B(B_test),
    .P(P_test)
);

initial begin
    // binary değil decimal (%d) okuyalım 
    $monitor("Zaman=%0t | A = %d, B = %d | Çarpım Sonucu = %d", $time, A_test, B_test, P_test);

    // denemeler (sırasıyla 15, 72, 225, 0 çıkması lazım)
    A_test = 4'd5;  B_test = 4'd3;  #10; // 5 x 3
    A_test = 4'd8;  B_test = 4'd9;  #10; // 8 x 9
    A_test = 4'd15; B_test = 4'd15; #10; // 15 x 15 (max sınır patlıyor mu testi)
    A_test = 4'd0;  B_test = 4'd7;  #10; // sıfırla çarpım testi
    
    $finish;
end

endmodule