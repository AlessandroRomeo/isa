###################################################################

# Created by write_sdc on Tue Oct 22 17:48:48 2019

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_load -pin_load 3.40189 [get_ports {dout[13]}]
set_load -pin_load 3.40189 [get_ports {dout[12]}]
set_load -pin_load 3.40189 [get_ports {dout[11]}]
set_load -pin_load 3.40189 [get_ports {dout[10]}]
set_load -pin_load 3.40189 [get_ports {dout[9]}]
set_load -pin_load 3.40189 [get_ports {dout[8]}]
set_load -pin_load 3.40189 [get_ports {dout[7]}]
set_load -pin_load 3.40189 [get_ports {dout[6]}]
set_load -pin_load 3.40189 [get_ports {dout[5]}]
set_load -pin_load 3.40189 [get_ports {dout[4]}]
set_load -pin_load 3.40189 [get_ports {dout[3]}]
set_load -pin_load 3.40189 [get_ports {dout[2]}]
set_load -pin_load 3.40189 [get_ports {dout[1]}]
set_load -pin_load 3.40189 [get_ports {dout[0]}]
set_load -pin_load 3.40189 [get_ports vout]
create_clock [get_ports clk]  -name MY_CLK  -period 18  -waveform {0 9}
set_clock_uncertainty 0.07  [get_clocks MY_CLK]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports rst_n]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {din[13]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {din[12]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {din[11]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {din[10]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {din[9]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {din[8]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {din[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {din[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {din[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {din[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {din[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {din[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {din[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {din[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports vin]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b0[13]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b0[12]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b0[11]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b0[10]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b0[9]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b0[8]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b0[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b0[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b0[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b0[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b0[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b0[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b0[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b0[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b1[13]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b1[12]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b1[11]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b1[10]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b1[9]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b1[8]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b1[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b1[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b1[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b1[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b1[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b1[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b1[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b1[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b2[13]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b2[12]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b2[11]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b2[10]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b2[9]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b2[8]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b2[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b2[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b2[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b2[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b2[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b2[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b2[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b2[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b3[13]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b3[12]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b3[11]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b3[10]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b3[9]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b3[8]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b3[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b3[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b3[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b3[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b3[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b3[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b3[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b3[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b4[13]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b4[12]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b4[11]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b4[10]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b4[9]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b4[8]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b4[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b4[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b4[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b4[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b4[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b4[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b4[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b4[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b5[13]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b5[12]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b5[11]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b5[10]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b5[9]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b5[8]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b5[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b5[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b5[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b5[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b5[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b5[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b5[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b5[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b6[13]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b6[12]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b6[11]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b6[10]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b6[9]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b6[8]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b6[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b6[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b6[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b6[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b6[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b6[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b6[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b6[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b7[13]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b7[12]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b7[11]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b7[10]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b7[9]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b7[8]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b7[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b7[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b7[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b7[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b7[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b7[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b7[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b7[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b8[13]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b8[12]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b8[11]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b8[10]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b8[9]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b8[8]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b8[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b8[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b8[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b8[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b8[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b8[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b8[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b8[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b9[13]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b9[12]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b9[11]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b9[10]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b9[9]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b9[8]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b9[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b9[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b9[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b9[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b9[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b9[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b9[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b9[0]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b10[13]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b10[12]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b10[11]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b10[10]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b10[9]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b10[8]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b10[7]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b10[6]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b10[5]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b10[4]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b10[3]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b10[2]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b10[1]}]
set_input_delay -clock MY_CLK  -max 0.5  [get_ports {b10[0]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {dout[13]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {dout[12]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {dout[11]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {dout[10]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {dout[9]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {dout[8]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {dout[7]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {dout[6]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {dout[5]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {dout[4]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {dout[3]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {dout[2]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {dout[1]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports {dout[0]}]
set_output_delay -clock MY_CLK  -max 0.5  [get_ports vout]
