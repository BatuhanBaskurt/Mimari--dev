module tb_alu();

// test için sinyalleri tanımlıyoz
logic [3:0] a_test;
logic [3:0] b_test;
logic [1:0] islem_test;
logic [4:0] sonuc_test;

// bizim tasarladığımız alu'yu buraya çağırıyoruz
alu_4bit uut (
    .a(a_test),
    .b(b_test),
    .islem(islem_test),
    .sonuc(sonuc_test)
);

initial begin
    // ekrana yazdırsın diye
    $monitor("Zaman=%0t | islem=%b | a=%b, b=%b | sonuc=%b", $time, islem_test, a_test, b_test, sonuc_test);

    // a'ya 5, b'ye 3 salladık test etmek için
    a_test = 4'b0101; 
    b_test = 4'b0011; 
    
    islem_test = 2'b00; #10; // burda toplama yapıyoz, sonuc 8 bekliyoz
    islem_test = 2'b01; #10; // burda çıkarma, sonuc 2 çıkmalı
    islem_test = 2'b10; #10; // and yapıyoz
    islem_test = 2'b11; #10; // or yapıyoz
    
    $finish; // testi bitir
end

endmodule