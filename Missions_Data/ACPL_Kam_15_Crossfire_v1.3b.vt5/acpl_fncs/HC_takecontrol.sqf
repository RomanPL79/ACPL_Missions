private ["_unit","_grps","_action"];

_unit = _this select 0;
_grps = _this select 1;

if (!isserver) exitwith {};

//_nul = [_unit,[_grps]] execVM "acpl_fncs\HC_takecontrol.sqf";
//v1.2

if (isNil "acpl_fncs_initied") then {acpl_fncs_initied = false};

waitUntil {acpl_fncs_initied};

if (isNil "acpl_mainloop_done") then {acpl_mainloop_done = false};

waitUntil {acpl_mainloop_done};

acpl_hc_unit = _unit;
acpl_hc_groups = _grps;
publicvariable "acpl_hc_unit";
publicvariable "acpl_hc_groups";

{[_unit,[_x]] remoteExec ["hcSetGroup",0];} foreach _grps;

{
	[[_x],acpl_load_actions_HC] remoteExec ["call",_x];
	[[_x],acpl_add_actions_HC] remoteExec ["call",_x];
} foreach allunits;