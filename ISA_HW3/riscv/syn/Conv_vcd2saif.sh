#!/bin/bash

source /software/scripts/init_synopsys_64.18

vcd2saif -input ../vcd/main_syn.vcd -output ../saif/main.saif

dc_shell-xg-t -f Power_consumption_estim.tcl
