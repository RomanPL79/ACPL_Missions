params ["_group", ["_distance", 300], ["_check_buildings", true], ["_numbers", [1,2,4]]];

private ["_center", "_men", "_side", "_men_left", "_units"];

//_nul = [(group this), 300, true, [1, 2, 4]] execVM "acpl_fncs\dopatrol.sqf";
//v1.2

if (!isserver) exitwith {};

if (isNil "acpl_fncs_initied") then {acpl_fncs_initied = false};

waitUntil {acpl_fncs_initied};

if (isNil "acpl_mainloop_done") then {acpl_mainloop_done = false};

waitUntil {acpl_mainloop_done};

{
	_x setVariable ["VCOM_NOAI",true];
	_x setVariable ["Vcm_Disable",true];
} foreach units _group;
_group setvariable ["TCL_Disabled",true];
_group deleteGroupWhenEmpty false;
_group setVariable ["Vcm_Disable",true];

_side = side _group;
_units = units _group;
_men = count units _group;
_men_left = _men;
_center = getpos (leader _group);

while {_men_left != 0} do {
	private ["_random", "_new_group"];
	
	_random = random _numbers;
	_random = round _random;
	_new_group = createGroup [_side, false];
	_new_group setvariable ["TCL_Disabled",true];
	_new_group setvariable ["acpl_dopatrol_oldgroup", _group, true];
	_new_group setVariable ["Vcm_Disable",true];
	
	if (_random > _men_left) then {
		for "_i" from 1 to _men_left do {
			private ["_unit"];
			
			_unit = (units _group) select 0;
			[_unit] join _new_group;
		};
		_men_left = 0;
	} else {
		for "_i" from 1 to _random do {
			private ["_unit"];
			
			_unit = (units _group) select 0;
			[_unit] join _new_group;
		};
		_men_left = _men_left - _random;
	};
	
	[[_new_group, _distance, _check_buildings, _center],acpl_patrol] remoteExec ["spawn",2];
	
	_new_group deleteGroupWhenEmpty true;
	
	_new_group setSpeedMode "LIMITED";
	_new_group setBehaviour "SAFE";
	_new_group setCombatMode "RED";
	_new_group setFormation "STAG COLUMN";
};