////////////////////////////////////////////////////////////////////////////////////////////////////
//packet_st_gen_mm.sv - Avalon_MM slave module. 
//
//Author Prekshita Jain (prekjain@pdx.edu)
//date : 10/29/2018
//
//Description :
//______________________
// This module implements the avalon slave(set of registers). This module  will receive request from master (address, read,write, writedata) and retuns "readdata" //and waitrequest signal clock and reset are input to slave modulr from master. here reset is active hight reset.when reset asserted the slave registers will be //initilized to default value. writerequest signal is output from slave. This signal will be low when reset is asserted will be low until it receives request from //master. it  will stay high for the next 4 clock cycle after receiving request from master. during this 4 cycle it will check for the valid address, valid //read, and valid write operation. This module will call the reead() write() function accordingly.
// there is a counter to keep count of 4 waitrequest high signal.
////////////////////////////////////////////////////////////////////////////////


`include "packet_st_gen_mm_package.sv"

import AvalonP::*;

module packet_st_gen_mm  // Slave module 
(
	input clk// Interface clock
	,input reset // Reset signal
	,input [7:0] address // Register Address
	,input write// Register Write Strobe
	,input read // Register Read Strobe
	,output logic waitrequest // Wait request
	,input [7:0] writedata /// Register Write Data
	,output logic [7:0] readdata // Register Read Data
);
	
reg [1:0]count;  // to keep count for waitrequest signal.
reg resetAssert = 1'b0; //flag for reset check


always_ff @(posedge clk or posedge reset) //to keep track of waitrequest signal and reset.
begin
	if(reset)
	begin
		
		waitrequest <= 0;
		count <= 0;
		resetAssert <= 1;
		

	end
	else
	begin
		resetAssert <= 0;
		if(waitrequest == 0)
		begin
			waitrequest <= 1;
		end 
		if( count == 3)  //check if 4 clock cycle and then make waitrequest signal high.
		begin
		
			waitrequest <= 0;
			count <= 0;
		end
		if (waitrequest == 1 ) //if wait signal is high count till 4 
		begin 
			count <= count+1; 
		end 
	end
end

always_comb
begin
	 register_set RWValue;
	if(resetAssert == 0 && ((read == 1 && write == 1) || (read == 1 && write != 1))) // check for read operation and reset is not asserted
	begin
		Read(address,readdata,RWValue);
	end
	else if (resetAssert == 0 && (read == 0 && write == 1)) //check for write operation and reset is not asserted.
	begin
		RWValue = Write(address, writedata,RWValue );

	end
	else if ((resetAssert == 0) && (read == 0 && write == 0)) // check when reset is not asserted and read ==0 and write ==0 condition 
	begin
		$display("No operation specified");
	end 
	else 
	begin    						//initilize the slave registers when reset is asseted.
		
		RWValue = '{8'b0,8'b0,8'b0,8'b0,8'b0,'h12,8'b0,8'b0};

	end 
end





endmodule
