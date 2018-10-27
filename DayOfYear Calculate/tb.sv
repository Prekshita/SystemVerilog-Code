////////////////////////////////////////////////////////////////////////////////////////
//tb.sv - to test the day of the year.
//
// Author : Prekshita Jain(prekjain@pdx.edu)
// Date   : 10/5/2018
//
//Description:
//-------------
//This module will instantiate dayOfYrCalc module and test for different testcases(leap year, not a leap year, month befor and after leap year, leap year month, 1 month of the year, number of months).
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



module tb();
parameter CALENDER=0;
bit [5:0]dayOfMonthtb;
bit [3:0]monthtb;
bit [10:0]yeartb;
bit [8:0]dayOfYeartb; 

dayOfYrCalc #(CALENDER) ts1(.dayOfMonth(dayOfMonthtb),.month(monthtb), .year(yeartb),.dayOfYear(dayOfYeartb));


initial
$monitor("Month = %d, Year = %d, dayofmonth = %d, dayofyear = %d",monthtb,yeartb,dayOfMonthtb,dayOfYeartb);

initial
begin
	#0;monthtb ='d1;  yeartb = 'd1993; dayOfMonthtb = 'd28; 
	#10
	#0;monthtb ='d2;  yeartb = 'd980; dayOfMonthtb = 'd20;
	#10
	#0;monthtb ='d12; yeartb = 'd1999; dayOfMonthtb = 'd33;
	#10
	#0;monthtb ='d11; yeartb = 'd1760; dayOfMonthtb = 'd27;
	#10
	#0;monthtb ='d06; yeartb = 'd2016; dayOfMonthtb = 'd01;
	#10
	#0;monthtb ='d6; yeartb = 'd1970; dayOfMonthtb = 'd11;
	#10
 	#0;monthtb ='d4; yeartb = 'd1716; dayOfMonthtb = 'd08;
	#10
	#0; monthtb ='d2; yeartb = 'd1924; dayOfMonthtb = 'd29;
	#10
	#0; monthtb ='d6; yeartb = 'd1970; dayOfMonthtb = 'd11;
	#10
	#0  monthtb ='d14; yeartb = 'd1980; dayOfMonthtb = 'd08;
	#10
	#0; monthtb ='d1; yeartb = 'd1700; dayOfMonthtb = 'd11;
	#10
	#0; monthtb ='d2; yeartb = 'd1971; dayOfMonthtb = 'd28;
	#20
	#0; monthtb ='d3; yeartb = 'd1960; dayOfMonthtb = 'd28;
	#20
	#0; monthtb ='d6; yeartb = 'd2016; dayOfMonthtb = 'd02;
	#10 
	#0; monthtb ='d6; yeartb = 'd2000; dayOfMonthtb = 'd0;
	#20
	#0; monthtb ='d7; yeartb = 'd1800; dayOfMonthtb = 'd0;
	#10
	#0; monthtb ='d8; yeartb = 'd2016; dayOfMonthtb = 'd0;
	#10


$display ("test done");
$finish;
end


endmodule 
