params ["_wait","_groups_count","_groups",["_hal", objNull]];
private ["_acpl_groups_used"];

//_nul = [wait,howmany,groups,HAL_leader] execVM "acpl_fncs\spawn_reinforces.sqf";
//v1.2

_acpl_groups_used = [];

sleep ((_wait/2) + random (_wait/2));
for "_i" from 1 to _groups_count do {
	private ["_groups2","_grp","_v1","_v2","_name"];
	
	_groups2 = _groups - _acpl_groups_used;
	_grp = _groups2 select floor(random(count _groups2));
	_v1 = _grp select 0;
	_v2 = _grp select 1;
	_name = [_v1 select 0,_v1 select 1,_v1 select 2] call acpl_spawn_newgroup;
	sleep 1;
	[_name,_v2] call acpl_spawn_addwaypoints;
	_acpl_groups_used = _acpl_groups_used + [_grp];
	
	if (_hal != objNull) then {
		[_hal,[(leader _name)]] remoteExec ["synchronizeObjectsAdd",0];
	};
	
	sleep 15;
};