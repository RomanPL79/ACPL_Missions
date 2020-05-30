params ["_group", "_distance"];
private ["_active", "_enemy"];

if (!isserver) exitwith {};

//_nul = [(group this),500] execVM "acpl_fncs\TLC_reinforce.sqf";
//1.1

if (isNil "acpl_fncs_initied") then {acpl_fncs_initied = false};

waitUntil {acpl_fncs_initied};

_enemy = [(leader _group)] call acpl_check_enemy;

_group setVariable ["zbe_cacheDisabled",true];

_active = true;

_group setvariable ["TCL_Disabled",true];
{[_x,"PATH"] remoteExec ["disableAI",0];} foreach (units _group);

while {_active} do {
	{
		if ([_x,_distance,_enemy,acpl_betterAI_detection] call acpl_check_inrange) then {
			_active = false;
			_group setVariable ["zbe_cacheDisabled",false];
		};
	} foreach (units _group);
	sleep 10;
};

_group setvariable ["TCL_Disabled",false];
{[_x,"PATH"] remoteExec ["EnableAI",0];} foreach (units _group);