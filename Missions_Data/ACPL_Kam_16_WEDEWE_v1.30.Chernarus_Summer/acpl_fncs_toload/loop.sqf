if (!isserver) exitwith {};

acpl_camoscript_player = {
	params ["_unit"];
	private ["_weapon", "_lowered", "_speed_scaled", "_speed", "_tbhf", "_ntbh", "_newCamCoefA", "_newCamCoef", "_stA", "_st", "_stanceresult", "_overcastLevel", "_lightlevelscaled", "_sse", "_sss", "_srs", "_sre", "_p", "_timenow", "_lightlevel", "_sunset", "_sunrise", "_sunriseSunsetTime", "_rainLevelA", "_rainLevel", "_windscaled", "_windstrength", "_camo", "_foglevel"];
	
	while {(alive _unit) AND (_unit in allPlayers)} do {
		acpl_camoscript_sleep = 0.1;
		if (diag_fps > 30) then {acpl_camoscript_sleep = 0.1;};
		if (diag_fps < 30) then {acpl_camoscript_sleep = 0.5;};
		if (diag_fps < 15) then {acpl_camoscript_sleep = 1;};
		if (acpl_camoscript_players) then {
			if (vehicle _unit == _unit) then {
				_ntbh = count nearestterrainobjects [_unit,["Tree", "Bush", "Hide"],2.5,false,true];
				//set default tbh factor before if
				_tbhf = 1;
				_ntbh = _ntbh / _tbhf;
							
				_foglevel = linearconversion [0,1,fog,0,0.9,true];
							
				_camo = 0.55;
				
				if (vehicle _unit == _unit) then {
					_speed = speed _unit;
					if (_speed == 0) then {_speed_scaled = 0;} else {_speed_scaled = 1 * (_speed / 25);};
				} else {
					_speed_scaled = 0;
				};
				_lowered = weaponLowered _unit;
				if (_lowered) then {
					_lowered = 0.65;
				} else {
					_lowered = 1;
				};
				_weapon = currentWeapon _unit;
				if (_weapon == "") then {_lowered = 0.2;};
							
				_windstrength = vectormagnitude wind;
				_windscaled = linearconversion [0,7,_windstrength,0,0.9,true];
							
				_rainLevel = linearconversion [0,1,rain,0,0.8,true];
				_rainLevelA = linearconversion [0,1,rain,0,0.9,true];
							
				_sunriseSunsetTime = date call BIS_fnc_sunriseSunsetTime;
				_sunrise = _sunriseSunsetTime select 0;
				_sunset = _sunriseSunsetTime select 1;
				_lightlevel = 0.5;
							
				_timenow = daytime;
							
				_p = 1;
				_sre = _sunrise +_p;
				_srs = _sunrise -_p;
				_sss = _sunset -_p;
				_sse = _sunset +_p;
							
				if ((_timenow >= 0) && (_timenow <=_srs)) then
					{ _lightlevel = 0; };

				if ((_timenow >= _sse) && (_timenow <=24)) then
					{ _lightlevel = 0; };

				if ((_timenow <= _sse) && (_timenow >=_sre)) then
					 { _lightlevel = 1;};

				if ((_timenow >=_srs) && (_timenow <= _sre)) then
					{_lightlevel = 0.5 *(_timenow-_srs);};

				if ((_timenow >=_sss) && (_timenow <=_sse)) then
					{_lightlevel = -0.5 * (_timenow -(_sse));};
							
				_lightlevelscaled = linearconversion [0,1,_lightlevel,0.05,1];
							
				_overcastLevel = linearconversion [0,1,overcast,0,0.9,true];
							
				_stanceresult = stance _unit;
				_st = 1;
				_stA = 0.5;
							
				switch (_stanceresult) do
					{
						case "STAND" : {_st = 1; _stA =1;};
						case "CROUCH" : {_st = 0.6; _stA=0.5;};
						case "PRONE" : {_st = 0.25; _stA =0.4;};
						case "SWIMMING": {_st = 0.75;_stA=0.5;};
						case "UNDEFINED" : {_st = 1;_stA=0;};
					};
				_newCamCoef = sqrt (
					(1-_foglevel) * _camo * _lowered * (1 - _rainLevel) * _lightLevelscaled * (1 - _overcastLevel) * _st * _tbhf / (1 - _speed_scaled)
				);

				_newCamCoefA = sqrt (
					(1-_foglevel) * (1 - _rainLevel) * (1 - _overcastLevel) * _stA * (1-_windscaled)
				);
				_newCamCoefScaled = linearconversion [0,1,_newCamCoef,0,1.6,true];
				_newaudibleCoefScaled = linearconversion [0,1,_newCamCoefA,0.05,1.6,true];
			
				[_unit,["camouflageCoef", _newcamCoefscaled]] remoteExec ["setUnitTrait",0];
				[_unit,["audibleCoef", _newaudibleCoefScaled]] remoteExec ["setUnitTrait",0];
				
				sleep acpl_camoscript_sleep;
			} else {
				[_unit,["camouflageCoef", 1]] remoteExec ["setUnitTrait",0];
				[_unit,["audibleCoef", 1]] remoteExec ["setUnitTrait",0];
				sleep acpl_camoscript_sleep;
			};
		} else {
			[_unit,["camouflageCoef", 1]] remoteExec ["setUnitTrait",0];
			[_unit,["audibleCoef", 1]] remoteExec ["setUnitTrait",0];
			sleep (acpl_camoscript_sleep * 10);
		};
	};
	[_unit,["camouflageCoef", 1]] remoteExec ["setUnitTrait",0];
	[_unit,["audibleCoef", 1]] remoteExec ["setUnitTrait",0];
		
	acpl_camoscript_done = acpl_camoscript_done - [_unit];
};
publicvariable "acpl_camoscript_player";

