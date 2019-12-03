analyze -f vhdl -lib WORK ../src/reg.vhd
analyze -f vhdl -lib WORK ../src/reg_1.vhd
analyze -f vhdl -lib WORK ../src/reg_7.vhd
analyze -f vhdl -lib WORK ../src/reg_27.vhd
analyze -f vhdl -lib WORK ../src/fpnormalize_fpnormalize.vhd
analyze -f vhdl -lib WORK ../src/fpround_fpround.vhd
analyze -f vhdl -lib WORK ../src/packfp_packfp.vhd
analyze -f vhdl -lib WORK ../src/unpackfp_unpackfp.vhd
analyze -f vhdl -lib WORK ../src/fpmul_stage1_struct.vhd
analyze -f vhdl -lib WORK ../src/fpmul_stage2_struct.vhd
analyze -f vhdl -lib WORK ../src/fpmul_stage3_struct.vhd
analyze -f vhdl -lib WORK ../src/fpmul_stage4_struct.vhd
analyze -f vhdl -lib WORK ../src/fpmul_pipeline.vhd

set power_preserve_rtl_hier_names true

elaborate FPmul -arch pipeline -lib WORK

ungroup -all -flatten

create_clock -name MY_CLK -period 0.8 {clk}
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]

set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

compile

optimize_registers

report_timing > ./Reports/report_timing_fpmul.txt
report_area > ./Reports/report_area_fpmul.txt
report_power > ./Reports/report_power_fpmul.txt
report_resources > ./Reports/report_resources_fpmul.txt

