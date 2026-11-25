`timescale 1ns/1ps

module testbench;

    logic       clk;
    logic       rst;
    logic       en;
    logic       jump_en;
    logic [7:0] jump_addr;
    logic [7:0] pc;

    // modülü bağla
    program_counter uut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .jump_en(jump_en),
        .jump_addr(jump_addr),
        .pc(pc)
    );

    // 10 ns periyotlu saat sinyali
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // dalga formu kaydı
        $dumpfile("dump.vcd");
        $dumpvars(0, testbench);

        // konsol çıktısı
        $monitor("Zaman=%2t ns | rst=%b en=%b jump_en=%b jump_addr=%2d | pc=%2d", 
                 $time, rst, en, jump_en, jump_addr, pc);

        // 0-12 ns: reset
        rst = 1; en = 0; jump_en = 0; jump_addr = 8'd0;
        #12;

        // 12-40 ns: normal sayma
        rst = 0; en = 1;
        #28;

        // 40-60 ns: duraklatma
        en = 0;
        #20;

        // 60-70 ns: 20 adresine atlama
        en = 1; jump_en = 1; jump_addr = 8'd20;
        #10;

        // 70-90 ns: 20'den devam
        jump_en = 0;
        #20;

        $finish;
    end

endmodule
