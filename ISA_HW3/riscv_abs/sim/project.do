vcom -93 -work ./work ../tb/clk_gen.vhd

vlog -work ./work ../netlist/main.v
vlog -work ./work ../tb/data_mem.v
vlog -work ./work ../tb/instr_mem.v
vlog -work ./work ../tb/tb_main.v

vsim -L /software/dk/nangate45/verilog/msim6.2g work.tb_main
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_main/UUT=../netlist/main.sdf work.tb_main
vcd file ../vcd/main_syn.vcd
vcd add /tb_main/UUT/*

run 3 us
