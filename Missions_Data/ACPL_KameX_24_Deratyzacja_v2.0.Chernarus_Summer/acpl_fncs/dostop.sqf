private ["_building", "_start_dir","_s_num","_dowatch_dir","_anim_choosen","_enemy", "_anim", "_ammo_count", "_ammo_start", "_invehicle", "_vehicle", "_startpos", "_anim_wait"];

params [
"_unit",
"_position",
["_enableduckig",true],
["_hideweapon",false],
["_canrun",true],
["_run",false],
["_getlow",false],
["_animation",false],
["_animationlist",["STAND","STAND_IA","STAND_U1","STAND_U2","STAND_U3","WATCH1","WATCH2","GUARD"]],
["_snap", objNull],
["_snap_exit", nil],
["_rearm", true],
["_roam", false],
["_react", false],
["_supp", true]
];

//_nul = [this,"up",true,false,false,false,false,false,["STAND","STAND_IA","STAND_U1","STAND_U2","STAND_U3","WATCH1","WATCH2","GUARD"],objNull,nil,true,false,false] execVM "acpl_fncs\dostop.sqf";
//v3.0

if (!isserver) exitwith {};

_unit setVariable ["acpl_dostop_runaway_checking",false];
_unit setVariable ["acpl_dostop_ducking",false];

_unit setBehaviour "SAFE";

_start_dir = getDir _unit;
_startpos = getPosATL _unit;

_anim_wait = false;

_position = toLower(_position);

(group _unit) setBehaviour "SAFE";

[_unit,"MOVE"] remoteExec ["EnableAI",0];
[_unit,"PATH"] remoteExec ["DisableAI",0];
[_unit,"AUTOCOMBAT"] remoteExec ["DisableAI",0];

if (isNil "acpl_fncs_initied") then {acpl_fncs_initied = false};

waitUntil {acpl_fncs_initied};

_dowatch_dir = [getpos _unit, _start_dir] call acpl_calculate_posfromdir;

_unit setvariable ["acpl_dostop",true,true];
_unit setvariable ["acpl_dostop_react",false,true];
_unit setvariable ["acpl_dostop_lower",false,true];
if (_position == "up") then {_unit setvariable ["acpl_dostop_pos",2,true];_s_num = 2;};
if (_position == "middle") then {_unit setvariable ["acpl_dostop_pos",1,true];_s_num = 1;};
if (_position == "down") then {_unit setvariable ["acpl_dostop_pos",0,true];_s_num = 0;};

_enemy = [_unit] call acpl_check_enemy;

_building = ((nearestObjects [_unit, ["House", "Building"], 50]) select 0);

if (isNil "acpl_buildings_takenpos") then {acpl_buildings_takenpos = [];};

acpl_buildings_takenpos = acpl_buildings_takenpos + [getPosATL _unit];

if (_roam) then {
	_animation = false;
	
	[_unit, _position, _startpos, _building] spawn acpl_dostop_roam;
};

if (_supp) then {
	if (isNil "acpl_asf_shooters_checked") then {acpl_asf_shooters_checked = [];};
};

if (vehicle _unit != _unit) then {
	_invehicle = true;
	_vehicle = vehicle _unit;
	if (_supp) then {
		_unit setVariable ["ASF_AI", 1];
		_unit setVariable ["ASF_READY", 1];
		acpl_asf_shooters_checked = acpl_asf_shooters_checked + [_unit];
	};
} else {
	_invehicle = false;
	_vehicle = objNull;
	if (_supp) then {
		_vehicle setVariable ["ASF_AI", 1];
		_vehicle setVariable ["ASF_READY", 1];
		if (!(_vehicle in acpl_asf_shooters_checked)) then {acpl_asf_shooters_checked = acpl_asf_shooters_checked + [_vehicle];};
	};
};

