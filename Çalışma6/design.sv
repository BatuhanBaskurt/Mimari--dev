// 8-bit register modülü
module register_8bit (
    input  logic       clk,
    input  logic       rst,
    input  logic       en,
    input  logic [7:0] d,
    output logic [7:0] q
);
    // rst=1 ise sıfırla, en=1 ise yaz
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            q <= 8'd0;
        else if (en)
            q <= d;
    end
endmodule

// Program Sayacı (PC) modülü
module program_counter (
    input  logic       clk,
    input  logic       rst,
    input  logic       en,
    input  logic       jump_en,
    input  logic [7:0] jump_addr,
    output logic [7:0] pc
);
    logic [7:0] pc_next;

    // jump_en=1 ise jump_addr, değilse pc+1 seç
    assign pc_next = jump_en ? jump_addr : (pc + 8'd1);

    // 8-bit register bağlantısı
    register_8bit pc_reg (
        .clk(clk),
        .rst(rst),
        .en(en),
        .d(pc_next),
        .q(pc)
    );
endmodule
