###############################################################################
# Created by write_sdc
# Sun Jun  1 17:17:47 2025
###############################################################################
current_design SemiCPU
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 10.0000 [get_ports {clk}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {an[0]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {an[0]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {an[1]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {an[1]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {an[2]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {an[2]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {an[3]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {an[3]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {an[4]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {an[4]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {an[5]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {an[5]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {an[6]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {an[6]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {an[7]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {an[7]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {seg[0]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {seg[0]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {seg[1]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {seg[1]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {seg[2]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {seg[2]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {seg[3]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {seg[3]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {seg[4]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {seg[4]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {seg[5]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {seg[5]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -rise -max -add_delay [get_ports {seg[6]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -fall -max -add_delay [get_ports {seg[6]}]
set_false_path\
    -from [list [get_ports {control}]\
           [get_ports {reset}]]
###############################################################################
# Environment
###############################################################################
###############################################################################
# Design Rules
###############################################################################
