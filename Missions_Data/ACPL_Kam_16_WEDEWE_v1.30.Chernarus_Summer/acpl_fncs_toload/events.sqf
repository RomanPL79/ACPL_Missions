acpl_event_DUW = {
	params ["_unit"];

	[["ace_arsenal_displayClosed", {
		private ["_p_weap", "_s_weap", "_h_weap"];
		
		_p_weap = primaryweapon player;
		_s_weap = secondaryweapon player;
		_h_weap = handgunWeapon player;
		
		{
			if (_x != "") then {
				["diwako_unknownwp_addWeapon",_x] call CBA_fnc_serverEvent;
				_weap = [_x] call BIS_fnc_baseWeapon;
				["diwako_unknownwp_addWeapon",_weap] call CBA_fnc_serverEvent;
			};
		} foreach [_p_weap,_s_weap,_h_weap];
	}],CBA_fnc_addEventHandler] remoteExec ["call", _unit, true];
	
	[[missionnamespace,"arsenalClosed", {
		private ["_p_weap", "_s_weap", "_h_weap"];
		
		_p_weap = primaryweapon player;
		_s_weap = secondaryweapon player;
		_h_weap = handgunWeapon player;
		
		{
			if (_x != "") then {
				["diwako_unknownwp_addWeapon",_x] call CBA_fnc_serverEvent;
				_weap = [_x] call BIS_fnc_baseWeapon;
				["diwako_unknownwp_addWeapon",_weap] call CBA_fnc_serverEvent;
			};
		} foreach [_p_weap,_s_weap,_h_weap];
	}],bis_fnc_addScriptedEventhandler] remoteExec ["call", _unit, true];
	
	sleep 20;
	
	private ["_p_weap", "_s_weap", "_h_weap"];
	
	_p_weap = primaryweapon _unit;
	_s_weap = secondaryweapon _unit;
	_h_weap = handgunWeapon _unit;
	if (!(toUpper(_p_weap) in diwako_unknownwp_weapon_whitelist) AND (_p_weap != "")) then {["diwako_unknownwp_addWeapon",_p_weap] call CBA_fnc_serverEvent;_p_weap = [_p_weap] call BIS_fnc_baseWeapon;["diwako_unknownwp_addWeapon",_p_weap] call CBA_fnc_serverEvent;};
	if (!(toUpper(_s_weap) in diwako_unknownwp_weapon_whitelist) AND (_s_weap != "")) then {["diwako_unknownwp_addWeapon",_s_weap] call CBA_fnc_serverEvent;_s_weap = [_p_weap] call BIS_fnc_baseWeapon;["diwako_unknownwp_addWeapon",_s_weap] call CBA_fnc_serverEvent;};
	if (!(toUpper(_h_weap) in diwako_unknownwp_weapon_whitelist) AND (_h_weap != "")) then {["diwako_unknownwp_addWeapon",_h_weap] call CBA_fnc_serverEvent;_h_weap = [_p_weap] call BIS_fnc_baseWeapon;["diwako_unknownwp_addWeapon",_h_weap] call CBA_fnc_serverEvent;};

};
publicvariable "acpl_event_DUW";

acpl_event_hit_function = {
	params ["_unit", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
	
	if (!(_unit in acpl_medical_tocheck)) then {
		acpl_medical_tocheck = acpl_medical_tocheck + [_unit];
	};
	if (!(_unit in allPlayers) AND !(isPlayer _unit)) then {
		if (_unit getvariable "acpl_dostop") then {
			if (!(_unit getvariable "acpl_dostop_ducking")) then {
				_unit setvariable ["acpl_dostop_ducking",true,true];
				if ((_unit getvariable "acpl_dostop_pos") == 1) then {[_unit, "DOWN"] spawn acpl_dostop_duck;};
				if ((_unit getvariable "acpl_dostop_pos") == 2) then {[_unit, "MIDDLE"] spawn acpl_dostop_duck;};
				[_unit] spawn {
					params ["_unit"];
					private ["_time"];
					
					_time = random acpl_dostop_ducktime;
					
					waitUntil {sleep 1;(!([_unit] call acpl_check_supp) AND (((_unit getvariable "acpl_dostop_supp_time") + _time) < time))};
					
					_unit setvariable ["acpl_dostop_ducking",false,true];
				};
			};
		} else {
			
		};
		
	} else {
	};
	
	if ("head" in _selection) then {
		[_unit, _velocity] spawn acpl_hit_drophelmet;
	};
	if (("leftarm" in _selection) OR ("leftforearm" in _selection) OR ("rightforearm" in _selection) OR ("rightarm" in _selection)) then {
		[_unit] spawn acpl_hit_dropweapon;
	};
	if (("rightleg" in _selection) OR ("rightupleg" in _selection) OR ("leftupleg" in _selection) OR ("leftleg" in _selection) OR ("leftfoot" in _selection) OR ("rightfoot" in _selection)) then {
		[_unit] spawn acpl_hit_fallonground;
	};
};
publicvariable "acpl_event_hit_function";

acpl_event_hit = {
	params ["_unit"];
	
	waitUntil {time > 20};
	
	[_unit,["HitPart", {
		(_this select 0) params ["_unit", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
		
		[[_unit, _shooter, _projectile, _position, _velocity, _selection, _ammo, _vector, _radius, _surfaceType, _isDirect],acpl_event_hit_function] remoteExec ["spawn",2];
	}]] remoteExec ["addEventHandler",0,true];
};
publicvariable "acpl_event_hit";

acpl_event_shot_function = {
	params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
	
	if (_distance < acpl_civs_firedistance) then {
	
	};
};
publicvariable "acpl_event_shot_function";

acpl_event_shot = {
	params ["_unit"];
	
	waitUntil {time > 20};
	
	[_unit,["FiredNear", {
		params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
		
		[[_unit, _firer, _distance, _weapon, _muzzle, _mode, _ammo, _gunner],acpl_event_shot_function] remoteExec ["spawn",2];
	}]] remoteExec ["addEventHandler",0,true];
};
publicvariable "acpl_event_shot";