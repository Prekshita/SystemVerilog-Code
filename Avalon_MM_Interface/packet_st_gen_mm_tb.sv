////////////////////////////////////////////////////////////////////////////////////////////////////
//packet_st_gen_mm_tb.sv - Avalon_MM Mastermodule(test module) 
//
//Author Prekshita Jain (prekjain@pdx.edu)
//date : 10/29/2018
//
//Description :
//______________________
//This module implemets the Avalon protocol Master. master will continuesly moniter the waitrequest signal .
//which is sent from slave. if the waitrequest is low //master can initiate the request. the acknowledgment from the slave
//is monitered by masrer at at falling edge of the waitrequest signal.clock frequency is 10Khz, each cycle is 10msec. 
//////////////////////////////////////////////////////////////////////////////////////////////////////

module tb();

timeunit 100us;
timeprecision 1us;
	
logic clk ;
logic reset ;// Reset signal
logic [7:0] address ;// Register Address
logic  write ;// Register Write Strobe
logic read ; // Register Read Strobe
logic waitrequest ; // Wait request
logic [7:0] writedata ; /// Register Write Data
logic [7:0] readdata ; // Register Read Data
reg countvalue = 4'b0;
int rand_addr, rand_read,rand_write,rand_wdata;
reg wreq_temp = 1'b1;
logic ack;

packet_st_gen_mm dut1(.clk(clk), .reset(reset),.address(address),.write(write), .read(read), .waitrequest(waitrequest), .writedata(writedata), .readdata(readdata));

//Clock Generator for 10Khz
always clk = #0.5 ~clk;

// task to send the new request to the slave module
task  newrequest(input [7:0] addr, input logic r, input logic w,input logic [7:0] wd); 

address = addr; write = w ; read = r ; writedata = wd;

endtask

initial 
begin
	
	reset = 1;
	#20
	reset = 0;
	$monitor($time ,"readdata = %d  ,read = %d,write = %d , address =%d, writedata = %d, count new  =%d, ack =%d", readdata,read,write,address,writedata,countvalue, ack);
	
	// wait for falling edge of waitrequest to send next data
	wait(!waitrequest) 
	@(posedge clk);newrequest(1,0,1,181);
	#10;
	
	wait(!waitrequest)
	@(posedge clk);newrequest(2,0,1,181);
	#10;
	
	wait(!waitrequest )
	@(posedge clk);newrequest(3,1,1,200);
	#10;

	wait(!waitrequest )
	@(posedge clk);newrequest(4,1,1,210);
	#10;

	wait(!waitrequest )
	@(posedge clk);newrequest(5,1,1,181);
	#10;

	wait(!waitrequest )
	@(posedge clk);newrequest(6,1,1,181);
	#10;

	wait(!waitrequest)
	@(posedge clk);newrequest(7,1,1,181);
	#10;
	
	wait(!waitrequest)
	@(posedge clk);newrequest(8,1,1,181);
	#10;
	
	wait(!waitrequest )
	@(posedge clk);newrequest(2,0,0,200);
	#10;

	wait(!waitrequest )
	@(posedge clk);newrequest(1,0,1,210);
	#10;

	wait(!waitrequest )
	@(posedge clk);newrequest(1,1,1,181);
	#10;

	wait(!waitrequest )
	@(posedge clk);newrequest(2,0,1,181);
	#10;

	wait(!waitrequest)
	@(posedge clk);newrequest(2,1,1,181);
	#10;
	
	wait(!waitrequest)
	@(posedge clk);newrequest(5,0,1,181);
	#10;
	
	wait(!waitrequest )
	@(posedge clk);newrequest(7,1,1,200);
	#10;

	wait(!waitrequest)
	@(posedge clk);newrequest(2,1,1,181);
	#10;
	
	wait(!waitrequest)
	@(posedge clk);newrequest(1,1,1,181);
	#10;
	
	wait(!waitrequest )
	@(posedge clk);newrequest(2,1,1,200);
	#10;

	wait(!waitrequest )
	@(posedge clk);newrequest(2,1,0,210);
	#10;

	wait(!waitrequest )
	@(posedge clk);newrequest(2,1,1,181);
	#10;

	wait(!waitrequest )
	@(posedge clk);newrequest(3,1,0,181);
	#10;
reset = 1;
#20
reset = 0;	
	wait(!waitrequest)
	@(posedge clk);newrequest(1,0,1,181);
	#10;
	
	wait(!waitrequest)
	@(posedge clk);newrequest(2,0,1,181);
	#10;
	
	wait(!waitrequest )
	@(posedge clk);newrequest(3,1,1,200);
	#10;

	wait(!waitrequest )
	@(posedge clk);newrequest(4,1,1,210);
	#10;

	wait(!waitrequest )
	@(posedge clk);newrequest(5,1,1,181);
	#10;

	wait(!waitrequest )
	@(posedge clk);newrequest(6,1,1,181);
	#10;

	wait(!waitrequest)
	@(posedge clk);newrequest(7,1,1,181);
	#10;
	
	wait(!waitrequest)
	@(posedge clk);newrequest(8,1,1,181);
	#10;
	
	wait(!waitrequest )
	@(posedge clk);newrequest(2,0,0,200);
	#10;
	

 #20 $stop;
 $finish;
	
end 

always_ff @(posedge clk)
begin 
	 wreq_temp <= waitrequest;
end

always@*
if ( wreq_temp && !waitrequest)
	ack =1;

endmodule
