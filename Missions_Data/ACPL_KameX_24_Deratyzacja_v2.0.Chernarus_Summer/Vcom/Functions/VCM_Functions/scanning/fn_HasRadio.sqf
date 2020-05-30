/*
	Author: Freddo

	Description:
		Returns an array containing all of units friendlies.

	Parameter(s):
		OBJECT - Object to check if it has a radio assigned to it.

	Returns:
		BOOLEAN
	
	Note:
		Need to add TFAR and ACRE vehicle rack compatibility
*/

private _rtrn = ("ItemRadio" in (assignedItems _this));

_rtrn