acpl_Medical_AI_funcs = false;

acpl_heal_healing = {
	params ["_unit", "_target"];
	
	_unit attachTo [_target,[-1.5,0,0]];
	sleep 0.01;
	[_unit,90] remoteExec ["setdir",0];
	sleep 0.1;
	detach _unit;
	[_unit, false, false] call ACE_medical_ai_fnc_playTreatmentAnim;
};
publicvariable "acpl_heal_healing";

acpl_heal_findmedic = {
	params ["_units"];
	private ["_return"];
	
	_return = [];
	
	{
		if (alive _x) then {
			if (([_x] call ace_medical_fnc_isMedic) AND !([_x] call acpl_heal_wounded) AND !(_x getvariable "acpl_heal_ishealing")) then {
				_return = _return + [_x];
			};
		};
	} foreach _units;
	
	_return
};
publicvariable "acpl_heal_findmedic";

acpl_heal_hitsound = {
	params ["_unit"];
	
	if (!isserver) exitwith {};
	
	_unit setvariable ["acpl_heal_screaming",true,true];
	
	while {((_unit getvariable "ace_isunconscious") OR ([_unit] call acpl_heal_wounded)) AND (alive _unit)} do {
		private ["_hitSound"];
		
		_hitSound = selectRandom ["Hit1", "Hit2", "Hit3", "Hit4", "Hit5", "Hit6", "Hit7", "Hit8", "Hit9", "Hit10"];		
			
		[_unit,_hitSound] remoteExec ["say3D",0];
		
		sleep (10 + random 60);
	};
	_unit setvariable ["acpl_heal_screaming",false,true];
};
publicvariable "acpl_heal_hitsound";

acpl_heal_callforhelp = {
	params ["_unit"];
	private ["_calling", "_found"];
	
	if (!isserver) exitwith {};
	
	if (_unit getvariable "acpl_heal_calling") exitwith {};
	
	_calling = true;
	_unit setvariable ["acpl_heal_calling",true,true];
	
	while {_calling} do {
		private ["_units", "_random", "_medics"];
		
		_units = nearestObjects [_unit, ["Man"], 50];
		if ((count _units) > 0) then {
			_medics = [_units] call acpl_heal_findmedic;
			if ((count _medics) > 0) then {
				if (!(_unit getvariable "ace_isunconscious")) exitwith {_calling = false;_unit setvariable ["acpl_heal_calling",false,true];[_unit,acpl_heal_call] remoteExec ["spawn",2];};
				_random = _medics select floor(random(count _medics));
				if ((side _random == side _unit) AND !(isPlayer _random) AND !(_random in allplayers) AND !(_random getvariable "ace_isunconscious") AND !(_random getvariable "acpl_heal_ishealing") AND !([_random] call acpl_heal_wounded)) then {
					if (([_random, false] call acpl_heal_havamed) AND !(_random getvariable "acpl_heal_ishealing") AND !(_random getvariable "acpl_heal_calling")) exitwith {
						[[_random, _unit],acpl_heal_unit_full] remoteExec ["spawn",2];
						_calling = false;
						_unit setvariable ["acpl_heal_calling",false,true];
					};
				};
			} else {
				if (!(_unit getvariable "ace_isunconscious")) exitwith {_calling = false;_unit setvariable ["acpl_heal_calling",false,true];[_unit,acpl_heal_call] remoteExec ["spawn",2];};
				_random = _units select floor(random(count _units));
				if ((side _random == side _unit) AND !(isPlayer _random) AND !(_random in allplayers) AND !(_random getvariable "ace_isunconscious") AND !(_random getvariable "acpl_heal_ishealing") AND !([_random] call acpl_heal_wounded)) then {
					if (([_random, false] call acpl_heal_havamed) AND !(_random getvariable "acpl_heal_ishealing") AND !(_random getvariable "acpl_heal_calling")) exitwith {
						[[_random, _unit],acpl_heal_unit_full] remoteExec ["spawn",2];
						_calling = false;
						_unit setvariable ["acpl_heal_calling",false,true];
					};
				};
			};
		};
		
		sleep 1;
	};
};
publicvariable "acpl_heal_callforhelp";

