`timescale 1ns/1ps

module test9;

    logic [31:0] sayi;
    logic        isaret;
    logic [7:0]  us;
    logic [22:0] kesir;
    logic        sifir, denormal, normal, sonsuz, nan;

    hafta9 uut (.*);

    // Test vektorleri: deger ve beklenen {sifir,denormal,normal,sonsuz,nan}
    localparam int N = 13;
    logic [31:0] vektor   [N];
    logic [4:0]  beklenen [N];

    task automatic ekle(input int i, input logic [31:0] v, input logic [4:0] b);
        vektor[i]   = v;
        beklenen[i] = b;
    endtask

    initial begin
        ekle(0,  32'h00000000, 5'b10000);
        ekle(1,  32'h80000000, 5'b10000);
        ekle(2,  32'h427d0000, 5'b00100);
        ekle(3,  32'hbfc00000, 5'b00100);
        ekle(4,  32'h00000001, 5'b01000);
        ekle(5,  32'h7f800000, 5'b00010);
        ekle(6,  32'hff800000, 5'b00010);
        ekle(7,  32'h7fc00001, 5'b00001);
        ekle(8,  32'h007fffff, 5'b01000);
        ekle(9,  32'h00800000, 5'b00100);
        ekle(10, 32'h7f7fffff, 5'b00100);
        ekle(11, 32'h7f800001, 5'b00001);
        ekle(12, 32'hffffffff, 5'b00001);
    end

    int hata = 0;

    initial begin
        #1;
        $display("Hex Giris    | S | Exp | Zero | SubN | Norm | Inf | NaN");
        $display("-----------------------------------------------------------");
        for (int i = 0; i < N; i++) begin
            sayi = vektor[i];
            #10;
            $display("0x%08h | %b | %3d |  %b   |  %b   |  %b   |  %b  |  %b  %s",
                     sayi, isaret, us, sifir, denormal, normal, sonsuz, nan,
                     ({sifir, denormal, normal, sonsuz, nan} == beklenen[i]) ? "" : "<-- HATA");
            if ({sifir, denormal, normal, sonsuz, nan} !== beklenen[i]) hata++;
        end
        $display("-----------------------------------------------------------");
        if (hata == 0) $display("SONUC: TUM TESTLER BASARILI");
        else           $display("SONUC: %0d HATA", hata);
        $finish;
    end

endmodule
