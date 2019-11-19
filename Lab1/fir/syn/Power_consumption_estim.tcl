read_verilog -netlist ../netlist/myfir.v
read_saif -input ../saif/myfir_syn.saif -instance tb_fir/UUT -unit ns -scale 1
create_clock -name MY_CLK clk

report_power > ./Reports/fir_struct_saif.txt