acpl_heal_call = {
	params ["_unit"];
	private ["_status", "_heavy", "_wounds"];
	
	if (!isserver) exitwith {};
	
	if ((_unit getvariable "acpl_heal_calling") OR (_unit getvariable "acpl_heal_ishealing")) exitwith {};
	
	_unit setvariable ["acpl_heal_active",true,true];
	
	_heavy = false;
	_wounds = 0;
	
	_status = _unit getVariable "ace_medical_bodypartstatus";
	
	if ((_unit getvariable "acpl_heal_heavy") OR (_unit getvariable "acpl_heal_calling")) exitwith {};
	
	if ((_status select 0) > 0) then {_wounds = _wounds + (_status select 0)};
	if ((_status select 1) > 0) then {_wounds = _wounds + (_status select 1)};
	if ((_status select 2) > 0) then {_wounds = _wounds + (_status select 2)};
	if ((_status select 3) > 0) then {_wounds = _wounds + (_status select 3)};
	if ((_status select 4) > 0) then {_wounds = _wounds + (_status select 4)};
	if ((_status select 5) > 0) then {_wounds = _wounds + (_status select 5)};
	
	if ((_unit getvariable "acpl_heal_calling")) exitwith {};
	
	if (_wounds > acpl_medicalhelp_heavywounded) then {_heavy = true;};
	
	if ((_unit getvariable "acpl_heal_calling")) exitwith {};
	
	if ((_unit getvariable "ace_isunconscious")) then {
		[[_unit],acpl_heal_callforhelp] remoteExec ["spawn",2];
	} else {
		if (!(isplayer _unit) AND !(_unit in allplayers)) then {
			if (!(_unit getvariable "ace_captives_ishandcuffed")) then {[[_unit],acpl_heal_self_full] remoteExec ["spawn",2];};
			_unit setvariable ["acpl_heal_heavy",false,true];
		};
		if ((_heavy) AND !(isPlayer _unit) AND !(_unit in allplayers) AND !(_unit getvariable "ace_isunconscious")) then {
			if (_unit getVariable "acpl_anim") then {} else {[_unit, "PRONE_INJURED", objNull, false, true] call acpl_play_anim;};
			_unit setvariable ["acpl_heal_heavy",true,true];
		};
	};
};
publicvariable "acpl_heal_call";

acpl_heal_wounded = {
	params ["_unit"];
	private ["_status", "_return"];
	
	if (!isserver) exitwith {};
	
	_return = false;
	
	_status = _unit getVariable "ace_medical_bodypartstatus";
	if (isNil "_status") exitwith {_return};
	if ((_status select 0) > 0) exitwith {_return = true;_return};
	if ((_status select 1) > 0) exitwith {_return = true;_return};
	if ((_status select 2) > 0) exitwith {_return = true;_return};
	if ((_status select 3) > 0) exitwith {_return = true;_return};
	if ((_status select 4) > 0) exitwith {_return = true;_return};
	if ((_status select 5) > 0) exitwith {_return = true;_return};
	
	_return
};
publicvariable "acpl_heal_wounded";

acpl_heal_havamed = {
	params ["_unit", ["_delete", true]];
	private ["_return", "_items"];
	
	_return = false;
	_items = items _unit;
	
	if ("ACE_personalAidKit" in _items) exitwith {_return = true;_return};
	if ("ACE_surgicalKit" in _items) exitwith {_return = true;_return};
	if ("ACE_fieldDressing" in _items) exitwith {_return = true;if (_delete) then {_unit removeitem "ACE_fieldDressing";};_return};
	if ("ACE_elasticBandage" in _items) exitwith {_return = true;if (_delete) then {_unit removeitem "ACE_elasticBandage";};_return};
	if ("ACE_packingBandage" in _items) exitwith {_return = true;if (_delete) then {_unit removeitem "ACE_packingBandage";};_return};
	if ("ACE_quikclot" in _items) exitwith {_return = true;if (_delete) then {_unit removeitem "ACE_quikclot";};_return};
	
	_return
};
publicvariable "acpl_heal_havamed";

acpl_heal_self_full = {
	params ["_unit"];
	private ["_pos", "_time"];
	
	if (!isserver) exitwith {};
	
	_time = time + 30;
	
	if (!(_unit getvariable "ace_isunconscious") AND !(_unit getvariable "acpl_heal_heavy")) then {
		_unit setvariable ["acpl_heal_ishealing",true,true];
		if ((_unit call ACE_medical_ai_fnc_isSafe) OR ((_unit getVariable "ace_medical_bloodvolume") < 40)) then {
			private ["_random"];
			
			_random = random 100;
			if (_random < acpl_medicalhelp_coverchance) then {
				_pos = [_unit] call acpl_heal_findcover;
				
				[_unit,_pos] remoteExec ["domove",0];
				[[_unit,_pos],acpl_moveto] remoteExec ["spawn",2];
				
				waitUntil {sleep 1;((_unit distance _pos < 3.5) OR (_time < time))};
				_unit setvariable ["acpl_moveto_completed",true,true];
				[_unit,"AUTOCOMBAT"] remoteExec ["enableAI",0];
			};
		} else {
			_pos = [_unit] call acpl_heal_findcover;
			[_unit,"AUTOCOMBAT"] remoteExec ["disableAI",0];
			
			[_unit,_pos] remoteExec ["domove",0];
			[[_unit,_pos],acpl_moveto] remoteExec ["spawn",2];
			
			waitUntil {sleep 1;((_unit distance _pos < 3.5) OR (_time < time))};
			_unit setvariable ["acpl_moveto_completed",true,true];
			[_unit,"AUTOCOMBAT"] remoteExec ["enableAI",0];
		};
		if ([_unit] call acpl_heal_havamed) then {
			[_unit, false, true] call ACE_medical_ai_fnc_playTreatmentAnim;
			sleep 5;
			if (!(_unit getvariable "ace_isunconscious") AND (alive _unit)) then {
				[[objNull, _unit],ace_medical_fnc_treatmentAdvanced_fullHealLocal] remoteExec ["call",2];
				[[_unit],acpl_heal_meds] remoteExec ["spawn",2];
				_unit setdamage 0;
			};
			_unit setvariable ["acpl_heal_ishealing",false,true];
			_unit setvariable ["acpl_heal_active",false,true];
			_unit setunitpos "auto";
		} else {
			[_unit] spawn acpl_heal_callmedic;
		};
	} else {
		[_unit] spawn acpl_heal_callforhelp;
	};
};
publicvariable "acpl_heal_self_full";