acpl_loop = {
	private ["_playable", "_static"];
	
	waitUntil {acpl_fncs_initied};
	
	_static = _this select 0;
	
	acpl_mainloop_done = false;
	publicvariable "acpl_mainloop_done";
	
	acpl_radio_added = [];
	publicvariable "acpl_radio_added";

	acpl_msc_done = [];
	publicvariable "acpl_msc_done";

	if (isNil "acpl_medical_done") then {acpl_medical_done = []};
	publicvariable "acpl_medical_done";
	
	acpl_variables_done = [];
	publicvariable "acpl_variables_done";
	
	acpl_static_done = [];
	publicvariable "acpl_static_done";
	
	acpl_dead_added = [];
	publicvariable "acpl_dead_added";
	
	acpl_camoscript_done = [];
	publicvariable "acpl_camoscript_done";
	
	acpl_unitsdone_1 = [];
	acpl_unitsdone_2 = [];
	acpl_civilians = [];
	
	publicvariable "acpl_unitsdone_1";
	publicvariable "acpl_unitsdone_2";
	publicvariable "acpl_civilians";
	
	acpl_medical_tocheck = [];
	publicvariable "acpl_medical_tocheck";
		
	_playable = [] + playableUnits + switchableUnits + allPlayers;
	
	{[_x,"move"] remoteExec ["disableAI",0];} foreach _playable;
	
	sleep 5;
	
	{
		if (((_x in allPlayers) OR (isPlayer _x)) AND !(_x in acpl_camoscript_done)) then {
			[[_x],{
				params ["_unit"];
				
				sleep 10;
				
				[[_unit],acpl_camoscript_player] remoteExec ["spawn",_unit];
			}] remoteExec ["spawn",_x];
			acpl_camoscript_done = acpl_camoscript_done + [_x];
		};
		[[_x],acpl_event_DUW] remoteExec ["spawn",2];
	} foreach _playable;
	
	if (acpl_msc) then {
		acpl_msc_west_acc_mid = (((acpl_msc_west_acc select 0) + (acpl_msc_west_acc select 1))/acpl_msc_west_random);
		acpl_msc_west_shake_mid = (((acpl_msc_west_shake select 0) + (acpl_msc_west_shake select 1))/acpl_msc_west_random);
		acpl_msc_west_speed_mid = (((acpl_msc_west_speed select 0) + (acpl_msc_west_speed select 1))/acpl_msc_west_random);
		acpl_msc_west_spot_mid = (((acpl_msc_west_spot select 0) + (acpl_msc_west_spot select 1))/acpl_msc_west_random);
		acpl_msc_west_time_mid = (((acpl_msc_west_time select 0) + (acpl_msc_west_time select 1))/acpl_msc_west_random);
		acpl_msc_west_general_mid = (((acpl_msc_west_general select 0) + (acpl_msc_west_general select 1))/acpl_msc_west_random);
		acpl_msc_west_courage_mid = (((acpl_msc_west_courage select 0) + (acpl_msc_west_courage select 1))/acpl_msc_west_random);
		acpl_msc_west_reload_mid = (((acpl_msc_west_reload select 0) + (acpl_msc_west_reload select 1))/acpl_msc_west_random);
		
		{publicvariable str(_x);} foreach [acpl_msc_west_reload_mid,acpl_msc_west_courage_mid,acpl_msc_west_general_mid,acpl_msc_west_time_mid,acpl_msc_west_spot_mid,acpl_msc_west_speed_mid,acpl_msc_west_shake_mid,acpl_msc_west_acc_mid];
		
		acpl_msc_east_acc_mid = (((acpl_msc_east_acc select 0) + (acpl_msc_east_acc select 1))/acpl_msc_east_random);
		acpl_msc_east_shake_mid = (((acpl_msc_east_shake select 0) + (acpl_msc_east_shake select 1))/acpl_msc_east_random);
		acpl_msc_east_speed_mid = (((acpl_msc_east_speed select 0) + (acpl_msc_east_speed select 1))/acpl_msc_east_random);
		acpl_msc_east_spot_mid = (((acpl_msc_east_spot select 0) + (acpl_msc_east_spot select 1))/acpl_msc_east_random);
		acpl_msc_east_time_mid = (((acpl_msc_east_time select 0) + (acpl_msc_east_time select 1))/acpl_msc_east_random);
		acpl_msc_east_general_mid = (((acpl_msc_east_general select 0) + (acpl_msc_east_general select 1))/acpl_msc_east_random);
		acpl_msc_east_courage_mid = (((acpl_msc_east_courage select 0) + (acpl_msc_east_courage select 1))/acpl_msc_east_random);
		acpl_msc_east_reload_mid = (((acpl_msc_east_reload select 0) + (acpl_msc_east_reload select 1))/acpl_msc_east_random);
		
		{publicvariable str(_x);} foreach [acpl_msc_east_reload_mid,acpl_msc_east_courage_mid,acpl_msc_east_general_mid,acpl_msc_east_time_mid,acpl_msc_east_spot_mid,acpl_msc_east_speed_mid,acpl_msc_east_shake_mid,acpl_msc_east_acc_mid];
		
		acpl_msc_resistance_acc_mid = (((acpl_msc_resistance_acc select 0) + (acpl_msc_resistance_acc select 1))/acpl_msc_resistance_random);
		acpl_msc_resistance_shake_mid = (((acpl_msc_resistance_shake select 0) + (acpl_msc_resistance_shake select 1))/acpl_msc_resistance_random);
		acpl_msc_resistance_speed_mid = (((acpl_msc_resistance_speed select 0) + (acpl_msc_resistance_speed select 1))/acpl_msc_resistance_random);
		acpl_msc_resistance_spot_mid = (((acpl_msc_resistance_spot select 0) + (acpl_msc_resistance_spot select 1))/acpl_msc_resistance_random);
		acpl_msc_resistance_time_mid = (((acpl_msc_resistance_time select 0) + (acpl_msc_resistance_time select 1))/acpl_msc_resistance_random);
		acpl_msc_resistance_general_mid = (((acpl_msc_resistance_general select 0) + (acpl_msc_resistance_general select 1))/acpl_msc_resistance_random);
		acpl_msc_resistance_courage_mid = (((acpl_msc_resistance_courage select 0) + (acpl_msc_resistance_courage select 1))/acpl_msc_resistance_random);
		acpl_msc_resistance_reload_mid = (((acpl_msc_resistance_reload select 0) + (acpl_msc_resistance_reload select 1))/acpl_msc_resistance_random);
		
		{publicvariable str(_x);} foreach [acpl_msc_resistance_reload_mid,acpl_msc_resistance_courage_mid,acpl_msc_resistance_general_mid,acpl_msc_resistance_time_mid,acpl_msc_resistance_spot_mid,acpl_msc_resistance_speed_mid,acpl_msc_resistance_shake_mid,acpl_msc_resistance_acc_mid];
	};
	
	while {true} do {
		acpl_loop_slower = false;
		acpl_loop_sleep = 1;
		
		if (diag_fps > 30) then {
			acpl_loop_sleep = 1;
			acpl_loop_slower = false;
		} else {
			if (diag_fps < 15) then {
				acpl_loop_sleep = 10;
				acpl_loop_slower = false;
			} else {
				acpl_loop_sleep = 5;
				acpl_loop_slower = true;
			};
		};
		
		sleep 0.1;
		
		if (acpl_loop_slower) then {sleep 0.1;};
		{
			if (_x in acpl_variables_done) then {} else {
				_x setVariable ["acpl_anim",false,true];
				
				if (acpl_ww2_change_m1garand) then {
					if ("LIB_M1_Garand" in (weapons _x)) then {
						[_x,"LIB_M1_Garand"] remoteExec ["removeweapon",_x];
						[_x,"fow_w_m1_garand"] remoteExec ["addweapon",_x];
						if (acpl_loop_slower) then {sleep 0.1;};
					};
				};
				
				if (acpl_ww2_change_leeenfield) then {
					if ("fow_w_leeenfield_no4mk1" in (weapons _x)) then {
						private ["_count"];
						
						[_x,"fow_w_leeenfield_no4mk1"] remoteExec ["removeweapon",_x];
						[_x,"bnae_mk1_virtual"] remoteExec ["addweapon",_x];
						_count = {_x == "fow_10Rnd_303"} count (magazines _x);
						[_x,"fow_10Rnd_303"] remoteExec ["removemagazines",_x];
						[_x,["10Rnd_303_Magazine",_count]] remoteExec ["addmagazines",_x];
						if (acpl_loop_slower) then {sleep 0.1;};
					};
					if ("fow_w_leeenfield_no4mk1_redwood" in (weapons _x)) then {
						private ["_count"];
						
						[_x,"fow_w_leeenfield_no4mk1_redwood"] remoteExec ["removeweapon",_x];
						[_x,"bnae_mk1_virtual"] remoteExec ["addweapon",_x];
						_count = {_x == "fow_10Rnd_303"} count (magazines _x);
						[_x,"fow_10Rnd_303"] remoteExec ["removemagazines",_x];
						[_x,["10Rnd_303_Magazine",_count]] remoteExec ["addmagazines",_x];
						if (acpl_loop_slower) then {sleep 0.1;};
					};
				};
				
				_x setvariable ["acpl_heal_calling",false,true];
				_x setvariable ["acpl_heal_heavy",false,true];
				_x setvariable ["acpl_heal_ishealing",false,true];
				_x setvariable ["acpl_heal_active",false,true];
				_x setvariable ["acpl_heal_screaming",false,true];
				
				if (isNil {_x getvariable "ace_captives_ishandcuffed"}) then {_x setvariable ["ace_captives_ishandcuffed",false,true];};
				
				_x setvariable ["acpl_playanim",false,true];
				_x setvariable ["acpl_playanim_class","",true];
				
				if (isNil {_x getvariable "acpl_dostop"}) then {_x setvariable ["acpl_dostop",false,true];};
				_x setvariable ["acpl_dostop_supp",false,true];
				_x setvariable ["acpl_dostop_supp_time",0,true];
				_x setvariable ["acpl_dostop_ducking",false,true];
				
				_x setvariable ["acpl_helmet",false,true];
				_x setVariable ["acpl_weapon_fasten",false,true];
				
				acpl_variables_done = acpl_variables_done + [_x];
				publicvariable "acpl_variables_done";
			};
			
			if ((_x in acpl_camoscript_done) OR (time > 10)) then {} else {
				if ((_x in allPlayers) OR (isPlayer _x)) then {
					[[_x],{
						params ["_unit"];
						
						sleep 10;
						
						[[_unit],acpl_camoscript_player] remoteExec ["spawn",_unit];
					}] remoteExec ["spawn",_x];
					acpl_camoscript_done = acpl_camoscript_done + [_x];
				};
			};
			
			if ((_x in acpl_msc_done) AND acpl_msc) then {} else {
				if (_x in acpl_msc_exception) then {
					acpl_msc_done = acpl_msc_done + [_x];
					publicvariable "acpl_msc_done";
				} else {
					if (side _x == WEST) then {
						[_x] spawn {
							private ["_acc", "_shake", "_speed", "_spot", "_time", "_general", "_courage", "_reload", "_x"];
							
							_x = _this select 0;
							
							_acc = random [(acpl_msc_west_acc select 0),acpl_msc_west_acc_mid,(acpl_msc_west_acc select 1)];
							_shake = random [(acpl_msc_west_shake select 0),acpl_msc_west_shake_mid,(acpl_msc_west_shake select 1)];
							_speed = random [(acpl_msc_west_speed select 0),acpl_msc_west_speed_mid,(acpl_msc_west_speed select 1)];
							_spot = random [(acpl_msc_west_spot select 0),acpl_msc_west_spot_mid,(acpl_msc_west_spot select 1)];
							_time = random [(acpl_msc_west_time select 0),acpl_msc_west_time_mid,(acpl_msc_west_time select 1)];
							_general = random [(acpl_msc_west_general select 0),acpl_msc_west_general_mid,(acpl_msc_west_general select 1)];
							_courage = random [(acpl_msc_west_courage select 0),acpl_msc_west_courage_mid,(acpl_msc_west_courage select 1)];
							_reload = random [(acpl_msc_west_reload select 0),acpl_msc_west_reload_mid,(acpl_msc_west_reload select 1)];
							
							_x setSkill ["aimingAccuracy", _acc];
							_x setVariable ["acpl_msc_AimAcc", _acc, true];
							_x setSkill ["aimingShake", _shake];
							_x setVariable ["acpl_msc_AimSha", _shake, true];
							_x setSkill ["aimingSpeed", _speed];
							_x setVariable ["acpl_msc_AimSpe", _speed, true];
							_x setSkill ["spotDistance", _spot];
							_x setVariable ["acpl_msc_SpoDis", _spot, true];
							_x setSkill ["spotTime", _time];
							_x setVariable ["acpl_msc_SpoTim", _time, true];
							_x setSkill ["general", _general];
							_x setVariable ["acpl_msc_Gen", _general, true];
							_x setSkill ["courage", _courage];
							_x setVariable ["acpl_msc_Cou", _courage, true];
							_x setSkill ["reloadSpeed", _reload];
							_x setVariable ["acpl_msc_Rel", _reload, true];
							
							acpl_msc_done = acpl_msc_done + [_x];
							publicvariable "acpl_msc_done";
							
							if (acpl_msc_debug) then {["Skill change: Done " + str(_x)] remoteExec ["systemchat",0];};
							if (acpl_loop_slower) then {sleep 0.1;};
						};
					};
					if (side _x == EAST) then {
						[_x] spawn {
							private ["_acc", "_shake", "_speed", "_spot", "_time", "_general", "_courage", "_reload"];
							
							_x = _this select 0;
							
							_acc = random [(acpl_msc_east_acc select 0),acpl_msc_east_acc_mid,(acpl_msc_east_acc select 1)];
							_shake = random [(acpl_msc_east_shake select 0),acpl_msc_east_shake_mid,(acpl_msc_east_shake select 1)];
							_speed = random [(acpl_msc_east_speed select 0),acpl_msc_east_speed_mid,(acpl_msc_east_speed select 1)];
							_spot = random [(acpl_msc_east_spot select 0),acpl_msc_east_spot_mid,(acpl_msc_east_spot select 1)];
							_time = random [(acpl_msc_east_time select 0),acpl_msc_east_time_mid,(acpl_msc_east_time select 1)];
							_general = random [(acpl_msc_east_general select 0),acpl_msc_east_general_mid,(acpl_msc_east_general select 1)];
							_courage = random [(acpl_msc_east_courage select 0),acpl_msc_east_courage_mid,(acpl_msc_east_courage select 1)];
							_reload = random [(acpl_msc_east_reload select 0),acpl_msc_east_reload_mid,(acpl_msc_east_reload select 1)];
							
							_x setSkill ["aimingAccuracy", _acc];
							_x setVariable ["acpl_msc_AimAcc", _acc, true];
							_x setSkill ["aimingShake", _shake];
							_x setVariable ["acpl_msc_AimSha", _shake, true];
							_x setSkill ["aimingSpeed", _speed];
							_x setVariable ["acpl_msc_AimSpe", _speed, true];
							_x setSkill ["spotDistance", _spot];
							_x setVariable ["acpl_msc_SpoDis", _spot, true];
							_x setSkill ["spotTime", _time];
							_x setVariable ["acpl_msc_SpoTim", _time, true];
							_x setSkill ["general", _general];
							_x setVariable ["acpl_msc_Gen", _general, true];
							_x setSkill ["courage", _courage];
							_x setVariable ["acpl_msc_Cou", _courage, true];
							_x setSkill ["reloadSpeed", _reload];
							_x setVariable ["acpl_msc_Rel", _reload, true];
							
							acpl_msc_done = acpl_msc_done + [_x];
							publicvariable "acpl_msc_done";
							
							if (acpl_msc_debug) then {["Skill change: Done " + str(_x)] remoteExec ["systemchat",0];};
							if (acpl_loop_slower) then {sleep 0.1;};
						};
					};
					if (side _x == resistance) then {
						[_x] spawn {
							private ["_acc", "_shake", "_speed", "_spot", "_time", "_general", "_courage", "_reload"];
							
							_x = _this select 0;
							
							_acc = random [(acpl_msc_resistance_acc select 0),acpl_msc_resistance_acc_mid,(acpl_msc_resistance_acc select 1)];
							_shake = random [(acpl_msc_resistance_shake select 0),acpl_msc_resistance_shake_mid,(acpl_msc_resistance_shake select 1)];
							_speed = random [(acpl_msc_resistance_speed select 0),acpl_msc_resistance_speed_mid,(acpl_msc_resistance_speed select 1)];
							_spot = random [(acpl_msc_resistance_spot select 0),acpl_msc_resistance_spot_mid,(acpl_msc_resistance_spot select 1)];
							_time = random [(acpl_msc_resistance_time select 0),acpl_msc_resistance_time_mid,(acpl_msc_resistance_time select 1)];
							_general = random [(acpl_msc_resistance_general select 0),acpl_msc_resistance_general_mid,(acpl_msc_resistance_general select 1)];
							_courage = random [(acpl_msc_resistance_courage select 0),acpl_msc_resistance_courage_mid,(acpl_msc_resistance_courage select 1)];
							_reload = random [(acpl_msc_resistance_reload select 0),acpl_msc_resistance_reload_mid,(acpl_msc_resistance_reload select 1)];
							
							_x setSkill ["aimingAccuracy", _acc];
							_x setVariable ["acpl_msc_AimAcc", _acc, true];
							_x setSkill ["aimingShake", _shake];
							_x setVariable ["acpl_msc_AimSha", _shake, true];
							_x setSkill ["aimingSpeed", _speed];
							_x setVariable ["acpl_msc_AimSpe", _speed, true];
							_x setSkill ["spotDistance", _spot];
							_x setVariable ["acpl_msc_SpoDis", _spot, true];
							_x setSkill ["spotTime", _time];
							_x setVariable ["acpl_msc_SpoTim", _time, true];
							_x setSkill ["general", _general];
							_x setVariable ["acpl_msc_Gen", _general, true];
							_x setSkill ["courage", _courage];
							_x setVariable ["acpl_msc_Cou", _courage, true];
							_x setSkill ["reloadSpeed", _reload];
							_x setVariable ["acpl_msc_Rel", _reload, true];
							
							acpl_msc_done = acpl_msc_done + [_x];
							publicvariable "acpl_msc_done";
							
							if (acpl_msc_debug) then {["Skill change: Done " + str(_x)] remoteExec ["systemchat",0];};
							if (acpl_loop_slower) then {sleep 0.1;};
						};
					};
				};
			};
			
			if (acpl_medical AND !(_x in acpl_medical_done) AND !(_x in acpl_medical_mc) AND !(_x in acpl_medical_exep)) then {
				
				[[_x],acpl_event_hit] remoteExec ["spawn",_x];
				
				if (_x in _playable) then {
					private ["_medic"];
					
					[_x] call acpl_medic_remove;
		
					_medic = [_x] call ace_medical_fnc_isMedic;
					
					if (_medic) then {
						for "_i" from 1 to acpl_fieldDressing_med do {[_x,"ACE_fieldDressing"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_elasticBandage_med do {[_x,"ACE_elasticBandage"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_adenosine_med do {[_x,"ACE_adenosine"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_atropine_med do {[_x,"ACE_atropine"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_bloodIV_250_med do {[_x,"ACE_bloodIV_250"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_epinephrine_med do {[_x,"ACE_epinephrine"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_morphine_med do {[_x,"ACE_morphine"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_packingBandage_med do {[_x,"ACE_packingBandage"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_personalAidKit_med do {[_x,"ACE_personalAidKit"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_plasmaIV_med do {[_x,"ACE_plasmaIV"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_plasmaIV_250_med do {[_x,"ACE_plasmaIV_250"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_plasmaIV_500_med do {[_x,"ACE_plasmaIV_500"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_salineIV_med do {[_x,"ACE_salineIV"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_salineIV_250_med do {[_x,"ACE_salineIV_250"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_salineIV_500_med do {[_x,"ACE_salineIV_500"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_surgicalKit_med do {[_x,"ACE_surgicalKit"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_tourniquet_med do {[_x,"ace_tourniquet"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_quicklot_med do {[_x,"ACE_quikclot"] remoteExec ["additem",_x];};
					} else {
						for "_i" from 1 to acpl_fieldDressing_sol do {[_x,"ACE_fieldDressing"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_elasticBandage_sol do {[_x,"ACE_elasticBandage"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_adenosine_sol do {[_x,"ACE_adenosine"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_atropine_sol do {[_x,"ACE_atropine"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_epinephrine_sol do {[_x,"ACE_epinephrine"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_morphine_sol do {[_x,"ACE_morphine"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_packingBandage_sol do {[_x,"ACE_packingBandage"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_personalAidKit_sol do {[_x,"ACE_personalAidKit"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_tourniquet_sol do {[_x,"ace_tourniquet"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_plasmaIV_500_sol do {[_x,"ACE_plasmaIV_500"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_salineIV_500_sol do {[_x,"ACE_salineIV_500"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_plasmaIV_250_sol do {[_x,"ACE_plasmaIV_250"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_salineIV_250_sol do {[_x,"ACE_salineIV_250"] remoteExec ["additem",_x];};
						for "_i" from 1 to acpl_quicklot_sol do {[_x,"ACE_quikclot"] remoteExec ["additem",_x];};
					};
					acpl_medical_done = acpl_medical_done + [_x];
					publicvariable "acpl_medical_done";
					if (acpl_loop_slower) then {sleep 0.1;};
				} else {
					if (acpl_medical_AI) then {
						private ["_medic"];
						
						[_x] call acpl_medic_remove;
						
						_medic = [_x] call ace_medical_fnc_isMedic;
						
						if (_medic) then {
							for "_i" from 1 to acpl_fieldDressing_med_AI do {[_x,"ACE_fieldDressing"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_elasticBandage_med_AI do {[_x,"ACE_elasticBandage"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_adenosine_med_AI do {[_x,"ACE_adenosine"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_atropine_med_AI do {[_x,"ACE_atropine"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_bloodIV_250_med_AI do {[_x,"ACE_bloodIV_250"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_epinephrine_med_AI do {[_x,"ACE_epinephrine"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_morphine_med_AI do {[_x,"ACE_morphine"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_packingBandage_med_AI do {[_x,"ACE_packingBandage"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_personalAidKit_med_AI do {[_x,"ACE_personalAidKit"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_plasmaIV_med_AI do {[_x,"ACE_plasmaIV"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_plasmaIV_250_med_AI do {[_x,"ACE_plasmaIV_250"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_plasmaIV_500_med_AI do {[_x,"ACE_plasmaIV_500"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_salineIV_med_AI do {[_x,"ACE_salineIV"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_salineIV_250_med_AI do {[_x,"ACE_salineIV_250"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_salineIV_500_med_AI do {[_x,"ACE_salineIV_500"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_surgicalKit_med_AI do {[_x,"ACE_surgicalKit"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_tourniquet_med_AI do {[_x,"ace_tourniquet"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_quicklot_med_AI do {[_x,"ACE_quikclot"] remoteExec ["additem",_x];};
						} else {
							for "_i" from 1 to acpl_fieldDressing_AI do {[_x,"ACE_fieldDressing"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_elasticBandage_AI do {[_x,"ACE_elasticBandage"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_adenosine_AI do {[_x,"ACE_adenosine"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_atropine_AI do {[_x,"ACE_atropine"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_epinephrine_AI do {[_x,"ACE_epinephrine"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_morphine_AI do {[_x,"ACE_morphine"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_packingBandage_AI do {[_x,"ACE_packingBandage"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_personalAidKit_AI do {[_x,"ACE_personalAidKit"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_tourniquet_AI do {[_x,"ace_tourniquet"] remoteExec ["additem",_x];};
							for "_i" from 1 to acpl_quicklot_AI do {[_x,"ACE_quikclot"] remoteExec ["additem",_x];};
						};
						acpl_medical_done = acpl_medical_done + [_x];
						publicvariable "acpl_medical_done";
						if (acpl_loop_slower) then {sleep 0.1;};
					};
				};
			};
			acpl_unitsdone_1 = acpl_unitsdone_1 + [_x];
		} foreach (allunits - acpl_unitsdone_1);
		
		if (!(acpl_mainloop_done)) then {
			acpl_mainloop_done = true;
			publicvariable "acpl_mainloop_done";
		};
		
		{
		waitUntil {time > 20};
		
			if (_x in acpl_radio_added) then {} else {
			
				[[_x],acpl_add_actions] remoteExec ["call",_x];
				
				_x setvariable ["acpl_radio_lower_sw",false,true];
				_x setvariable ["acpl_radio_volume_sw",100,true];
				_x setvariable ["acpl_radio_lower_lr",false,true];
				_x setvariable ["acpl_radio_volume_lr",100,true];
				_x setVariable ["acpl_radio_asked_sw",false,true];
				_x setVariable ["acpl_radio_asked_lr",false,true];
				_x setVariable ["acpl_radio_asked_sw_class",nil,true];
				_x setVariable ["acpl_radio_asked_lr_class",nil,true];
				_x setVariable ["acpl_radio_asked_sw_target",nil,true];
				_x setVariable ["acpl_radio_asked_lr_target",nil,true];
				_x setVariable ["acpl_radio_asked_sw_owner",nil,true];
				_x setVariable ["acpl_radio_asked_lr_owner",nil,true];
				_x setVariable ["acpl_radio_borrowed_sw",false,true];
				_x setVariable ["acpl_radio_borrowed_lr",false,true];
				_x setVariable ["acpl_radio_settings_sw",nil,true];
				_x setVariable ["acpl_radio_settings_lr",nil,true];
				
				acpl_radio_added = acpl_radio_added + [_x];
				publicvariable "acpl_radio_added";
			};
			if (!(_x in acpl_static_done) AND _static) then {
				
				[[_x],acpl_add_action_static] remoteExec ["call",_x];
				
				acpl_static_done = acpl_static_done + [_x];
				publicvariable "acpl_static_done";
			};
			acpl_unitsdone_2 = acpl_unitsdone_2 + [_x];
		} foreach (allunits - acpl_unitsdone_2);
		{
			if (_x in acpl_dead_added) then {} else {
			
				[[_x, 0, ["ACE_MainActions"], hidebody_act],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",0,true];
			
				acpl_dead_added = acpl_dead_added + [_x];
			};
		} foreach (allDead - acpl_dead_added);
		
		{
			if (acpl_camoscript AND !(_x in allPlayers)) then {
				private ["_tbhf", "_ntbh", "_newCamCoefA", "_newCamCoef", "_stA", "_st", "_stanceresult", "_overcastLevel", "_lightlevelscaled", "_sse", "_sss", "_srs", "_sre", "_p", "_timenow", "_lightlevel", "_sunset", "_sunrise", "_sunriseSunsetTime", "_rainLevelA", "_rainLevel", "_windscaled", "_windstrength", "_camo", "_foglevel"];
					
				if (([_x, acpl_player_distance] call acpl_check_players_inrange) OR !(isPlayer _x) OR !(_x in _playable)) then {
					_ntbh = count nearestterrainobjects [_x,["Tree", "Bush", "Hide"],2.5,false,true];
					//set default tbh factor before if
					_tbhf = 1;
					_ntbh = _ntbh / _tbhf;
						
					_foglevel = linearconversion [0,1,fog,0,0.9,true];
						
					_camo = 0.55;
						
					_windstrength = vectormagnitude wind;
					_windscaled = linearconversion [0,7,_windstrength,0,0.9,true];
						
					_rainLevel = linearconversion [0,1,rain,0,0.8,true];
					_rainLevelA = linearconversion [0,1,rain,0,0.9,true];
						
					_sunriseSunsetTime = date call BIS_fnc_sunriseSunsetTime;
					_sunrise = _sunriseSunsetTime select 0;
					_sunset = _sunriseSunsetTime select 1;
					_lightlevel = 0.5;
						
					_timenow = daytime;
						
					_p = 1;
					_sre = _sunrise +_p;
					_srs = _sunrise -_p;
					_sss = _sunset -_p;
					_sse = _sunset +_p;
						
					if ((_timenow >= 0) && (_timenow <=_srs)) then
							{ _lightlevel = 0; };

					if ((_timenow >= _sse) && (_timenow <=24)) then
							{ _lightlevel = 0; };

					if ((_timenow <= _sse) && (_timenow >=_sre)) then
						   { _lightlevel = 1;};

					if ((_timenow >=_srs) && (_timenow <= _sre)) then
							{_lightlevel = 0.5 *(_timenow-_srs);};

					if ((_timenow >=_sss) && (_timenow <=_sse)) then
							{_lightlevel = -0.5 * (_timenow -(_sse));};
						
					_lightlevelscaled = linearconversion [0,1,_lightlevel,0.05,1];
						
					_overcastLevel = linearconversion [0,1,overcast,0,0.9,true];
						
					_newCamCoef = sqrt (
									  (1-_foglevel) * _camo * (1 - _rainLevel) * _lightLevelscaled * (1 - _overcastLevel) * _tbhf
									  );

					_newCamCoefA = sqrt (
									  (1-_foglevel) * (1 - _rainLevel) * (1 - _overcastLevel) * (1-_windscaled)
									  );
					_newCamCoefScaled = linearconversion [0,1,_newCamCoef,0,1.6,true];
					_newaudibleCoefScaled = linearconversion [0,1,_newCamCoefA,0.05,1.6,true];
					
					[_x,["camouflageCoef", _newcamCoefscaled]] remoteExec ["setUnitTrait",0];
					[_x,["audibleCoef", _newaudibleCoefScaled]] remoteExec ["setUnitTrait",0];
				} else {
					[_x,["camouflageCoef", 1]] remoteExec ["setUnitTrait",0];
					[_x,["audibleCoef", 1]] remoteExec ["setUnitTrait",0];
				};
			};
			if (headgear _x == "") then {
				_x setVariable ["acpl_helmet",false,true];
			};
			if (primaryweapon _x == "") then {
				_x setVariable ["acpl_weapon_fasten",false,true];
			};
		} foreach allunits;
		
		sleep acpl_loop_sleep;
	};
};
publicvariable "acpl_loop";

acpl_weather_loop = {
	acpl_weather_sleep = random [(acpl_weather_changetime select 0), ((acpl_weather_changetime select 1) / acpl_weather_random), (acpl_weather_changetime select 1)];
	acpl_weather_sleep = acpl_weather_sleep * 60;
	
	while {true} do {
		if (acpl_weather_enabled) then {
			private ["_overcast", "_rain", "_fog", "_wind", "_thunder"];
			
			_overcast = random [(acpl_weather_overcast select 0), ((acpl_weather_overcast select 1) / acpl_weather_random), (acpl_weather_overcast select 1)];
			_rain = random [(acpl_weather_rain select 0), ((acpl_weather_rain select 1) / acpl_weather_random), (acpl_weather_rain select 1)];
			_fog = random [(acpl_weather_fog select 0), ((acpl_weather_fog select 1) / acpl_weather_random), (acpl_weather_fog select 1)];
			_thunder = random [(acpl_weather_thunders select 0), ((acpl_weather_thunders select 1) / acpl_weather_random), (acpl_weather_thunders select 1)];
			
			[acpl_weather_sleep,_overcast] remoteExec ["setOvercast",2];
			[acpl_weather_sleep,_rain] remoteExec ["setRain",2];
			[acpl_weather_sleep,_fog] remoteExec ["setFog",2];
			[acpl_weather_sleep,_thunder] remoteExec ["setLightnings",2];
			
			sleep acpl_weather_sleep;
			acpl_weather_sleep = random [(acpl_weather_changetime select 0), ((acpl_weather_changetime select 1) / acpl_weather_random), (acpl_weather_changetime select 1)];
			acpl_weather_sleep = acpl_weather_sleep * 60;
		} else {
			sleep 10;
		};
	}
};
publicvariable "acpl_weather_loop";

acpl_loop_fncs = true;
publicvariable "acpl_loop_fncs";

if (acpl_fnc_debug) then {["ACPL FNCS LOOP LOADED"] remoteExec ["systemchat",0];};