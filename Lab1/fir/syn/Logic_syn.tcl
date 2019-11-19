analyze -f vhdl -lib WORK ../src/param.vhd
analyze -f vhdl -lib WORK ../src/ff.vhd
analyze -f vhdl -lib WORK ../src/adder.vhd
analyze -f vhdl -lib WORK ../src/mult.vhd
analyze -f vhdl -lib WORK ../src/add_mult.vhd
analyze -f vhdl -lib WORK ../src/reg_n.vhd
analyze -f vhdl -lib WORK ../src/reg_coeff.vhd
analyze -f vhdl -lib WORK ../src/reg_chain.vhd
analyze -f vhdl -lib WORK ../src/fir_filter.vhd
analyze -f vhdl -lib WORK ../src/myfir.vhd

set power_preserve_rtl_hier_names true

elaborate myfir -arch beh -lib WORK

uniquify 

link

create_clock -name MY_CLK -period 18 {clk}
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
compile
report_timing > ./Reports/report_timing_fck_4.txt
report_area > ./Reports/report_area_fck_4.txt
report_power > ./Reports/report_power_fck_4.txt

ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ../netlist/myfir.sdf
write -f verilog -hierarchy -output ../netlist/myfir.v
write_sdc ../netlist/myfir.sdc