acpl_heal_callmedic = {
	params ["_unit"];
	private ["_calling", "_found"];
	
	if (!isserver) exitwith {};
	
	if (_unit getvariable "acpl_heal_calling") exitwith {};
	
	_random = random 100;
	if (_random < acpl_medicalhelp_coverchance) then {
		_pos = [_unit] call acpl_heal_findcover;
		
		[_unit,_pos] remoteExec ["domove",0];
		[[_unit,_pos],acpl_moveto] remoteExec ["spawn",2];
		
		waitUntil {sleep 1;((_unit distance _pos < 3.5))};
		_unit setvariable ["acpl_moveto_completed",true,true];
	};
	
	_calling = true;
	_unit setvariable ["acpl_heal_calling",true,true];
	
	while {_calling} do {
		private ["_units", "_random"];
		
		_units = nearestObjects [_unit, ["Man"], 50];
		if (count _units > 0) then {
			{
				if (_unit getvariable "ace_isunconscious") then {_calling = false;_unit setvariable ["acpl_heal_calling",false,true];};
				_random = _units select floor(random(count _units));
				_units = _units - [_random];
				if (side _random == side _unit) then {
					if ([_random, false] call acpl_heal_havamed) then {
						[_random, _unit] spawn acpl_heal_unit_full;
						_calling = false;
						_unit setvariable ["acpl_heal_calling",false,true];
					};
				};
			} foreach _units;
		};
		
		sleep (5 + random 10);
	};
	
	[_found, _unit] spawn acpl_heal_unit_full;
};
publicvariable "acpl_heal_callmedic";

acpl_heal_unit_full = {
	params ["_unit", "_target"];
	
	if (!isserver) exitwith {};
	
	if (!(_unit getvariable "ace_isunconscious") AND !(_unit getvariable "acpl_heal_active") AND !(_unit getvariable "acpl_heal_ishealing")) then {
		
		_unit setvariable ["acpl_heal_ishealing",true,true];
		[_unit,"AUTOCOMBAT"] remoteExec ["disableAI",0];
		
		if (_target getvariable "ace_isunconscious") then {
			
			if ((_target call ACE_medical_ai_fnc_isSafe) OR ((_target getVariable "ace_medical_bloodvolume") > 40)) then {
				private ["_random"];
				
				_random = random 100;
				
				if (_random > acpl_medicalhelp_dragwounded) then {
					if ([_target] call acpl_heal_wounded) then {
						[_unit,(getpos _target)] remoteExec ["domove",0];
						[[_unit,(getpos _target),_target],acpl_moveto] remoteExec ["spawn",2];
						
						waitUntil {sleep 1;(((_unit distance _target) < 3.5) OR ([_unit] call acpl_heal_wounded))};
						_unit setvariable ["acpl_moveto_completed",true,true];
						if ([_unit] call acpl_heal_wounded) exitwith {
							_unit setvariable ["acpl_heal_ishealing",false,true];
							_target setvariable ["acpl_heal_ishealing",false,true];
							_unit setvariable ["acpl_heal_active",false,true];
							_target setvariable ["acpl_heal_active",false,true];
						};
						[_unit, false, false] call ACE_medical_ai_fnc_playTreatmentAnim;
						sleep 10;
						if (!(_unit getvariable "ace_isunconscious") AND (alive _unit)) then {
							[[objNull, _target],ace_medical_fnc_treatmentAdvanced_fullHealLocal] remoteExec ["call",2];
							[[_unit],acpl_heal_meds] remoteExec ["spawn",2];
							_target setdamage 0;
							[_target, false] call ace_medical_fnc_setUnconscious;
						};
						[_unit,"AUTOCOMBAT"] remoteExec ["enableAI",0];
						if (_target getVariable "acpl_anim") then {_target call acpl_func_animterminate;};
						_target setvariable ["acpl_heal_heavy",false,true];
						{[_target,_x] remoteExec ["enableAI",0];} foreach ["AUTOCOMBAT", "PATH"];
						_unit setvariable ["acpl_heal_ishealing",false,true];
						_target setvariable ["acpl_heal_ishealing",false,true];
						_unit setvariable ["acpl_heal_active",false,true];
						_target setvariable ["acpl_heal_active",false,true];
					} else {
						[_unit,"AUTOCOMBAT"] remoteExec ["enableAI",0];
						_unit setvariable ["acpl_heal_ishealing",false,true];
						_target setvariable ["acpl_heal_ishealing",false,true];
						_unit setvariable ["acpl_heal_active",false,true];
						_target setvariable ["acpl_heal_active",false,true];
						_unit setvariable ["acpl_moveto_completed",true,true];
					};
				} else {
					[_unit, _target] spawn acpl_heal_drag;
				};
			} else {
				[_unit, _target] spawn acpl_heal_drag;
			};
		} else {
			if ([_target, false] call acpl_heal_havamed) then {
				if (!(_unit getvariable "ace_captives_ishandcuffed")) then {[_target] spawn acpl_heal_self_full;};
				[_unit,"AUTOCOMBAT"] remoteExec ["enableAI",0];
				_unit setvariable ["acpl_heal_ishealing",false,true];
				_target setvariable ["acpl_heal_ishealing",false,true];
				_unit setvariable ["acpl_heal_active",false,true];
				_target setvariable ["acpl_heal_active",false,true];
			} else {
				private ["_random"];
				
				_random = random 100;
				if (_random < acpl_medicalhelp_coverchance) then {
					_pos = [_unit] call acpl_heal_findcover;
					
					[_unit,_pos] remoteExec ["domove",0];
					[[_unit,_pos],acpl_moveto] remoteExec ["spawn",2];
					
					waitUntil {sleep 1;((_unit distance _pos < 3.5) OR (_time < time))};
					_unit setvariable ["acpl_moveto_completed",true,true];
				};
				
				[_unit,(getpos _target)] remoteExec ["domove",0];
				[[_unit,(getpos _target),_target],acpl_moveto] remoteExec ["spawn",2];
						
				waitUntil {sleep 1;(((_unit distance _target) < 3.5) OR ([_unit] call acpl_heal_wounded))};
				_unit setvariable ["acpl_moveto_completed",true,true];
				if ([_unit] call acpl_heal_wounded) exitwith {
					_unit setvariable ["acpl_heal_ishealing",false,true];
					_target setvariable ["acpl_heal_ishealing",false,true];
					_unit setvariable ["acpl_heal_active",false,true];
					_target setvariable ["acpl_heal_active",false,true];
				};
				[_unit, false, false] call ACE_medical_ai_fnc_playTreatmentAnim;
				sleep 10;
				if (!(_unit getvariable "ace_isunconscious") AND (alive _unit)) then {
					[[objNull, _target],ace_medical_fnc_treatmentAdvanced_fullHealLocal] remoteExec ["call",2];
					[[_unit],acpl_heal_meds] remoteExec ["spawn",2];
					_target setdamage 0;
					[_target, false] call ace_medical_fnc_setUnconscious;
				};
				[_unit,"AUTOCOMBAT"] remoteExec ["enableAI",0];
				if (_target getVariable "acpl_anim") then {_target call acpl_func_animterminate;};
				_target setvariable ["acpl_heal_heavy",false,true];
				{[_target,_x] remoteExec ["enableAI",0];} foreach ["AUTOCOMBAT", "PATH"];
				_unit setvariable ["acpl_heal_ishealing",false,true];
				_target setvariable ["acpl_heal_ishealing",false,true];
				_unit setvariable ["acpl_heal_active",false,true];
				_target setvariable ["acpl_heal_active",false,true];
				_unit setvariable ["acpl_moveto_completed",true,true];
			};
		};
	};
};
publicvariable "acpl_heal_unit_full";