if (_hideweapon) then {
	private ["_weapons"];
	
	_weapons = weapons _unit;
	_nul = [_unit,_weapons,_enemy] execVM "acpl_fncs\AI\hideweapon.sqf";
};

_unit forceWalk true;

_unit setunitpos _position;
_unit setVariable ["VCOM_NOAI",true];
_unit setVariable ["Vcm_Disable",true];
_unit setvariable ["TCL_Disabled",true];
(group _unit) setVariable ["Vcm_Disable",true];
(group _unit) setvariable ["TCL_Disabled",true];
(group _unit) setVariable ["zbe_cacheDisabled",true];
(group _unit) setBehaviour "SAFE";
sleep 1;
_unit dowatch _dowatch_dir;

if (isNil "acpl_mainloop_done") then {acpl_mainloop_done = false};

waitUntil {acpl_mainloop_done};

if (vehicle _unit == _unit) then {
	if (_animation) then {
		_unit setVariable ["ASF_AI", 0];
		_anim = _animationlist select floor(random(count _animationlist));
		sleep 2;
		if ([_unit, acpl_player_distance] call acpl_check_players_inrange) then {
			[_unit, _anim, _snap] call acpl_play_anim;
		} else {
			_anim_wait = true;
			_unit setVariable ["acpl_anim",false];
		};
	} else {
		_unit setVariable ["ASF_AI", 1];
	};
};

if (_rearm) then {
	if (_invehicle) then {
		private ["_eh", "_eh2"];
	
		_eh = (vehicle _unit) addEventHandler ["Reloaded", {
			params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];
			
			_unit addmagazine (_oldMagazine select 0);
		}];
		_eh2 = _unit addEventHandler ["Reloaded", {
			params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];
			
			_unit addmagazine (_oldMagazine select 0);
		}];
	} else {
		private ["_eh"];
	
		_eh = _unit addEventHandler ["Reloaded", {
			params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];
			
			_unit addmagazine (_oldMagazine select 0);
		}];
	};
};

if (_enableduckig) then {
	private ["_eh"];
	
	_eh = _unit addEventHandler ["Reloaded", {
		[_this select 0] spawn {
			sleep (random acpl_dostop_ducktime);
			(_this select 0) setVariable ["acpl_dostop_ducking",false];
			(_this select 0) setCombatMode "YELLOW";
			(_this select 0) setBehaviour "SAFE";
		};
	}];
};

_unit dowatch _dowatch_dir;

