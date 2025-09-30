`timescale 1ns/1ps

module sequence_controller (
    input  logic clk,
    input  logic rst_,
    input  logic zero,
    input  logic [2:0] opcode,
    output logic mem_rd,
    output logic load_ir,
    output logic halt,
    output logic inc_pc,
    output logic load_ac,
    output logic load_pc,
    output logic mem_wr
);

    // Opcode definitions
    localparam logic [2:0] 
        ADD = 3'b000,
        AND = 3'b001,
        XOR = 3'b010,
        LDA = 3'b011,
        STO = 3'b100,
        JMP = 3'b101,
        SKZ = 3'b110,
        HLT = 3'b111;

    // State definitions
    typedef enum logic [2:0] {
        INST_ADDR, INST_FETCH, INST_LOAD, IDLE,
        OP_ADDR, OP_FETCH, ALU_OP, STORE
    } state_t;

    state_t current_state, next_state;

    // State register
    always_ff @(posedge clk or negedge rst_) begin
        if (!rst_)
            current_state <= INST_ADDR;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            INST_ADDR:  next_state = INST_FETCH;
            INST_FETCH: next_state = INST_LOAD;
            INST_LOAD:  next_state = IDLE;
            IDLE:       next_state = OP_ADDR;
            OP_ADDR:    next_state = OP_FETCH;
            OP_FETCH:   next_state = ALU_OP;
            ALU_OP:     next_state = STORE;
            STORE:      next_state = INST_ADDR;
            default:    next_state = INST_ADDR;
        endcase
    end

    // Output logic
    always_comb begin
        // Default outputs
        mem_rd   = 0;
        load_ir  = 0;
        halt     = 0;
        inc_pc   = 0;
        load_ac  = 0;
        load_pc  = 0;
        mem_wr   = 0;

        case (current_state)
            INST_FETCH: mem_rd = 1;
            INST_LOAD: begin
                mem_rd  = 1;
                load_ir = 1;
            end
            OP_ADDR: begin
                if (opcode == HLT) halt = 1;
                else inc_pc = 1;
            end
            OP_FETCH: begin
                if (opcode == ADD || opcode == AND || opcode == XOR || opcode == LDA) begin
                    mem_rd   = 1;
                    load_ac  = 1;
                end
            end
            ALU_OP: begin
                if (opcode == ADD || opcode == AND || opcode == XOR || opcode == LDA) begin
                    mem_rd   = 1;
                    load_ac  = 1;
                end
                else if (opcode == JMP || opcode == SKZ) begin
                    load_pc = 1;
                    if (opcode == SKZ && zero) inc_pc = 1;
                end
            end
            STORE: begin
                if (opcode == STO) mem_wr = 1;
            end
        endcase
    end

endmodule