acpl_heal_drag = {
	params ["_unit", "_target"];
	private ["_pos", "_smoke", "_magazines", "_smoke_avaible", "_lower_mags", "_target_pos", "_unit_pos"];
	
	if (!isserver) exitwith {};
	
	_unit setvariable ["acpl_heal_active",true,true];
	_target setvariable ["acpl_heal_active",true,true];
	_unit setvariable ["acpl_heal_ishealing",true,true];
	_target setvariable ["acpl_heal_ishealing",true,true];
	
	_magazines = magazines _unit;
	_smoke = ["smokeshell", "smokeshellblue", "smokeshellgreen", "smokeshellred", "smokeshellyellow", "SmokeShellPurple", "SmokeShellOrange", "rhs_mag_rdg2_black", "rhs_mag_rdg2_white", "rhs_mag_an_m8hc"];
	
	_lower_mags = [];
	{
		_lower_mags = _lower_mags + [(tolower _x)];
	} foreach _magazines;
	
	_smoke_avaible = [];
	{
		private ["_class"];
		
		_class = tolower _x;
		if (_x in _lower_mags) then {
			_smoke_avaible = _smoke_avaible + [_x];
		};
	} foreach _smoke;
	
	if ((count _smoke_avaible) > 0) then {
		[_unit,_target] remoteExec ["doWatch",0];
		sleep 1;
		[_unit, "SmokeShellMuzzle"] call BIS_fnc_fire;
		sleep (1 + random 3);
		[_unit,objNull] remoteExec ["doWatch",0];
	} else {};
	
	[_unit,(getpos _target)] remoteExec ["domove",0];
	[[_unit,(getpos _target),_target],acpl_moveto] remoteExec ["spawn",2];
	
	waitUntil {sleep 1;(((_unit distance _target) < 3.5) OR ([_unit] call acpl_heal_wounded) OR !(_target getvariable "ace_isunconscious"))};
	_unit setvariable ["acpl_moveto_completed",true,true];
	if ([_unit] call acpl_heal_wounded) exitwith {
		_unit setvariable ["acpl_heal_ishealing",false,true];
		_target setvariable ["acpl_heal_ishealing",false,true];
		_unit setvariable ["acpl_heal_active",false,true];
		_target setvariable ["acpl_heal_active",false,true];
	};
	if (!(_target getvariable "ace_isunconscious")) exitwith {
		_unit setvariable ["acpl_heal_ishealing",false,true];
		_target setvariable ["acpl_heal_ishealing",false,true];
		_unit setvariable ["acpl_heal_active",false,true];
		_target setvariable ["acpl_heal_active",false,true];
		[_target] spawn acpl_heal_callmedic;
	};
	
	[_unit,"grabDrag"] remoteExec ["playAction",0];
	[_unit,"ANIM"] remoteExec ["DisableAI",0];
	if (_target getVariable "acpl_anim") then {_target call acpl_func_animterminate;};
	[_target,"AinjPpneMrunSnonWnonDb"] remoteExec ["switchmove",0];
	[_target,"ANIM"] remoteExec ["DisableAI",0];
	
	sleep 0.01;
	
	waitUntil { ((AnimationState _unit) == "AmovPercMstpSlowWrflDnon_AcinPknlMwlkSlowWrflDb_2") || ((AnimationState _unit) == "AmovPercMstpSnonWnonDnon_AcinPknlMwlkSnonWnonDb_2") || !(alive _unit) || (_unit getvariable "ace_isunconscious")}; 
	
	if (!(alive _target) || !(alive _unit) || (_unit getvariable "ace_isunconscious")) exitwith {
		detach _target;
		[_target,""] remoteExec ["switchMove",0,true];
		[_unit,""] remoteExec ["switchMove",0,true];
		if (_target getVariable "acpl_heal_heavy") then {
			[_target, "PRONE_INJURED", objNull, false, true] call acpl_play_anim;
		};
		_unit setvariable ["acpl_heal_active",false,true];
		_target setvariable ["acpl_heal_active",false,true];
		[_target,"ANIM"] remoteExec ["EnableAI",0];
		[_unit,"ANIM"] remoteExec ["EnableAI",0];
	};
	
	[_unit, _target] spawn acpl_heal_drag_wounded;
};
publicvariable "acpl_heal_drag";

