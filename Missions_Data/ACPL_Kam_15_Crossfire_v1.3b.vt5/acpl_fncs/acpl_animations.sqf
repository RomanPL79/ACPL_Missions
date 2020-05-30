private ["_script","_variables"];

_script = _this select 0;
_variables = _this select 1;

//v1.0

if (isNil "acpl_animations_activated") then {acpl_animations_activated = false;publicvariable "acpl_animations_activated";};

if (!isserver) exitwith {};

waitUntil {time > 15};
waitUntil {acpl_animations_activated};

if (_script == "ANIM") then {[_variables,acpl_animations_start] remoteExec ["call",2];};