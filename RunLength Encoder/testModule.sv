////////////////////////////////////////////////////////////////////////////////////////////////////////
//testModule.sv - this module will test the RunLengthModul by sending set of stimulus
//
//Author Prekshita Jain (prekjain@pdx.edu)
//date : 10/13/2018
//
//Description :
//______________________
//This module will test the RunLengthModule by sendding set of stimulus and display output value
//
//
//
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////
`include "FSMpackageModule.sv"
import FSMpackage::*;
module testModule();

typedef enum {READ2,IDEL}state_t;
logic clock;
logic reset_n;
logic [6:0] dataIn;

state_t FSMState;
out_st dataOut;
bit notValidRange = 1'b0;
bit notvalidInput = 1'b0;
reg countvalue;
reg countflag= 3;



always 
begin 
#3.2ns clock = 1;
#3.2ns clock = 0;
end 

runLengthEncoder rlm1(.clock(clock),.reset_n(reset_n),.dataIn(dataIn),.dataOut(dataOut));

//FSM state 0 : READ1, 1 : IDLE
assign FSMState = state_t'(rlm1.FSM1.pstate) ; // get the FSM state using hirarchical value. 




initial
begin
$display (" FSM states IDLE : 1, READ1 : 0"); 
$monitor ($time," dataIn = %c, character = %c value = %d, tag = %d,valid = %d, FSMState = %s", dataIn, dataOut.data[6:0],dataOut.data[6:0], dataOut.data[7],dataOut.valid,FSMState.name);
end

initial 
begin 
reset_n = 0;
#10 
reset_n = 1;

	@(posedge clock); dataIn = "b";
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "c";
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "a";

	@(posedge clock); dataIn = "b";
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "c";
	@(posedge clock); dataIn = "b";
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "b";

reset_n = 0;
#10ns 
reset_n = 1;
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "a";
	@(posedge clock); dataIn = "c";

reset_n = 0;
#10
reset_n = 1;

	
	for (int i= 0;i< 256; i++)
begin
		@(posedge clock); dataIn = "c";

end
	@(posedge clock); dataIn = 0;

$monitor ($time," dataIn = %c, dataOut.data= %d ,valid = %d, displayFSMState = %s", dataIn, dataOut.data,dataOut.valid,FSMState.name);



#15 $stop;
$finish;
end 
 

endmodule 


