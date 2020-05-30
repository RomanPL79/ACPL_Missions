if (!isserver) exitwith {};

acpl_drop_customweapon = {
	params ["_weaponholder", "_class", "_attachments", "_magazines"];
	private ["_dummy", "_dummy_group"];
	
	_dummy_group = createGroup [civilian, false];
	_dummy = _dummy_group createUnit ["C_man_1",(getposatl _weaponholder),[],0,"NONE"];
	
	[_dummy, true] remoteExec ["hideobject",0,true];
	
	_dummy allowdamage false;
	_dummy disableAI "FSM";
	_dummy disableAI "MOVE";
	_dummy disableAI "TARGET";
	dostop _dummy;
	
	_dummy addweapon _class;
	if (count _attachments > 0) then {{_dummy addWeaponItem [_class, _x];} foreach _attachments;};
	if (count _magazines > 0) then {{_dummy addWeaponItem [_class, _x];} foreach _magazines;};
	
	sleep 2;
	
	_dummy action ["DropWeapon", _weaponholder, _class];
	waitUntil { !(_class in weapons _dummy) };
	
	deletevehicle _dummy;
	deleteGroup _dummy_group;
};
publicvariable "acpl_drop_customweapon";

acpl_dostop_duck = {
	params ["_unit", "_pos"];
	private ["_group"];
	
	_pos = toUpper(_pos);
	
	_unit setVariable ["ASF_READY", 0];
	
	_group = group _unit;
	_group deleteGroupWhenEmpty false;
	
	_new_group = createGroup [(side _unit), false];
	[_unit] joinSilent _new_group;
	_new_group setCombatMode "BLUE";
	_new_group setBehaviour "CARELESS";
	
	_new_group setVariable ["Vcm_Disable",true];
	_new_group setvariable ["TCL_Disabled",true];
	_new_group setVariable ["zbe_cacheDisabled",true];
	
	while {_unit getvariable "acpl_dostop_ducking"} do {
		if (_pos == "MIDDLE") then {
			[_unit,"PlayerCrouch"] remoteExec ["playAction",0];
			[_unit,_pos] remoteExec ["setunitpos",0];
		};
		if (_pos == "DOWN") then {
			[_unit,"PlayerProne"] remoteExec ["playAction",0];
			[_unit,_pos] remoteExec ["setunitpos",0];
		};
		sleep 0.1;
	};
	
	[_unit] joinSilent _group;
	
	deleteGroup _new_group;
	
	_unit setCombatMode "YELLOW";
	_unit setBehaviour "SAFE";
	
	_unit setVariable ["ASF_READY", 1];
};
publicvariable "acpl_dostop_duck";

acpl_patrol = {
	params ["_group", "_distance", "_buildings", "_center"];
	private ["_enemy", "_first", "_wp_done", "_pos", "_wp"];
	
	_enemy = [_group] call acpl_check_enemy;
	
	_group setVariable ["acpl_dopatrol_checkinghouses", false, true];
	_group setVariable ["acpl_dopatrol_checkinghouses_done", false, true];
	
	_first = true;
	
	_pos = [0,0,0];
	
	while {[_group] call acpl_check_isgroupalive} do {
		private ["_checking", "_houses"];
		if (diag_fps > 60) then {
			acpl_dopatrol_sleep = 1;
		} else {
			if (diag_fps < 15) then {
				acpl_dopatrol_sleep = 5;
			} else {
				acpl_dopatrol_sleep = 2.5;
			};
		};
		
		if (!(_first)) then {
			_wp_done = [_group, _pos] call acpl_check_waypoint_complited;
		} else {
			_wp_done = false;
		};
		
		if (!([leader _group, _enemy] call acpl_check_knowsaboutenemy) AND ((_first) OR (_wp_done))) then {
			private ["_random_x", "_random_y", "_sleep"];
			
			{deleteWaypoint _x;} foreach (waypoints _group);
			
			_random_x = random [-_distance,0,_distance];
			_random_y = random [-_distance,0,_distance];
			
			_pos = [((_center select 0) - _random_x),((_center select 1) - _random_y)];
			
			if ((_buildings) AND !(_first) AND ([(leader _group), acpl_player_distance] call acpl_check_players_inrange) AND (_wp_done)) then {
				private ["_houses"];
				
				_houses = nearestObjects [leader _group, ["house", "Building"], acpl_patrol_building_distance];
				
				if ((count _houses) > 0) then {
					_group setvariable ["acpl_patrol_checking_houses",true];
					
					[_group, _houses] spawn acpl_check_houses;
					
					private ["_time", "_time_max"];
					_time = time;
					_time_max = _time + acpl_patrol_building_maxtime;
					
					while {(_group getvariable "acpl_patrol_checking_houses")} do {
						if (_time_max < time) then {_group setvariable ["acpl_patrol_checking_houses",false];_group setvariable ["acpl_patrol_checking_houses_done",true];};
						
						sleep 5;
					};
				};
			};
			
			if (_first) then {
				sleep 2;
			} else {
				_sleep = random acpl_patrol_wait;
				sleep _sleep;
			};
			
			_wp = _group addWaypoint [_pos, 0];
			_group setCurrentWaypoint _wp;
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointBehaviour "SAFE";
			_wp setWaypointCombatMode "RED";
			_wp setWaypointFormation "STAG COLUMN";
			
			if (_first) then {_first = false;};
		};
		
		if (([leader _group, _enemy] call acpl_check_knowsaboutenemy)) then {
			{
				_x setVariable ["VCOM_NOAI",false];
				_x setVariable ["Vcm_Disable",false];
			} foreach units _group;
			_group setvariable ["TCL_Disabled",false];
			_group setVariable ["Vcm_Disable",true];
			_group setSpeedMode "NORMAL";
			_group setBehaviour "AWARE";
			_group setCombatMode "RED";
			_group setFormation "WEDGE";
		} else {
			{
				_x setVariable ["VCOM_NOAI",false];
				_x setVariable ["Vcm_Disable",false];
			} foreach units _group;
			_group setvariable ["TCL_Disabled",false];
			_group setVariable ["Vcm_Disable",false];
			_group setSpeedMode "LIMITED";
			_group setBehaviour "SAFE";
			_group setCombatMode "RED";
			_group setFormation "STAG COLUMN";
		};
		
		sleep acpl_dopatrol_sleep;
	};
};
publicvariable "acpl_patrol";

