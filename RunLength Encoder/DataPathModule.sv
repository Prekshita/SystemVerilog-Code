////////////////////////////////////////////////////////////////////////////////////////////////////
//DataPathModule.sv - datapath module will receive data input from external input.
//
//Author Prekshita Jain (prekjain@pdx.edu)
//date : 10/13/2018
//
//Description :
//______________________
// this module takes the user input and check if the input is valid ASCII character. It compares 2 adjecent character in a string (previous value and present value. 
//If the character is repeated it keep track of nuber of times it has repeated(using counter) and send out the valid output.
// 
////////////////////////////////////////////////////////////////////////////////
module data_path (input logic [6:0] dataIn,input logic clock,input logic reset_n,input reg valid, output logic [7:0]count, output logic [7:0] validdataOut,output reg [6:0]temp);


bit equal = 1'b0;
bit notvalidInput = 1'b0; 
// Checking if the inputed value is valid ASCII value (ASCII value between decial 32 and 127)
always_comb 
begin 
	if (dataIn < 32 || dataIn > 126) 
	begin
		if(dataIn != 0)
		begin
			notvalidInput = 1;
			$display("not valid input DD");
			$stop;
		end
		else 
			$display ("null char");
	end 
end


always_ff @(posedge clock, negedge reset_n)
begin
	if(!reset_n)
	begin
		temp = 7'b0;
		count = 8'b0;
	end
else
begin
	if ((temp == 0) || (temp < 32 || temp >126)) // for the first character we just read the value and will not display any value 
	begin
		temp <= dataIn;
	
	end
	else 
	begin
		if (temp == dataIn)  // if the previous and present value are sane increnmet the counter 
		begin
			if(count> 256)
			begin
				$display (" number of repeated character have exceeded limit");
			end
			count <= count +1;
			equal <= 1;
			
		end
		else  // if previous and present values are not same update the new value to temp reg and reset the counter to 0
		begin
	
			temp <= dataIn;
			equal <= 0;		
			count <= 0; 
		  	
		end 
	 
		
	end 
end	
end 
always_comb 
begin

validdataOut = ((count > 0) && (valid == 1))? count: temp;  // chek if the computed value is count or charater and send out corresponding value.

end

endmodule
