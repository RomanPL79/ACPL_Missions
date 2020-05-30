params ["_object", "_slaves"];
private ["_damage", "_do"];

if (!isserver) exitwith {};

if (isNil "acpl_fncs_initied") then {acpl_fncs_initied = false};

waitUntil {acpl_fncs_initied};

//_nul = [this,[o1,o2]] execVM "acpl_fncs\synchdestroy.sqf";

_do = true;

while {_do} do {
	_damage = damage _object;
	{_x setdamage _damage;} foreach _slaves;
	if (_damage == 1) then {
		{deletevehicle _x;} foreach _slaves;
		_do = false;
	};
	sleep 1;
};