acpl_check_houses = {
	params ["_group", "_houses"];
	private ["_units", "_coverage", "_done"];
	
	_coverage = random acpl_patrol_building_coverage;
	_coverage = round _coverage;
	
	_group setVariable ["acpl_check_houses_done",true];
	
	_units = units _group;
	
	{
		private ["_positions", "_tocheck", "_ischecking", "_count", "_positions_to_check"];
		
		_tocheck = [];
		
		_positions = [_x] call BIS_fnc_buildingPositions;
		_positions = _positions - acpl_buildings_takenpos;
		_positions_to_check = _positions;
		
		{
			if ([_x] call acpl_check_takenposition) then {_positions = _positions - [_x];};
		} foreach _positions_to_check;
		
		_ischecking = [];
		_count = (count _positions) * _coverage;
		_count = round _count;
		
		if (_count == 0) then {
			_group setVariable ["acpl_check_houses_done",false];
		} else {
			_group setVariable ["acpl_check_houses_done",true];
			for "_i" from 1 to _count do {
				private ["_chosen"];
				
				_chosen = _positions select floor(random(count _positions));
				_tocheck = _tocheck + [_chosen];
			};
		};
		
		acpl_buildings_takenpos = acpl_buildings_takenpos + _tocheck;
		
		while {(_group getVariable "acpl_check_houses_done") AND (_group getVariable "acpl_patrol_checking_houses") AND !([leader _group] call acpl_check_knowsaboutenemy)} do {
			private ["_available", "_chosen"];
			
			{
				if (isNil {_x getVariable "acpl_domove"}) then {_x setVariable ["acpl_domove",false];};
				if (_x getVariable "acpl_domove") then {_ischecking = _ischecking - [_x];};
			} foreach _ischecking;
			
			if (((count _tocheck) == 0) AND ((count _ischecking) == 0)) then {
				_group setVariable ["acpl_check_houses_done",false];
				{_x dofollow (leader _group);} foreach _units;
			};
			
			_available = _units - _ischecking;
			if ((count _available) > 0) then {
				_chosen = _available select floor(random(count _available));
				_ischecking = _ischecking + [_chosen];
				
				[_chosen, (_tocheck select 0)] spawn acpl_domove;
				_tocheck = _tocheck - [_tocheck select 0];
			};
			
			sleep 1;
		};
		sleep 5;
	} foreach _houses;
	
	_group setvariable ["acpl_patrol_checking_houses",false];
	_group setvariable ["acpl_patrol_checking_houses_done",true];
};
publicvariable "acpl_check_houses";

acpl_domove = {
	params ["_unit", "_pos"];
	private ["_time", "_time_max"];
	
	if (isNil "_pos") then {_unit setVariable ["acpl_domove",true];} else {
		
		_time = time;
		_time_max = _time + acpl_patrol_domove_maxtime;
		
		_unit setVariable ["acpl_domove",false];
		_unit setVariable ["acpl_domove_pos",_pos];
		
		[_unit, _pos] spawn acpl_moveto;
		
		while {!(_unit getVariable "acpl_domove") AND !([_unit] call acpl_check_knowsaboutenemy)} do {
			
			if ((_unit getvariable "acpl_moveto_completed") OR (_time_max < time)) then {
					sleep (5 + (random 25));
					_unit setVariable ["acpl_domove",true];
					_unit setVariable ["acpl_moveto_completed",true];
					acpl_buildings_takenpos = acpl_buildings_takenpos - [(_unit getVariable "acpl_domove_pos")];
			};
			sleep 1;
		};
	};
};
publicvariable "acpl_domove";

