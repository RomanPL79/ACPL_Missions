private ["_unit","_position","_enableduckig","_start_dir","_s_num"];

_unit = _this select 0;
_position = _this select 1;
_enableduckig = _this select 2;

//_nul = [this,"up",true] execVM "acpl_fncs\dostop.sqf";
//v1.6

if (!isserver) exitwith {[_unit,_position,_enableduckig] remoteExec ["execVM",2];};

_start_dir = getDir _unit;

_unit setvariable ["acpl_dostop",true,true];
if (_position == "up") then {_unit setvariable ["acpl_dostop_pos",2,true];};
if (_position == "middle") then {_unit setvariable ["acpl_dostop_pos",1,true];};
if (_position == "down") then {_unit setvariable ["acpl_dostop_pos",0,true];};

_s_num = _unit getvariable "acpl_dostop_pos";

_unit setunitpos _position;
_unit setVariable ["VCOM_NOAI",true];
_unit setVariable ["Vcm_Disable",true];
[_unit,"PATH"] remoteExec ["DisableAI",0];
[_unit,"AUTOCOMBAT"] remoteExec ["DisableAI",0];
_unit domove (position _unit);
sleep 1;
_unit setdir _start_dir;
sleep 5;
if (_enableduckig) then {_nul = [_unit] execVM "acpl_fncs\AI\reload_duck.sqf";};
while {(alive _unit)} do {
	if (_unit getvariable "acpl_dostop") then {
		if ((_s_num != (_unit getvariable "acpl_dostop_pos")) OR (unitPos _unit != _position)) then {
			if ((_unit getvariable "acpl_dostop_pos") == 0) then {_unit setunitpos "down";};
			if ((_unit getvariable "acpl_dostop_pos") == 1) then {_unit setunitpos "middle";};
			if ((_unit getvariable "acpl_dostop_pos") == 2) then {_unit setunitpos "up";};
		};
		sleep 5;
	} else {
		[_unit,"PATH"] remoteExec ["EnableAI",0];
		[_unit,"AUTOCOMBAT"] remoteExec ["EnableAI",0];
		_unit setunitpos "AUTO";
		_unit dofollow (leader (group _unit));
		sleep 60;
		_unit setVariable ["VCOM_NOAI",false,true];
		_unit setVariable ["Vcm_Disable",false,true];
		if (true) exitwith {};
	};
};