while {(alive _unit)} do {
	if (diag_fps > 60) then {
		acpl_dostop_sleep = 1;
	} else {
		if (diag_fps < 15) then {
			acpl_dostop_sleep = 5;
		} else {
			acpl_dostop_sleep = 2.5;
		};
	};
	if (_unit getvariable "acpl_dostop") then {
		if ([_unit, acpl_player_distance] call acpl_check_players_inrange) then {
			[_unit, true] remoteExec ["enableSimulationGlobal",2];
			{[_unit,_x] remoteExec ["EnableAI",0];} foreach ["TARGET", "AUTOTARGET", "FSM", "MOVE", "ANIM", "WEAPONAIM", "AIMINGERROR", "SUPPRESSION", "CHECKVISIBLE", "COVER"];
			if (vehicle _unit == _unit) then {
				private ["_a_num"];
				
				_a_num = _unit getvariable "acpl_dostop_pos";
				
				if (((_s_num != _a_num) OR (unitPos _unit != _position)) AND !(_unit getvariable "acpl_dostop_ducking")) then {
					if ((_unit getvariable "acpl_dostop_pos") == 0) then {_unit setunitpos "down";};
					if ((_unit getvariable "acpl_dostop_pos") == 1) then {_unit setunitpos "middle";};
					if ((_unit getvariable "acpl_dostop_pos") == 2) then {_unit setunitpos "up";};
				};
				if (_run) then {
					if (([_unit,_enemy,acpl_betterAI_detection] call acpl_check_knowsaboutenemy) OR ([_unit,acpl_betterAI_detection] call acpl_check_seebody)) then {
						_unit setvariable ["acpl_dostop",false,true];
					};
				};
				if (_getlow) then {
					if ((([_unit,_enemy,acpl_betterAI_detection] call acpl_check_knowsaboutenemy) OR ([_unit,acpl_betterAI_detection] call acpl_check_seebody)) AND !(_unit getvariable "acpl_dostop_lower")) then {
						_unit setvariable ["acpl_dostop_lower",true,true];
						if (_unit getvariable "acpl_dostop_pos" > 0) then {
							_unit setvariable ["acpl_dostop_pos",(_unit getvariable "acpl_dostop_pos") - 1,true];
						};
					};
				};
				if (_animation) then {
					if (([_unit,_enemy,acpl_betterAI_detection] call acpl_check_knowsaboutenemy) OR ([_unit,acpl_betterAI_detection] call acpl_check_seebody)) then {
						if ((_unit getVariable "acpl_anim")) then {
							_unit call acpl_func_animterminate;
							_unit setVariable ["ASF_AI", 1];
							if (!(isNil "_snap_exit")) then {
								_unit setpos _snap_exit;
							};
						};
					};
					if ((!(_unit getVariable "acpl_anim")) AND (!([_unit,_enemy,acpl_betterAI_detection] call acpl_check_knowsaboutenemy)) AND (!([_unit,acpl_betterAI_detection] call acpl_check_seebody))) then {
						if ((isNull _snap) OR ((getpos _snap) distance (getpos _unit) < 1)) then {
							[_unit, _anim, _snap] call acpl_play_anim;
							_unit setVariable ["ASF_AI", 0];
							_anim_wait = false;
						};
					};
				};
				if (_react) then {
					if (([_unit,_enemy,acpl_betterAI_detection] call acpl_check_knowsaboutenemy) AND !(_unit getvariable "acpl_dostop_react")) then {
						_unit setvariable ["acpl_dostop_react",true];
						[_unit, _position, _startpos, _building] spawn acpl_dostop_react;
					};
				};
				if ((alive _unit) AND !(_unit getvariable "ace_isunconscious") AND ([_unit] call acpl_heal_wounded)) then {
					[_unit] spawn acpl_heal_self_full;
				};
				if (_canrun) then {
					if (vehicle _unit == _unit AND !(_unit getVariable "acpl_dostop_runaway_checking")) then {
						[_unit, _enemy] spawn {
							params ["_unit", "_enemy"];
							
							_unit setVariable ["acpl_dostop_runaway_checking",true];
							
							if ([_unit,_enemy] call acpl_dostop_runaway_risk) then {
								_unit setvariable ["acpl_dostop",false,true];
							};
							if ((acpl_ied_noiedsretreat) AND (count (_unit getvariable "acpl_ied_active") == 0)) then {
								_unit setvariable ["acpl_dostop",false,true];
							};
							sleep 15;
							_unit setVariable ["acpl_dostop_runaway_checking",false];
						};
					};
				};
				if (_enableduckig AND !(_unit getvariable "acpl_dostop_ducking")) then {
					if (vehicle _unit == _unit) then {
						if ((needReload _unit) == 1) then {
							_unit setVariable ["acpl_dostop_ducking",true];
							if ((_unit getvariable "acpl_dostop_pos") == 2) then {
								
								[_unit, "MIDDLE"] spawn acpl_dostop_duck;
							};
							if ((_unit getvariable "acpl_dostop_pos") == 1) then {
							
								[_unit, "DOWN"] spawn acpl_dostop_duck;
								};
						} else {
							if (!(_unit getvariable "acpl_dostop_ducking")) then {
								if ((_unit getvariable "acpl_dostop_pos") == 0) then {_unit setunitpos "DOWN";};
								if ((_unit getvariable "acpl_dostop_pos") == 1) then {_unit setunitpos "MIDDLE";};
								if ((_unit getvariable "acpl_dostop_pos") == 2) then {_unit setunitpos "UP";};
								_unit setCombatMode "YELLOW";
								_unit setBehaviour "SAFE";
							};
						};
						if (([_unit] call acpl_check_supp) AND !(_unit getvariable "acpl_dostop_ducking")) then {
							private ["_time"];
							
							_time = random acpl_dostop_ducktime;
							
							_unit setVariable ["acpl_dostop_ducking",true];
							if ((_unit getvariable "acpl_dostop_pos") == 2) then {
								[_unit, _time] spawn {
									params ["_unit", "_time"];
									
									[_unit, "MIDDLE"] spawn acpl_dostop_duck;
									
									waitUntil {sleep acpl_dostop_sleep;(!([_unit] call acpl_check_supp) AND (((_unit getvariable "acpl_dostop_supp_time") + _time) < time))};
									
									_unit setVariable ["acpl_dostop_ducking",false];
									_unit setCombatMode "YELLOW";
									_unit setBehaviour "SAFE";
								};
							};
							if ((_unit getvariable "acpl_dostop_pos") == 1) then {
								[_unit, _time] spawn {
									params ["_unit", "_time"];
									
									[_unit, "DOWN"] spawn acpl_dostop_duck;
									waitUntil {sleep acpl_dostop_sleep;(!([_unit] call acpl_check_supp) AND (((_unit getvariable "acpl_dostop_supp_time") + _time) < time))};

									_unit setVariable ["acpl_dostop_ducking",false];
									_unit setCombatMode "YELLOW";
									_unit setBehaviour "SAFE";
								};
							};
						} else {
							if (!(_unit getvariable "acpl_dostop_ducking")) then {
								if ((_unit getvariable "acpl_dostop_pos") == 0) then {_unit setunitpos "down";};
								if ((_unit getvariable "acpl_dostop_pos") == 1) then {_unit setunitpos "middle";};
								if ((_unit getvariable "acpl_dostop_pos") == 2) then {_unit setunitpos "up";};
								_unit setCombatMode "YELLOW";
								_unit setBehaviour "SAFE";
							};
						};
					};
				};
			};
			if (_invehicle) then {
				if (!(alive _vehicle) OR (vehicle _unit != _vehicle)) then {
					_unit setvariable ["acpl_dostop",false,true];
				};
			};
			sleep acpl_dostop_sleep;
		} else {
			if (_animation) then {
				if (!_anim_wait) then {
					_unit call acpl_func_animterminate;
					_unit setVariable ["ASF_AI", 1];
					_anim_wait = true;
				};
			};
			[_unit, false] remoteExec ["enableSimulationGlobal",2];
			{[_unit,_x] remoteExec ["DisableAI",0];} foreach ["TARGET", "AUTOTARGET", "FSM", "MOVE", "ANIM", "WEAPONAIM", "AIMINGERROR", "SUPPRESSION", "CHECKVISIBLE", "COVER"];
			sleep (acpl_dostop_sleep * 10);
		};
	} else {
		_unit forceWalk false;
		[_unit,"PATH"] remoteExec ["EnableAI",0];
		[_unit,"AUTOCOMBAT"] remoteExec ["EnableAI",0];
		[_unit,"FSM"] remoteExec ["EnableAI",0];
		_unit setunitpos "AUTO";
		_unit dofollow (leader (group _unit));
		sleep 60;
		_unit setVariable ["VCOM_NOAI",false,true];
		_unit setVariable ["Vcm_Disable",false,true];
		_unit setvariable ["TCL_Disabled",false];
		if (_unit == leader (group _unit)) then {
			(group _unit) setvariable ["TCL_Disabled",false];
			(group _unit) setVariable ["Vcm_Disable",true];
		};
		_unit setVariable ["ASF_AI", 0];
		_unit setVariable ["ASF_READY", 0];
		if (true) exitwith {};
	};
};