private ["_wait","_groups","_groups_count","_spawn_fnc"];

//_nul = [] execVM "acpl_fncs\spawn_reinforces.sqf";
//v1.0

_wait = _this select 0;
_groups_count = _this select 1;
_groups = _this select 2;

acpl_groups_used = [];
publicvariable "acpl_groups_used";

sleep ((_wait/2) + random (_wait/2));
for "_i" from 1 to _groups_count do {
	private ["_groups2","_grp","_v1","_v2","_name"];
	_groups2 = _groups - acpl_groups_used;
	_grp = _groups2 select floor(random(count _groups2));
	_v1 = _grp select 0;
	_v2 = _grp select 1;
	_v1 execVM "acpl_fncs\spawn\spawn.sqf";
	sleep 1;
	_name = acpl_spawn_name;
	[_name,_v2] execVM "acpl_fncs\spawn\addwaypoints.sqf";
	acpl_groups_used = acpl_groups_used + [_grp];
	publicvariable "acpl_groups_used";
	sleep 15;
};