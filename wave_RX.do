onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /UART_RX_TB/DUT/clk
add wave -noupdate -divider UARTRX
add wave -noupdate /UART_RX_TB/DUT/RX_out
add wave -noupdate /UART_RX_TB/DUT/received
add wave -noupdate -divider Sincronizador
add wave -noupdate -color {Dark Orchid} /UART_RX_TB/DUT/SYNCH/synch
add wave -noupdate -divider Counter
add wave -noupdate /UART_RX_TB/DUT/RX_COUNTER/reset
add wave -noupdate /UART_RX_TB/DUT/RX_COUNTER/enable
add wave -noupdate /UART_RX_TB/DUT/RX_COUNTER/SyncReset
add wave -noupdate /UART_RX_TB/DUT/RX_COUNTER/Flag
add wave -noupdate -radix unsigned /UART_RX_TB/DUT/RX_COUNTER/Counting
add wave -noupdate -divider Registro
add wave -noupdate /UART_RX_TB/DUT/RX_REGISTER/Data_Input
add wave -noupdate /UART_RX_TB/DUT/RX_REGISTER/enable
add wave -noupdate /UART_RX_TB/DUT/RX_REGISTER/sync_reset
add wave -noupdate /UART_RX_TB/DUT/RX_REGISTER/Data_Output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {242 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 246
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
WaveRestoreZoom {106 ps} {146 ps}
