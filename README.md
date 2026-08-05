# 8-Bit Basic ALU — Verilog HDL Project

## Overview
Modular, synthesizable 8-bit ALU supporting arithmetic, logical, shift,
rotate, and comparison operations, verified with Icarus Verilog (iverilog -g2001).
All modules compile and simulate cleanly with zero errors.

## Hierarchy
```
alu_top
├── control_unit       (opcode decode)
├── arithmetic_unit     (ADD, SUB, INC, DEC)
├── logical_unit        (AND, OR, XOR, NOT)
├── shift_unit           (SHL, logical SHR, arithmetic SHR)
├── rotate_unit           (ROL, ROR)
├── comparator_unit        (EQ, GT, LT)
├── result_mux              (selects final result)
└── flag_unit                (Zero/Carry/Overflow/Negative/Parity)
```

## Opcode Map
| Opcode | Operation | Opcode | Operation |
|--------|-----------|--------|-----------|
| 0000 | ADD | 1000 | Shift Left |
| 0001 | SUB | 1001 | Shift Right (logical) |
| 0010 | INC A | 1010 | Shift Right (arithmetic) |
| 0011 | DEC A | 1011 | Rotate Left |
| 0100 | AND | 1100 | Rotate Right |
| 0101 | OR | 1101 | Compare Equal |
| 0110 | XOR | 1110 | Compare Greater-Than |
| 0111 | NOT A | 1111 | Compare Less-Than |

## Design Assumption
Shift/rotate amount is taken from `B[2:0]` (0–7 bit positions), since the
original spec did not define a shift-amount source. This is called out
explicitly here in case the amount should instead be fixed at 1 bit —
one line change in `shift_unit.v` / `rotate_unit.v` if so.

## Flags
- **Zero**: final_result == 0
- **Carry**: valid only for arithmetic ops (0000–0011); gated to 0 otherwise. For SUB it represents borrow.
- **Overflow**: valid only for arithmetic ops; signed 2's-complement overflow. Gated to 0 otherwise.
- **Negative**: final_result[7]
- **Parity**: 1 = even number of 1-bits in final_result

## Running Simulations (Icarus Verilog)
```bash
# Individual unit, e.g. arithmetic_unit
iverilog -g2001 -o sim arithmetic_unit.v arithmetic_unit_tb.v
vvp sim

# Full ALU
iverilog -g2001 -o sim arithmetic_unit.v logical_unit.v shift_unit.v \
  rotate_unit.v comparator_unit.v flag_unit.v control_unit.v \
  result_mux.v alu_top.v alu_top_tb.v
vvp sim
```
All 9 testbenches were run against their modules during development —
every module compiled and every simulation completed with `$finish`
and correct expected values (verified in-session).

## File List
arithmetic_unit.v / _tb.v, logical_unit.v / _tb.v, shift_unit.v / _tb.v,
rotate_unit.v / _tb.v, comparator_unit.v / _tb.v, flag_unit.v / _tb.v,
control_unit.v / _tb.v, result_mux.v / _tb.v, alu_top.v / _tb.v
