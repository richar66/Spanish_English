#************************************************************
# THIS IS A WIZARD-GENERATED FILE.                           
#
# Version 14.0.0 Build 200 06/17/2014 SJ Web Edition
#
#************************************************************

# Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, the Altera Quartus II License Agreement,
# the Altera MegaCore Function License Agreement, or other 
# applicable license agreement, including, without limitation, 
# that your use is for the sole purpose of programming logic 
# devices manufactured by Altera and sold by Altera or its 
# authorized distributors.  Please refer to the applicable 
# agreement for further details.



# Clock constraints

create_clock -name "clk" -period 10.000ns [get_ports {clk}]


# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

# tsu/th constraints

set_input_delay -clock "clk" -max 9ns [get_ports {submit answer[0] answer[1] answer[2] answer[3] answer[4] answer[5] answer[6] answer[7] answer[8] answer[9] answer[10]}]
set_input_delay -clock "clk" -min 2ns [get_ports {submit answer[0] answer[1] answer[2] answer[3] answer[4] answer[5] answer[6] answer[7] answer[8] answer[9] answer[10]}] 


# tco constraints

# tpd constraints