acpl_dostop_roam = {
	params ["_unit", "_pos", "_startpos", "_building"];
	private ["_positions", "_moving"];
	
	sleep 30;
	
	_moving = false;
	
	_positions = [_building] call BIS_fnc_buildingPositions;
	if (count _positions == 0) exitwith {};
	while {(alive _unit) AND (_unit getvariable "acpl_dostop")} do {
		private ["_random", "_sleep", "_available_positions", "_chosen"];
		
		_available_positions = _positions - acpl_buildings_takenpos;
		_chosen = _available_positions select floor(random(count _available_positions));
		
		_random = random 100;
		if ((_random < acpl_dostop_roam_chance) AND !(_moving) AND !(_unit getvariable "acpl_dostop_react")) then {
			private ["_waiting", "_done", "_time", "_done2"];
			
			_unit setvariable ["acpl_dostop_roam",true];
			
			acpl_buildings_takenpos = acpl_buildings_takenpos + [_chosen];
			
			_moving = true;
			_time = (time + acpl_dostop_maxtime);
			
			[_unit,"PATH"] remoteExec ["EnableAI",0];
			_unit setunitpos "PATH";
			[_unit, _chosen] spawn acpl_moveto;
			
			_waiting = true;
			_done = false;
			_done2 = false;
			while {_waiting} do {
				if (((unitReady _unit) OR (_time < time) OR (_unit getvariable "acpl_moveto_completed")) AND !(_done)) then {
					_done = true;
					
					[_unit,"PATH"] remoteExec ["DisableAI",0];
					_unit setunitpos _pos;
					sleep (random acpl_dostop_roam_backtime);
					
					acpl_buildings_takenpos = acpl_buildings_takenpos - [_chosen];
					
					[_unit,"PATH"] remoteExec ["EnableAI",0];
					
					_unit setunitpos "UP";
					[_unit, _startpos] spawn acpl_moveto;
					_done2 = true;
					
					_time = (time + acpl_dostop_maxtime);
				};
				if (((((getPosATL _unit) distance _startpos) < 1.5) OR (_unit getvariable "acpl_moveto_completed") OR (_time < time)) AND _done) then {
					[_unit,"PATH"] remoteExec ["DisableAI",0];
					_unit setunitpos _pos;
					_waiting = false;
					_moving = false;
				};
				
				sleep 1;
			};
		};
		
		_unit setvariable ["acpl_dostop_roam",false];
		
		_sleep = random acpl_dostop_roam_time;
		sleep _sleep;
	};
};
publicvariable "acpl_dostop_roam";

acpl_dostop_react = {
	params ["_unit", "_pos", "_startpos", "_building"];
	private ["_positions", "_moving"];
	
	_moving = false;
	
	_positions = [_building] call BIS_fnc_buildingPositions;
	while {(alive _unit) AND (_unit getvariable "acpl_dostop") AND (_unit getvariable "acpl_dostop_react")} do {
		private ["_random", "_sleep", "_available_positions", "_chosen"];
		
		_available_positions = _positions - acpl_buildings_takenpos + [_startpos];
		_chosen = _available_positions select floor(random(count _available_positions));
		
		acpl_buildings_takenpos = acpl_buildings_takenpos + [_chosen];
		
		_random = random 100;
		if ((_random < acpl_dostop_react_chance) AND !(_moving) AND !(_unit getvariable "acpl_dostop_roam")) then {
			private ["_waiting", "_done", "_time"];
			
			_moving = true;
			_time = (time + acpl_dostop_react_maxtime);
			
			[_unit,"ALL"] remoteExec ["EnableAI",0];
			_unit setunitpos "UP";
			
			[_unit, _chosen] spawn acpl_moveto;
			
			_waiting = true;
			_done = false;
			while {_waiting} do {
				if ((((getPosATL _unit) distance _chosen) < 1.5) OR (_time < time) OR (_unit getvariable "acpl_moveto_completed")) then {
					
					[_unit,"PATH"] remoteExec ["DisableAI",0];
					_unit setunitpos "UP";
					_waiting = false;
					_moving = false;
				};
				sleep 1;
			};
		};
		
		_sleep = random acpl_dostop_react_time;
		sleep _sleep;
		acpl_buildings_takenpos = acpl_buildings_takenpos - [_chosen];
	};
	
	_unit setvariable ["acpl_dostop_react",false];
};
publicvariable "acpl_dostop_react";

acpl_moveto = {
	params ["_unit", "_pos", "_unit2"];
	private ["_onmove"];
	
	_unit setvariable ["acpl_moveto_completed",false,true];
	_onmove = true;
	
	[_unit,_pos] remoteExec ["domove",0];
	
	while {_onmove} do {
		if (!(isNil "_unit2")) then {_pos = getpos _unit2;};
		if ((_unit distance _pos < 1) OR (_unit getvariable "acpl_moveto_completed")) then {
			_onmove = false;
			_unit setvariable ["acpl_moveto_completed",true,true];
			
			[_unit,(leader (group _unit))] remoteExec ["doFollow",0];
		};
		
		[_unit,_pos] remoteExec ["domove",0];
		
		sleep 10;
	};
};
publicvariable "acpl_moveto";

acpl_AI_check_funcs = true;
publicvariable "acpl_AI_check_funcs";

if (acpl_fnc_debug) then {["ACPL FNCS AI FUNCS LOADED"] remoteExec ["systemchat",0];};