 /////////////////////////////////////////////////////////////////////////////////////////////////
// dayOfYrCalc.sv - to check the day of the year for symmetry and gregorian calender 
//
// Author: Prekshita Jain(prekjain@pdx.edu)
// Date  : 10/4/2018
//
//Description:
//-------------
//
// This module will take user input for type of calender(0 = gregorian, 1= symmetry) and valid calender date(dayOfMonth, month and year). It will check for leap year conditon and calculate the number of days accordingly.This module will out put day of the year(dayOfYear).
// Leap year check is not perfornmed for Symmetry calender, as the additional days added will be added to the last month. 
///////////////////////////////////////////////////////////////////////////////////////////////////



`include "CalenderInfo.pkg"
module dayOfYrCalc 
	(
		input logic [5:0]dayOfMonth,//Range is 1..31
		input logic [3:0]month,//Range is 1..12
		input logic [10:0]year,//Range is 0..2047
		output logic [8:0]dayOfYear //Range is 1..Max Possible days
	);
parameter CALENDAR = 0;
import CalenderInfo::*;
localparam DIV_4 = 4;
localparam DIV_100 = 100;
localparam DIV_400 = 400;


always_comb
begin
	if (CALENDAR == 0) // gregorian calender 
		begin
			case (month)  // month check

			'd1 : dayOfYear = dayOfMonth;
			'd2 : dayOfYear = JANg + dayOfMonth;
			'd3 : dayOfYear = FEBg + dayOfMonth;
			'd4 : dayOfYear = MARg + dayOfMonth;
			'd5 : dayOfYear = APLg + dayOfMonth;
			'd6 : dayOfYear = MAYg + dayOfMonth;
			'd7 : dayOfYear = JUNg + dayOfMonth;
			'd8 : dayOfYear = JLYg + dayOfMonth;
			'd9 : dayOfYear = AUGg + dayOfMonth;
			'd10: dayOfYear = SEPg + dayOfMonth;
			'd11: dayOfYear = OCTg + dayOfMonth;
			'd12: dayOfYear = NOVg + dayOfMonth;

			default :
				begin
					$display ("%d is not a valid input for  month",month);
					dayOfYear = 'd0;
				end
			endcase
			// Check for leap year and if its a leap and month greater thn feb add 1.
			if(((year % DIV_4 == 0) && (year % DIV_100 != 0))|| (year % DIV_400 == 0))
			  dayOfYear = (month > 2)?(dayOfYear + 1):dayOfYear;

		end 
	else if (CALENDAR ==1) //symmetry calender
		begin
			case (month) // month check

			'd1 : dayOfYear = dayOfMonth;
			'd2 : dayOfYear = JANs + dayOfMonth;
			'd3 : dayOfYear = FEBs + dayOfMonth;
			'd4 : dayOfYear = MARs + dayOfMonth;
			'd5 : dayOfYear = APLs + dayOfMonth;
			'd6 : dayOfYear = MAYs + dayOfMonth;
			'd7 : dayOfYear = JUNs + dayOfMonth;
			'd8 : dayOfYear = JLYs + dayOfMonth;
			'd9 : dayOfYear = AUGs + dayOfMonth;
			'd10: dayOfYear = SEPs + dayOfMonth;
			'd11: dayOfYear = OCTs + dayOfMonth;
			'd12: dayOfYear = NOVs + dayOfMonth;

			default : 
			begin
				$display ("%d is not a valid month",month);
				dayOfYear = 'd0;
			end

			endcase
			

		end 
	else $display (" %d not a valid input for CALENDAR",CALENDAR);
			
end

endmodule 





