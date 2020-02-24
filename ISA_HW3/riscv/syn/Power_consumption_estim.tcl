read_verilog -netlist ../netlist/main.v
read_saif -input ../saif/main.saif -instance tb_main/UUT -unit ns -scale 1
create_clock -name MY_CLK clk

report_power > ./Reports/main.txt
