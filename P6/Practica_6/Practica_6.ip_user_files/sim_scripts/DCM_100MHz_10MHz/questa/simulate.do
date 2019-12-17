onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib DCM_100MHz_10MHz_opt

do {wave.do}

view wave
view structure
view signals

do {DCM_100MHz_10MHz.udo}

run -all

quit -force
