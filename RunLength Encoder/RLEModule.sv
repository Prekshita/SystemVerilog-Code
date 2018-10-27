////////////////////////////////////////////////////////////////////////////////////////////////////
//RunLengthModule.sv - thsi mosule perform RunLengthEncodeing.
//
//Author Prekshita Jain (prekjain@pdx.edu)
//date : 10/13/2018
//
//Description :
//______________________
// This module will take user input , and call datapath module with check for the valid data. it also instansiate control module. it will check for 
// 
// ////////////////////////////////////////////////////////////////////////////////

`include "FSMpackageModule.sv"

import FSMpackage::*;

module runLengthEncoder 
	(
		input logic clock ,
		input logic reset_n,
		input logic [6:0] dataIn ,
		output out_st dataOut);


reg tag;
reg [7:0]count;
logic [7:0]validdataOut;
reg valid;
reg [6:0]temp;
bit NotvalidFlag = 1'b0;
logic reset_temp;


always_ff @(posedge clock, negedge reset_n)
begin
	if(!reset_n)
	reset_temp <= 0;
	else 
	reset_temp <= 1;
		
end
//instance of data path module
data_path dp1(.dataIn(dataIn),.clock(clock),.reset_n(reset_temp),.valid(valid), .count(count), .validdataOut(validdataOut),.temp(temp));

//instance of FSM controler
FSMControl FSM1(.count(count),.dataIn(dataIn),.temp(temp),.clock(clock),.reset_n(reset_temp),.tag(tag),.valid(valid));
always_comb
begin
if (validdataOut < 127 ) // checking if input is less than 127
	dataOut = {tag,validdataOut[6:0],valid};

else if( validdataOut > 127 && validdataOut <= 256 )

	dataOut = {validdataOut,valid};
else if ( validdataOut > 256) // checking if given input is out of range
	begin
	NotvalidFlag = 1;
	$display ("out of range");
	$stop;
	end
else 
	$display("not valid input");
end



endmodule 
