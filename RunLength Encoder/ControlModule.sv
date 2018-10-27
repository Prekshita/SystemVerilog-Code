////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//ControlModule.sv - this module will implement the FSM for runlengthencoder
//
//Author Prekshita Jain (prekjain@pdx.edu)
//date : 10/13/2018
//
//Description :
//______________________
//This module will implement FSM for runlengthmodule. when there is a reset, we stay in IDEL state, and when we come of IDEL state will be in READ@ stae untill reset is asserted.
// in this module we are setting the value for tag and reset signal based on the count, present and previous state. these values are sent to runLengthModule.
//here we are using mealy machin. as output depends on present state and input.
//
// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





`include "FSMpackageModule.sv"

import FSMpackage::*;
module FSMControl (input reg [7:0]count, input logic clock,input reg [6:0] temp,input logic [6:0] dataIn, input logic reset_n, output reg tag, output reg valid);


state pstate, nextstate;

always_ff@(posedge clock, negedge reset_n)
begin
	if(!reset_n) //if reset is asseted then goto IDEL state or stay in READ1 state
	pstate <= IDLE; 
	else 
	pstate <= nextstate;
end

always_comb
begin
case(pstate)
	IDLE : 
		begin
				nextstate = READ1;
		end
	READ1 : 
		begin 
				
				nextstate = READ1;
				
		end 
endcase			
end

always_comb
begin
if (pstate == READ1)  // value for tag and valid is determined in read state
begin

	if(((temp != dataIn && count>0) || (count == 0)) && (!( (temp == 0) || (temp < 32 || temp > 127)))) // setting value for valid bit based on count, present and previous value
	begin
		valid = 1;
	end 
	else
	begin
		valid = 0;

end
if ((temp == dataIn) && count == 0) // setting value for tag bit based on previous present value and count value
begin 
	tag = 1;
end 
else 
begin
	tag = 0;
end




end
else if (pstate == IDLE) // tag and value bit is reset
begin
	tag = 1'b0;
	valid = 1'b0;

end
end
endmodule
