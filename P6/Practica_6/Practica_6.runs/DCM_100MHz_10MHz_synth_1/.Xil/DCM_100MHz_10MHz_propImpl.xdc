set_property SRC_FILE_INFO {cfile:c:/hlocal/TOC/PR6/MIPSMulticiclo_R3yModoDepuracion/MIPSMulticiclo_R3yModoDepuracion.srcs/sources_1/ip/DCM_100MHz_10MHz/DCM_100MHz_10MHz.xdc rfile:../../../MIPSMulticiclo_R3yModoDepuracion.srcs/sources_1/ip/DCM_100MHz_10MHz/DCM_100MHz_10MHz.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
current_instance inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1