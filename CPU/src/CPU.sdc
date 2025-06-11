# Clock tanımı
create_clock -name clk -period 10.0 [get_ports clk]

# Reset ve control girişlerini false path olarak işaretle
set_false_path -from [get_ports reset]
set_false_path -from [get_ports control]

# Output portlara yükleme zamanı (output delay) tanımla
set_output_delay -max 2.0 -clock clk [get_ports {seg[*] an[*]}]
