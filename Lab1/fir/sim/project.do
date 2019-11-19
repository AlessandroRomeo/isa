vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker_new.vhd
vcom -93 -work ./work ../tb/data_sink.vhd

vlog -work ./work ../netlist/myfir.v
vlog -work ./work ../tb/tb_fir.v

vsim -L /software/dk/nangate45/verilog/msim6.2g work.tb_fir
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_fir/UUT=../netlist/myfir.sdf work.tb_fir
vcd file ../vcd/myfir_syn.vcd
vcd add /tb_fir/UUT/*

run 3 us
