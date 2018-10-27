DAY OF THE YEAR CALCULATOR 
SystemVerilog model that returns the day of
the year for a specified date (mm/dd/yyyy) for a Gregorian and Symmerty454 calendars.Example, in a
Gregorian calendar 01-Feb would be the 32nd day of the year, but it is 29th day in Symmerty454
calendar. Leap years should also be taken into consideration. The design is parameterized to have both Gregorian and Symmerty454 calendars, yet only one
calendar system will be active in run-time.parameter “CALENDAR”  is used to select the type of calender. 0 for Gregorian and 1 for Symmerty454
