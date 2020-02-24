analyze -f vhdl -lib WORK ../src/param.vhd
analyze -f vhdl -lib WORK ../src/alu_param.vhd
analyze -f vhdl -lib WORK ../src/regn.vhd
analyze -f vhdl -lib WORK ../src/reg_file.vhd
analyze -f vhdl -lib WORK ../src/next_addr_sel_cu.vhd
analyze -f vhdl -lib WORK ../src/mux3to1.vhd
analyze -f vhdl -lib WORK ../src/mux2to1.vhd
analyze -f vhdl -lib WORK ../src/imm_gen.vhd
analyze -f vhdl -lib WORK ../src/hazard_det_unit.vhd
analyze -f vhdl -lib WORK ../src/fwd.vhd
analyze -f vhdl -lib WORK ../src/cu.vhd
analyze -f vhdl -lib WORK ../src/alu_decoder.vhd
analyze -f vhdl -lib WORK ../src/alu.vhd
analyze -f vhdl -lib WORK ../src/main.vhd


set power_preserve_rtl_hier_names true

uniquify

link

elaborate main -arch beh -lib WORK

create_clock -name MY_CLK -period 1.6 {clk}
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
compile
report_timing > ./Reports/report_timing.txt
report_area > ./Reports/report_area.txt
report_power > ./Reports/report_power.txt

ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ../netlist/main.sdf
write -f verilog -hierarchy -output ../netlist/main.v
write_sdc ../netlist/main.sdc