acpl_heal_drag_wounded = {
	params ["_unit", "_target"];
	private ["_dummygrp", "_dummy", "_pos", "_time"];
	
	if (!isserver) exitwith {};
	
	_time = time + 15;
	
	_dummygrp = createGroup civilian;
	_dummy = _dummygrp createUnit ["C_man_polo_1_F", Position _unit, [], 0, "FORM"];
	_dummy setUnitPos "up";
	[_dummy,true] remoteExec ["hideobject",0,true];
	[_dummy,false] remoteExec ["allowdammage",0,true];
	_dummy setBehaviour "CARELESS";
	[_dummy,"FSM"] remoteExec ["disableAI",0];
	[_dummy,1.5] remoteExec ["forceSpeed",0];
	
	_unit attachTo [_dummy, [0, -0.2, 0]];
	sleep 0.01;
	[_unit,180] remoteExec ["setDir",0];
	
	[_target,false] remoteExec ["allowdammage",0,true];
	
	_target attachTo [_unit, [0, 1.2, 0]];
	sleep 0.01;
	[_target,180] remoteExec ["setDir",0];
	
	if (!(alive _target) OR !(alive _unit) OR (_unit getvariable "ace_isunconscious") OR (_time < time)) then {
		detach _target;
		detach _unit;
		_target_pos = getpos _target;
		_unit_pos = getpos _unit;
		[_target,_target_pos] remoteExec ["setpos",0];
		[_unit,_unit_pos] remoteExec ["setpos",0];
		[_target,""] remoteExec ["switchMove",0,true];
		[_unit,""] remoteExec ["switchMove",0,true];
		deletevehicle _dummy;
		if (_target getVariable "acpl_heal_heavy") then {
			[_target, "PRONE_INJURED", objNull, false, true] call acpl_play_anim;
		};
		if ((_time > time) AND !(_unit getvariable "ace_isunconscious")) then {
			
			[[_unit, _target],acpl_heal_healing] remoteExec ["spawn",2];
			sleep 10;
			if (!(_unit getvariable "ace_isunconscious") AND (alive _unit)) then {
				_target call acpl_func_animterminate;
				[[objNull, _target],ace_medical_fnc_treatmentAdvanced_fullHealLocal] remoteExec ["call",2];
				[_unit,""] remoteExec ["switchmove",0];
				_target setunitpos "auto";
				[[_unit],acpl_heal_meds] remoteExec ["spawn",2];
				_target setdamage 0;
			};
			[_target,true] remoteExec ["allowdammage",0,true];
			[_target, false] call ace_medical_fnc_setUnconscious;
			[_unit,"AUTOCOMBAT"] remoteExec ["enableAI",0];
			_unit setvariable ["acpl_heal_active",false,true];
			_target setvariable ["acpl_heal_active",false,true];
			_unit setvariable ["acpl_moveto_completed",true,true];
			[_target,"ANIM"] remoteExec ["EnableAI",0];
			[_unit,"ANIM"] remoteExec ["EnableAI",0];
			[_target,true] remoteExec ["allowdammage",0,true];
			_target setunitpos "auto";
			if (true) exitwith {};
		};
		_unit setvariable ["acpl_heal_active",false,true];
		_target setvariable ["acpl_heal_active",false,true];
		[_target,"ANIM"] remoteExec ["EnableAI",0];
		[_unit,"ANIM"] remoteExec ["EnableAI",0];
		[_target,true] remoteExec ["allowdammage",0,true];
		_target setunitpos "auto";
		if (_unit getvariable "ace_isunconscious") then {
			[_unit, false] call ace_medical_fnc_setUnconscious;
			[_unit, true] call ace_medical_fnc_setUnconscious;
		};
		[_target, false] call ace_medical_fnc_setUnconscious;
		[_target, true] call ace_medical_fnc_setUnconscious;
		_unit setvariable ["acpl_moveto_completed",true,true];
		if (true) exitwith {};
	};
	
	_pos = [_unit] call acpl_heal_findcover;
	
	if (!(alive _target) OR !(alive _unit) OR (_unit getvariable "ace_isunconscious") OR (_time < time)) then {
		detach _target;
		detach _unit;
		_target_pos = getpos _target;
		_unit_pos = getpos _unit;
		[_target,_target_pos] remoteExec ["setpos",0];
		[_unit,_unit_pos] remoteExec ["setpos",0];
		[_target,""] remoteExec ["switchMove",0,true];
		[_unit,""] remoteExec ["switchMove",0,true];
		deletevehicle _dummy;
		if (_target getVariable "acpl_heal_heavy") then {
			[_target, "PRONE_INJURED", objNull, false, true] call acpl_play_anim;
		};
		if ((_time > time) AND !(_unit getvariable "ace_isunconscious")) then {
			
			[[_unit, _target],acpl_heal_healing] remoteExec ["spawn",2];
			sleep 10;
			if (!(_unit getvariable "ace_isunconscious") AND (alive _unit)) then {
				_target call acpl_func_animterminate;
				[[objNull, _target],ace_medical_fnc_treatmentAdvanced_fullHealLocal] remoteExec ["call",2];
				[_unit,""] remoteExec ["switchmove",0];
				_target setunitpos "auto";
				[[_unit],acpl_heal_meds] remoteExec ["spawn",2];
				_target setdamage 0;
			};
			[_target,true] remoteExec ["allowdammage",0,true];
			[_target, false] call ace_medical_fnc_setUnconscious;
			[_unit,"AUTOCOMBAT"] remoteExec ["enableAI",0];
			_unit setvariable ["acpl_heal_active",false,true];
			_target setvariable ["acpl_heal_active",false,true];
			[_target,"ANIM"] remoteExec ["EnableAI",0];
			[_unit,"ANIM"] remoteExec ["EnableAI",0];
			[_target,true] remoteExec ["allowdammage",0,true];
			_target setunitpos "auto";
			if (true) exitwith {};
		};
		_unit setvariable ["acpl_heal_active",false,true];
		_target setvariable ["acpl_heal_active",false,true];
		[_target,"ANIM"] remoteExec ["EnableAI",0];
		[_unit,"ANIM"] remoteExec ["EnableAI",0];
		[_target,true] remoteExec ["allowdammage",0,true];
		_target setunitpos "auto";
		if (_unit getvariable "ace_isunconscious") then {
			[_unit, false] call ace_medical_fnc_setUnconscious;
			[_unit, true] call ace_medical_fnc_setUnconscious;
		};
		[_target, false] call ace_medical_fnc_setUnconscious;
		[_target, true] call ace_medical_fnc_setUnconscious;
		_unit setvariable ["acpl_moveto_completed",true,true];
		if (true) exitwith {};
	};
	
	[_unit,"AcinPknlMwlkSrasWrflDb"] remoteExec ["playMove",0];
	[_unit,"ANIM"] remoteExec ["disableAI",0];
	
	if (!(alive _target) OR !(alive _unit) OR (_unit getvariable "ace_isunconscious") OR (_time < time)) then {
		detach _target;
		detach _unit;
		_target_pos = getpos _target;
		_unit_pos = getpos _unit;
		[_target,_target_pos] remoteExec ["setpos",0];
		[_unit,_unit_pos] remoteExec ["setpos",0];
		[_target,""] remoteExec ["switchMove",0,true];
		[_unit,""] remoteExec ["switchMove",0,true];
		deletevehicle _dummy;
		if (_target getVariable "acpl_heal_heavy") then {
			[_target, "PRONE_INJURED", objNull, false, true] call acpl_play_anim;
		};
		if ((_time > time) AND !(_unit getvariable "ace_isunconscious")) then {
			private ["_classes", "_class"];
			
			[[_unit, _target],acpl_heal_healing] remoteExec ["spawn",2];
			sleep 10;
			if (!(_unit getvariable "ace_isunconscious") AND (alive _unit)) then {
				_target call acpl_func_animterminate;
				[[objNull, _target],ace_medical_fnc_treatmentAdvanced_fullHealLocal] remoteExec ["call",2];
				[_unit,""] remoteExec ["switchmove",0];
				_target setunitpos "auto";
				[[_unit],acpl_heal_meds] remoteExec ["spawn",2];
				_target setdamage 0;
			};
			[_target,true] remoteExec ["allowdammage",0,true];
			[_target, false] call ace_medical_fnc_setUnconscious;
			[_unit,"AUTOCOMBAT"] remoteExec ["enableAI",0];
			_unit setvariable ["acpl_heal_active",false,true];
			_target setvariable ["acpl_heal_active",false,true];
			[_target,"ANIM"] remoteExec ["EnableAI",0];
			[_unit,"ANIM"] remoteExec ["EnableAI",0];
			[_target,true] remoteExec ["allowdammage",0,true];
			_target setunitpos "auto";
			if (true) exitwith {};
		};
		_unit setvariable ["acpl_heal_active",false,true];
		_target setvariable ["acpl_heal_active",false,true];
		[_target,"ANIM"] remoteExec ["EnableAI",0];
		[_unit,"ANIM"] remoteExec ["EnableAI",0];
		[_target,true] remoteExec ["allowdammage",0,true];
		_target setunitpos "auto";
		if (_unit getvariable "ace_isunconscious") then {
			[_unit, false] call ace_medical_fnc_setUnconscious;
			[_unit, true] call ace_medical_fnc_setUnconscious;
		};
		[_target, false] call ace_medical_fnc_setUnconscious;
		[_target, true] call ace_medical_fnc_setUnconscious;
		_unit setvariable ["acpl_moveto_completed",true,true];
		if (true) exitwith {};
	};
	
	[_dummy,_pos] remoteExec ["domove",0];
	[[_dummy,_pos],acpl_moveto] remoteExec ["spawn",2];
	
	waitUntil {sleep 1;[_dummy,_pos] remoteExec ["domove",0];((_dummy distance _pos < 3.5) OR !(alive _unit) OR (_unit getvariable "ace_isunconscious") OR (_time < time))};
	_dummy setvariable ["acpl_moveto_completed",true,true];
	if (!(alive _target) OR !(alive _unit) OR (_unit getvariable "ace_isunconscious") OR (_time < time)) then {
		detach _target;
		detach _unit;
		_target_pos = getpos _target;
		_unit_pos = getpos _unit;
		[_target,_target_pos] remoteExec ["setpos",0];
		[_unit,_unit_pos] remoteExec ["setpos",0];
		[_target,""] remoteExec ["switchMove",0,true];
		[_unit,""] remoteExec ["switchMove",0,true];
		deletevehicle _dummy;
		if (_target getVariable "acpl_heal_heavy") then {
			[_target, "PRONE_INJURED", objNull, false, true] call acpl_play_anim;
		};
		if ((_time > time) AND !(_unit getvariable "ace_isunconscious")) then {
			
			[[_unit, _target],acpl_heal_healing] remoteExec ["spawn",2];
			sleep 10;
			if (!(_unit getvariable "ace_isunconscious") AND (alive _unit)) then {
				_target call acpl_func_animterminate;
				[[objNull, _target],ace_medical_fnc_treatmentAdvanced_fullHealLocal] remoteExec ["call",2];
				[_unit,""] remoteExec ["switchmove",0];
				_target setunitpos "auto";
				[[_unit],acpl_heal_meds] remoteExec ["spawn",2];
				_target setdamage 0;
			};
			[_target,true] remoteExec ["allowdammage",0,true];
			[_target, false] call ace_medical_fnc_setUnconscious;
			[_unit,"AUTOCOMBAT"] remoteExec ["enableAI",0];
			_unit setvariable ["acpl_heal_active",false,true];
			_target setvariable ["acpl_heal_active",false,true];
			[_target,"ANIM"] remoteExec ["EnableAI",0];
			[_unit,"ANIM"] remoteExec ["EnableAI",0];
			[_target,true] remoteExec ["allowdammage",0,true];
			_target setunitpos "auto";
			if (true) exitwith {};
		};
		_unit setvariable ["acpl_heal_active",false,true];
		_target setvariable ["acpl_heal_active",false,true];
		[_target,"ANIM"] remoteExec ["EnableAI",0];
		[_unit,"ANIM"] remoteExec ["EnableAI",0];
		[_target,true] remoteExec ["allowdammage",0,true];
		_target setunitpos "auto";
		if (_unit getvariable "ace_isunconscious") then {
			[_unit, false] call ace_medical_fnc_setUnconscious;
			[_unit, true] call ace_medical_fnc_setUnconscious;
		};
		[_target, false] call ace_medical_fnc_setUnconscious;
		[_target, true] call ace_medical_fnc_setUnconscious;
		_unit setvariable ["acpl_moveto_completed",true,true];
		if (true) exitwith {};
	};

	_target setunitpos "down";
	
	_target_pos = getpos _target;
	_unit_pos = getpos _unit;
	
	detach _unit;
	detach _target;
	detach _dummy;
	
	[_target,_target_pos] remoteExec ["setpos",0];
	[_unit,_unit_pos] remoteExec ["setpos",0];
	
	deleteVehicle _dummy;
	
	[_target,"ANIM"] remoteExec ["EnableAI",0];
	
	[_target, "PRONE_INJURED", objNull, false, true] call acpl_play_anim;
	
	[_unit,"ANIM"] remoteExec ["EnableAI",0];
	
	[[_unit, _target],acpl_heal_healing] remoteExec ["spawn",2];
	sleep 10;
	if (!(_unit getvariable "ace_isunconscious") AND (alive _unit)) then {
		_target call acpl_func_animterminate;
		[_target, true] call ace_medical_fnc_setUnconscious;
		[[objNull, _target],ace_medical_fnc_treatmentAdvanced_fullHealLocal] remoteExec ["call",2];
		[_unit,""] remoteExec ["switchmove",0];
		[_target,_target_pos] remoteExec ["setpos",0];
		_target setunitpos "auto";
		[[_unit],acpl_heal_meds] remoteExec ["spawn",2];
		[_target, false] call ace_medical_fnc_setUnconscious;
		_target setdamage 0;
	};
	[_target,true] remoteExec ["allowdammage",0,true];
	[_unit,"AUTOCOMBAT"] remoteExec ["enableAI",0];
	_target setvariable ["acpl_heal_heavy",false,true];
	_unit setvariable ["acpl_heal_ishealing",false,true];
	_target setvariable ["acpl_heal_ishealing",false,true];
	_unit setvariable ["acpl_heal_active",false,true];
	_target setvariable ["acpl_heal_active",false,true];
	[_target,true] remoteExec ["allowdammage",0,true];
	_unit setvariable ["acpl_moveto_completed",true,true];
};
publicvariable "acpl_heal_drag_wounded";

