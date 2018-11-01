Avalon MM Interface to communicte between master and slave. 
slave : Here register set for ethernet packet generator

valon MM: Master
1. Master initiates a Read/Write request to Slave over Avalon MM
2. Master initiates a transfer when Waitrequest is low, else wait for it to get low.
3. Master identifies a successful transfer by checking falling edge of waitrequest. (not 0)

Avalon MM: Slave
1. Default: After Reset, Waitrequest is hold low.
2. Once a transfer is initiated, Slave will pull the waitrequest high and waits for 4 clk
cycles to make it low again.

Source clock of 10 KHz

packet_st_gen_mm.sv

This module implements the  slave(set of registers). 
Input: to module: address, read,write, writedata, clock and reset.
Output: readdata Waitrequest signal. 
Here reset is active hight reset.when reset asserted the slave registers will be initilized to default value. writerequest signal is output from slave. This signal will be low when reset is asserted. This will be low until it receives request from master. It  will stay high for the next 4 clock cycle after receiving request from master. During this 4 cycle it will check for the valid address, valid read and valid write . This module will call the reead() write() function accordingly. There is a counter to keep count of 4 waitrequest high signal.

packet_st_gen_mm_tb.sv

This module implemets the Avalon protocol Master. master will continuesly moniter the waitrequest signal . If the waitrequest is low master can initiate the new request. the acknowledgment from the slave is monitered by masrer at at falling edge of the waitrequest signal. clock frequency is 10Khz, each cycle is 0.1msec. 

packet_st_gen_mm_package.sv 

Package has single structure for all slave register, read function and write function. Here function return type is void , so function will not return any value, the readdata is passed to the calling module through output port. inside function there is unique case statement for each address. If the address doesent match a default value is displayed.