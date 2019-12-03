vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker.vhd
vcom -93 -work ./work ../tb/data_sink.vhd
vcom -93 -work ./work ../src/reg.vhd
vcom -93 -work ./work ../src/reg_1.vhd
vcom -93 -work ./work ../src/reg_7.vhd
vcom -93 -work ./work ../src/reg_27.vhd
vcom -93 -work ./work ../src/fpnormalize_fpnormalize.vhd
vcom -93 -work ./work ../src/fpround_fpround.vhd
vcom -93 -work ./work ../src/packfp_packfp.vhd
vcom -93 -work ./work ../src/unpackfp_unpackfp.vhd
vcom -93 -work ./work ../src/fpmul_stage1_struct.vhd
vcom -93 -work ./work ../src/fpmul_stage2_struct.vhd
vcom -93 -work ./work ../src/fpmul_stage3_struct.vhd
vcom -93 -work ./work ../src/fpmul_stage4_struct.vhd
vcom -93 -work ./work ../src/fpmul_pipeline.vhd

vlog -work ./work ../tb/tb_fp_mult.v

vsim -t ns -novopt work.tb_fp_mult

add wave *

run 3 us
