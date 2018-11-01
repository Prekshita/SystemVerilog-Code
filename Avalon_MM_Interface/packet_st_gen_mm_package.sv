////////////////////////////////////////////////////////////////////////////////////////////////////
//packet_st_gen_mm_package.sv - Avalon_MM package module. 
//
//Author Prekshita Jain (prekjain@pdx.edu)
//date : 10/29/2018
//
//Description :
//______________________
//this package has structure of all slave register, read function and write function.
//here function return type is void , so function will not return any value, the readdata is passed to the calling module through output port.
//inside function there is unique case statement for each address. if the address doesent match a default value is displayed.

//////////////////////////////////////////////////////////////////////////////////////////////////////

package AvalonP;

typedef struct packed   // set of slave modules. 
{
logic [7:0] ADDR_NUMPKTS;
logic [7:0] ADDR_START;
logic [7:0] ADDR_STOP;
logic [7:0] ADDR_PKTLENGTH;
logic [7:0] ADDR_PAYLOAD;
logic [7:0] ADDR_VERSION;
logic [7:0] ADDR_SCRATCH;
logic [7:0] ADDR_RES;
} register_set;


function void Read(input [7:0] address,output [7:0] readdata, input register_set RWValue);  // read function for the selected address 

	unique case (address)
		8'b00000000:readdata = RWValue.ADDR_NUMPKTS;
		8'b00000001:readdata = RWValue.ADDR_START;
		8'b00000010:readdata = RWValue.ADDR_STOP;
		8'b00000011:readdata = RWValue.ADDR_PKTLENGTH;
		8'b00000100:readdata = RWValue.ADDR_PAYLOAD;
		8'b00000101:readdata = RWValue.ADDR_VERSION;
		8'b00000110:readdata = RWValue.ADDR_SCRATCH; 
		default : $display("read not allowed on this address");
		
	endcase

endfunction

function register_set Write(input [7:0] address, input  [7:0] writedata, input register_set RWValue); // write function for the selected address 
automatic register_set wupdate = RWValue;

	unique case (address)
		8'b00000000:wupdate.ADDR_NUMPKTS  = writedata;
		8'b00000001:wupdate.ADDR_START       = writedata;
		8'b00000010:wupdate.ADDR_STOP       = writedata;
		8'b00000011:wupdate.ADDR_PKTLENGTH   = writedata;
		8'b00000100:wupdate.ADDR_PAYLOAD     = writedata;
		8'b00000110:wupdate.ADDR_SCRATCH     = writedata;
		default : $display("write not allowed on this address"); 
	endcase

	return wupdate;
endfunction 

endpackage