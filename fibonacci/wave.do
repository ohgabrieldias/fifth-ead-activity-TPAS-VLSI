onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_module_top/clock
add wave -noupdate -radix unsigned /tb_module_top/reset
add wave -noupdate -radix unsigned /tb_module_top/select
add wave -noupdate -radix unsigned /tb_module_top/n
add wave -noupdate -radix unsigned /tb_module_top/En_reg1
add wave -noupdate -radix unsigned /tb_module_top/En_reg2
add wave -noupdate -radix unsigned /tb_module_top/En_Count
add wave -noupdate -radix unsigned /tb_module_top/En_N
add wave -noupdate -radix unsigned /tb_module_top/Y_M1
add wave -noupdate -radix unsigned /tb_module_top/Y_M2
add wave -noupdate -radix unsigned /tb_module_top/Y_M3
add wave -noupdate -radix unsigned /tb_module_top/S_S1
add wave -noupdate -radix unsigned /tb_module_top/S_S2
add wave -noupdate -radix unsigned /tb_module_top/fibonacci
add wave -noupdate -radix unsigned /tb_module_top/Stop
add wave -noupdate -divider FIBONACCI-MODULE
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -radix unsigned /tb_module_top/FIBONACCI/reg_count_to_n
add wave -noupdate -radix unsigned /tb_module_top/FIBONACCI/regn
add wave -noupdate -divider FSM
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -radix unsigned /tb_module_top/FSM/Stop
add wave -noupdate -radix unsigned /tb_module_top/FSM/En_reg1
add wave -noupdate -radix unsigned /tb_module_top/FSM/En_reg2
add wave -noupdate -radix unsigned /tb_module_top/FSM/En_Count
add wave -noupdate -radix unsigned /tb_module_top/FSM/En_N
add wave -noupdate -radix unsigned /tb_module_top/FSM/Select
add wave -noupdate -radix unsigned /tb_module_top/FSM/estado_atual
add wave -noupdate -radix unsigned /tb_module_top/FSM/prox_estado
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {307298 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 205
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ps} {171162 ps}
