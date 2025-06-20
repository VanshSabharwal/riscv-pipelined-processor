# RISC-V Pipelined Processor

## Overview
A 5-stage pipelined RISC-V processor written in Verilog. It supports the RV32I instruction set and includes hazard detection, forwarding logic, and basic branching.
![image](https://github.com/user-attachments/assets/96b64df0-5c53-4045-80b5-19f98da577d6)


## Features
- Instruction Fetch, Decode, Execute, Memory, Writeback stages
- Hazard detection and forwarding units
- ALU, register file, control unit, and data memory
- Testbench for simulation and verification

## Files
- `top.v` – Top module
- `datapath.v` – Datapath including all pipeline stages
- `controller.v` – Control signal generator
- `alu.v` – Arithmetic Logic Unit
- `hazard.v` – Hazard detection and forwarding logic
- `regfile.v` – Register file
- `tb.v` – Testbench

## Tools Used
- Verilog HDL
- Vivado

## How to Simulate
1. Compile all `.v` files.
2. Include `regfile_init.hex` and `rvp.hex` as memory files
3. Run the testbench: `tb.v`

## Simulation
![image](https://github.com/user-attachments/assets/99dec444-cc2c-46c6-820f-8e487a1e46ca)



## Author
Vansh Sabharwal – B.Tech in Electrical Engineering, IIT Indore
