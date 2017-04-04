onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Contador
add wave -noupdate /UART_TB/DUT/clk
add wave -noupdate /UART_TB/DUT/rst
add wave -noupdate /UART_TB/DUT/Rx_in
add wave -noupdate /UART_TB/DUT/Tx_in
add wave -noupdate /UART_TB/DUT/send
add wave -noupdate /UART_TB/DUT/Rx_out
add wave -noupdate /UART_TB/DUT/Tx_out
add wave -noupdate /UART_TB/DUT/new_Rx
add wave -noupdate /UART_TB/DUT/Tx_ready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 191
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {21 ps} {105 ps}
