#!/bin/bash

source /software/scripts/init_synopsys_64.18

vcd2saif -input ../vcd/myfir_syn.vcd -output ../saif/myfir_syn.saif

dc_shell-xg-t -f Power_consumption_estim.tcl


