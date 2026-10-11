module tb_mux4to1;

    logic [7:0] d0, d1, d2, d3;
    logic [1:0] sel;
    logic [7:0] y;

    mux4to1 uut (
        .d0(d0), .d1(d1), .d2(d2), .d3(d3),
        .sel(sel), .y(y)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, tb_mux4to1);

        d0 = 8'hAA; 
        d1 = 8'hBB; 
        d2 = 8'hCC; 
        d3 = 8'hDD;

        sel = 2'b00; #10;
        $display("Time: %0t | sel: %b | y: %h | Expected: aa", $time, sel, y);

        sel = 2'b01; #10; 
        $display("Time: %0t | sel: %b | y: %h | Expected: bb", $time, sel, y);

        sel = 2'b10; #10; 
        $display("Time: %0t | sel: %b | y: %h | Expected: cc", $time, sel, y);

        sel = 2'b11; #10; 
        $display("Time: %0t | sel: %b | y: %h | Expected: dd", $time, sel, y);

        $finish;
    end

endmodule
