vcom -93 -work ./work ../src/param.vhd 
vcom -93 -work ./work ../src/fir_filter.vhd
vcom -93 -work ./work ../src/fir_block_1_2.vhd
vcom -93 -work ./work ../src/fir_block_3.vhd
vcom -93 -work ./work ../src/adder.vhd
vcom -93 -work ./work ../src/mult.vhd
vcom -93 -work ./work ../src/add_mult1.vhd
vcom -93 -work ./work ../src/add_mult2.vhd
vcom -93 -work ./work ../src/add_mult3.vhd
vcom -93 -work ./work ../src/reg_n.vhd
vcom -93 -work ./work ../src/reg_coeff.vhd
vcom -93 -work ./work ../src/ff.vhd

vcom -93 -work ./work ../tb/fir_tb.vhd

vsim -t ns -novopt work.fir_tb

set NumericStdNoWarnings 1 
run 0 ps
set NumericStdNoWarnings 0 

add wave -radix binary   -color GREEN      sim:/fir_tb/tb_clk
add wave -radix binary   -color GREEN      sim:/fir_tb/tb_rst_n
add wave -radix binary   -color GREEN      sim:/fir_tb/tb_vin
add wave -radix binary   -color GREEN      sim:/fir_tb/tb_din
add wave -radix binary   -color GREEN      sim:/fir_tb/tb_b
add wave -radix binary   -color RED        sim:/fir_tb/tb_dout
add wave -radix binary   -color RED        sim:/fir_tb/tb_vout

run 500 ns
