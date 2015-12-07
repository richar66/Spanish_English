## Generated SDC file "FinalProject.out.sdc"

## Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, the Altera Quartus II License Agreement,
## the Altera MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Altera and sold by Altera or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 14.0.0 Build 200 06/17/2014 SJ Web Edition"

## DATE    "Mon Dec 07 16:44:10 2015"

##
## DEVICE  "EP4CE115F29C7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {clk} -period 10.000 -waveform { 0.000 5.000 } [get_ports {clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {clk}]  9.000 [get_ports {answer[0]}]
set_input_delay -add_delay  -clock [get_clocks {altera_reserved_tck}]  9.000 [get_ports {answer[0]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  9.000 [get_ports {answer[1]}]
set_input_delay -add_delay  -clock [get_clocks {altera_reserved_tck}]  9.000 [get_ports {answer[1]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  9.000 [get_ports {answer[2]}]
set_input_delay -add_delay  -clock [get_clocks {altera_reserved_tck}]  9.000 [get_ports {answer[2]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  9.000 [get_ports {answer[3]}]
set_input_delay -add_delay  -clock [get_clocks {altera_reserved_tck}]  9.000 [get_ports {answer[3]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  9.000 [get_ports {answer[4]}]
set_input_delay -add_delay  -clock [get_clocks {altera_reserved_tck}]  9.000 [get_ports {answer[4]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  9.000 [get_ports {answer[5]}]
set_input_delay -add_delay  -clock [get_clocks {altera_reserved_tck}]  9.000 [get_ports {answer[5]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  9.000 [get_ports {answer[6]}]
set_input_delay -add_delay  -clock [get_clocks {altera_reserved_tck}]  9.000 [get_ports {answer[6]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  9.000 [get_ports {answer[7]}]
set_input_delay -add_delay  -clock [get_clocks {altera_reserved_tck}]  9.000 [get_ports {answer[7]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  9.000 [get_ports {answer[8]}]
set_input_delay -add_delay  -clock [get_clocks {altera_reserved_tck}]  9.000 [get_ports {answer[8]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  9.000 [get_ports {answer[9]}]
set_input_delay -add_delay  -clock [get_clocks {altera_reserved_tck}]  9.000 [get_ports {answer[9]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  9.000 [get_ports {answer[10]}]
set_input_delay -add_delay  -clock [get_clocks {altera_reserved_tck}]  9.000 [get_ports {answer[10]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  9.000 [get_ports {rst}]
set_input_delay -add_delay  -clock [get_clocks {altera_reserved_tck}]  9.000 [get_ports {submit}]


#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

