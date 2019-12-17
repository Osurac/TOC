onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+DCM_100MHz_10MHz -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.DCM_100MHz_10MHz xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {DCM_100MHz_10MHz.udo}

run -all

endsim

quit -force
