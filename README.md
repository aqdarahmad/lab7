FSM Sequence Controller in SystemVerilog
Overview

This project implements a Finite State Machine (FSM) Sequence Controller for a simple CPU using SystemVerilog.
The controller handles CPU instruction sequencing based on the opcode and generates the corresponding control signals for memory and ALU operations.

Features

Supports 8 CPU states:

INST_ADDR

INST_FETCH

INST_LOAD

IDLE

OP_ADDR

OP_FETCH

ALU_OP

STORE

Handles 3-bit opcodes: ADD, AND, XOR, LDA, STO, JMP, SKZ, HLT.

Generates 7 control signals:

mem_rd, load_ir, halt, inc_pc, load_ac, load_pc, mem_wr.

Implements reset and clocked operation with synchronous state transitions.

Fully testable using the provided testbench.

Files

lab7_q1.sv – FSM Sequence Controller module.

tb_lab7_q1.sv – Testbench for simulation and verification.

Simulation Instructions

Compile and run using Cadence Xrun or any SystemVerilog simulator:

xrun lab7_q1.sv tb_lab7_q1.sv


Observe the control signal behavior in the console or waveform viewer.

Test different opcodes in the testbench to verify correct FSM transitions.

Usage

Modify opcode and zero signals in the testbench to simulate various CPU instructions.

Reset the controller using rst_ signal.

Observe output signals for each clock cycle to verify the controller functionality.

Notes

The FSM cycles through all 8 states unconditionally.

The design uses localparam for opcode definitions for readability.

Designed for educational purposes to understand FSM design and SystemVerilog constructs
