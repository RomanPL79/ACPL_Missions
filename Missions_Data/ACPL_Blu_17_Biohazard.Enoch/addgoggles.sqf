/*
	This function is adding specified type of goggles for unit, preventing from changing it to these specified in Identity.
	It is a shortcut for remote addition of specific type of goggles.

	a: Roman79
*/

params [
	["_unit", objNull],
	["_goggles", ""],
	["_remote", true]
];

// No unit, no message
if (isNull _unit) exitWith {};

// Unit is not local
if !(local _unit) exitWith
{
	// Allow this code being broadcast
	if _remote then
	{
		[_unit, _goggles, false] remoteExecCall ["psz_fnc_missions_addGoggles", _unit];
	};
};

removeGoggles _unit;
if (_goggles != "") then {_unit addGoggles _goggles};
