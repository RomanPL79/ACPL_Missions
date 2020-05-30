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
	private ["_pos"];
	
	_pos = getpos _firer;
	
	if (_distance < acpl_civs_firedistance) then {
		if (_unit getvariable "acpl_civilian_panicking") then {
			if (!([_pos] call acpl_civ_civilian_shootingpos_check)) then {
				acpl_civilian_shootingpos = acpl_civilian_shootingpos + [_pos];
				[_pos] spawn acpl_civ_civilian_shootingpos_manage;
			};
			_unit setvariable ["acpl_civilian_panicking_time",time,true];
		} else {
			[_unit, _distance, _firer] spawn acpl_civ_hide;
		};
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