acpl_heal_findcover = {
	params ["_unit"];
	private ["_pos", "_emptyHouse", "_positions", "_houseList", "_randomHouse", "_coverobj", "_nearestcoppos"];
	
	_emptyHouse = [];
	_houseList = nearestObjects [_unit, ["house", "Building"], 30];

	if ((count _houseList) < 0) then {
		_randomHouse = _houseList select (floor (random (count _houseList)));
		_positions = [_randomHouse] call BIS_fnc_buildingPositions;
		_pos = _positions select floor(random(count _positions));
	} else { 	
		_pos = [_unit, 1, 30, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	};
	
	_pos
};
publicvariable "acpl_heal_findcover";

acpl_heal_meds = {
	params ["_unit", "_classes", "_class", "_meds"];
	
	_classes = ["MedicalGarbage_01_1x1_v1_F","MedicalGarbage_01_1x1_v2_F","MedicalGarbage_01_1x1_v3_F", "MedicalGarbage_01_Bandage_F","MedicalGarbage_01_FirstAidKit_F","MedicalGarbage_01_Packaging_F"];
	_class = _classes select floor(random(count _classes));
	
	_meds = _class createVehicle (getpos _unit);
	_meds setposATL (getPosATL _unit);
	
	sleep acpl_medicalhelp_debrieslifetime;
	
	for "_i" from 0 to 49 do {private ["_new_pos"];_new_pos = [((getPosATL _meds) select 0), ((getPosATL _meds) select 1), ((getPosATL _meds) select 2) - 0.01];_meds setposATL _new_pos;sleep 0.01;};
	deletevehicle _meds;
};
publicvariable "acpl_heal_meds";

acpl_heal_loop = {
	if (!isserver) exitwith {};
	
	while {true} do {
		acpl_medical_loop_slower = false;
		acpl_medical_loop_sleep = 1;
		
		if (diag_fps > 30) then {
			acpl_medical_loop_sleep = 1;
			acpl_medical_loop_slower = false;
		} else {
			if (diag_fps < 15) then {
				acpl_medical_loop_sleep = 5;
				acpl_medical_loop_slower = true;
			} else {
				acpl_medical_loop_sleep = 2.5;
				acpl_medical_loop_slower = false;
			};
		};
			
		sleep 0.1;
		
		{
			if (!([_x] call acpl_heal_wounded) OR !(alive _x) OR !(vehicle _x == _x)) then {
				acpl_medical_tocheck = acpl_medical_tocheck - [_x];
			};
			if ((alive _x) AND ((_x getvariable "ace_isunconscious") OR ([_x] call acpl_heal_wounded))) then {
				if (!(_x getvariable "acpl_heal_active")) then {
					if (!(_x getvariable "acpl_dostop")) then {[_x,acpl_heal_call] remoteExec ["spawn",2];};
					if (_x getvariable "acpl_heal_screaming") then {} else {[_x,acpl_heal_hitsound] remoteExec ["spawn",2];};
				};
			} else {
				if ((_x getvariable "ace_isunconscious") AND (_x getvariable "acpl_heal_heavy")) then {
					_x call acpl_func_animterminate;
					[_x, false] call ace_medical_fnc_setUnconscious;
					[_x, true] call ace_medical_fnc_setUnconscious;
				};
				if (_x getvariable "acpl_heal_heavy") then {
					_x call acpl_func_animterminate;
				};
			};
			
			if (acpl_medical_loop_slower) then {sleep 0.1;};
		} foreach acpl_medical_tocheck;
		
		sleep acpl_medical_loop_sleep;
	};
};
publicvariable "acpl_heal_loop";

acpl_Medical_AI_funcs = true;
publicvariable "acpl_Medical_AI_funcs";