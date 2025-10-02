`timescale 1ns/1ps

module tb_seq_controller;
    logic clk, rst_;
    logic zero;
    logic [2:0] opcode;
    logic mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr;

    // DUT instantiation
    sequence_controller dut (
        .clk(clk),
        .rst_(rst_),
        .zero(zero),
        .opcode(opcode),
        .mem_rd(mem_rd),
        .load_ir(load_ir),
        .halt(halt),
        .inc_pc(inc_pc),
        .load_ac(load_ac),
        .load_pc(load_pc),
        .mem_wr(mem_wr)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // period = 10ns

    // Stimulus
    initial begin
        // reset
        rst_ = 0; zero = 0; opcode = 3'b000;
        #12;
        rst_ = 1;

        // Test ADD opcode
        opcode = 3'b000; // ADD
        repeat (10) @(posedge clk);

        // Test HLT opcode
        opcode = 3'b111; // HLT
        repeat (10) @(posedge clk);

        $finish;
    end
endmodule
///
//
