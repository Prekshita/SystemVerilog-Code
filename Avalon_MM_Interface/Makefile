all: 	compile run

compile:
	vlib work
	vlog ./packet_st_gen_mm_package.sv  ./packet_st_gen_mm_dut.sv ./packet_st_gen_mm_tb.sv
run: 
	vsim -c tb  -do "run -all;quit"

clean: 
	rm -rf work transcript vsim.wlf 
