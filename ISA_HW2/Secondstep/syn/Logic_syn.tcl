analyze -f vhdl -lib WORK ../src/reg.vhd
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

create_clock -name MY_CLK -period 4.3 {clk}
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]

set_implementation DW02_mult/csa [find cell *mult*]
#set_implementation DW02_mult/pparch [find cell *mult*]

set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

compile

report_timing > ./Reports/csa/report_timing_fpmulcsa.txt
report_area > ./Reports/csa/report_area_fpmulcsa.txt
report_power > ./Reports/csa/report_power_fpmulcsa.txt
report_resources > ./Reports/csa/report_resources_fpmulcsa.txt

#report_timing > ./Reports/pparch/report_timing_fpmulpp.txt
#report_area > ./Reports/pparch/report_area_fpmulpp.txt
#report_power > ./Reports/pparch/report_power_fpmulpp.txt
#report_resources > ./Reports/pparch/report_resources_fpmulpp.txt
