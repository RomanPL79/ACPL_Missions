private ["_enemy", "_unit"];

_unit = _this select 0;

//_nul = [this] execVM "acpl_fncs\sit.sqf";
//v1.1

if (!isserver) exitwith {};

{[_unit,_x] remoteExec ["DisableAI",0];} foreach ["MOVE", "PATH", "AUTOCOMBAT", "TARGET", "AUTOTARGET"];
(group _unit) setVariable ["zbe_cacheDisabled",true];

_enemy = [_unit] call acpl_check_enemy;

if (isNil "acpl_fncs_initied") then {acpl_fncs_initied = false};

waitUntil {acpl_fncs_initied};

sleep 1;
_unit action ["sitDown", _unit];
_unit setvariable ["acpl_sitting",true,false];
_unit setBehaviour "SAFE";
while {(alive _unit) AND (_unit getvariable "acpl_sitting")} do {
	if (([_unit,_enemy,acpl_betterAI_detection] call acpl_check_knowsaboutenemy) OR ([_unit,acpl_betterAI_detection] call acpl_check_seebody)) then {
		_unit setvariable ["acpl_sitting",false,false];
	};
	sleep 1;
};
{[_unit,_x] remoteExec ["EnableAI",0];} foreach ["MOVE", "PATH", "AUTOCOMBAT", "TARGET", "AUTOTARGET"];
_unit setBehaviour "AWARE";