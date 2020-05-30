acpl_civ_notindangerzone = {
	params ["_pos"];
	private ["_return"];
	
	_return = true;
	
	{
		if ((_pos distance _x) < acpl_civs_shootingdanger) then {
			_return = false;
		};
	} foreach acpl_civilian_shootingpos;
	
	_return
};
publicvariable "acpl_civ_notindangerzone";

acpl_civ_civilian_shootingpos_check = {
	params ["_pos"];
	private ["_return"];
	
	_return = false;
	
	{
		if (_x distance _pos < 5) then {
			_return = true;
		};
	} foreach acpl_civilian_shootingpos;
	
	_return
};
publicvariable "acpl_civ_civilian_shootingpos_check";

acpl_civ_civilian_shootingpos_manage = {
	params ["_data"];
	
	sleep acpl_civs_shootingtime;
	
	acpl_civilian_shootingpos = acpl_civilian_shootingpos - [_data];
};
publicvariable "acpl_civ_civilian_shootingpos_manage";

acpl_civ_nearesthouse_from = {
	params ["_list", "_pos"];
	private ["_return", "_ap", "_distance", "_p"];
	
	_return = [];
	
	_distance = 100000;
	
	{
		_p = [_x] call BIS_fnc_buildingPositions;
		_ap = [_p] call acpl_check_takenpositions;
		
		if (((_pos distance _x) < _distance) AND !(count _ap == 0)) then {
			_return = _x;
			_distance = _pos distance _x;
		};
	} foreach _list;
	
	_return;
};
publicvariable "acpl_civ_nearesthouse_from";

acpl_civ_findcover = {
	params ["_unit"];
	private ["_pos", "_checked_buildings", "_positions", "_houseList", "_randomHouse", "_coverobj", "_nearestcoppos", "_available_positions", "_town", "_towncenter", "_list"];
	
	_town = _unit getvariable "acpl_civilian_town";
	
	_checked_buildings = [];
	_houseList = _town select 2;
	_towncenter = _town select 0;
	
	{
		if ((count ([_x] call BIS_fnc_buildingPositions)) != 0) then {
			if ([(getpos _x)] call acpl_civ_notindangerzone) then {
				_checked_buildings = _checked_buildings + [_x];
			};
		};
	} foreach _houseList;

	if ((count _checked_buildings) > 0) then {
		
		_randomHouse = [_checked_buildings, (getpos _unit)] call acpl_civ_nearesthouse_from;
		
		_positions = [_randomHouse] call BIS_fnc_buildingPositions;
		
		_available_positions = [_positions] call acpl_check_takenpositions;
		
		if (count _available_positions == 0) then {
			while {count _available_positions == 0} do {
				_randomHouse = [_checked_buildings, (getpos _unit)] call acpl_civ_nearesthouse_from;
		
				_positions = [_randomHouse] call BIS_fnc_buildingPositions;
				
				_available_positions = [_positions] call acpl_check_takenpositions;
			};
		};
		
		_pos = _available_positions select floor(random(count _available_positions));
		
		_unit setvariable ["acpl_civilian_panicking_inside", true, true];
		
		acpl_buildings_takenpos = acpl_buildings_takenpos + [_pos];
	} else {
		_list = [];
		
		{
			_list = _list + [[_x, acpl_civs_shootingdanger]];
		} foreach acpl_civilian_shootingpos;
		
		_pos = [_towncenter, 1, acpl_civs_locationradius, 3, 0, 20, 0, _list] call BIS_fnc_findSafePos;
		_unit setvariable ["acpl_civilian_panicking_inside", false, true];
	};
	
	if (isNil "_pos") then {
		_list = [];
		
		{
			_list = _list + [[_x, acpl_civs_shootingdanger]];
		} foreach acpl_civilian_shootingpos;
		
		_pos = [_towncenter, 1, acpl_civs_locationradius, 3, 0, 20, 0, _list] call BIS_fnc_findSafePos;
		_unit setvariable ["acpl_civilian_panicking_inside", false, true];
	};
	
	_pos
};
publicvariable "acpl_civ_findcover";

acpl_civ_hide = {
	params ["_unit", "_distance", "_gunner"];
	private ["_time", "_do", "_time_wait", "_pos_gunner"];
	
	_pos_gunner = getpos _gunner;
	
	if (!(_pos_gunner in acpl_civilian_shootingpos)) then {
		acpl_civilian_shootingpos = acpl_civilian_shootingpos + [_pos_gunner];
		[_pos_gunner] spawn acpl_civ_civilian_shootingpos_manage;
	};
	
	_unit setvariable ["acpl_civilian_panicking",true,true];
	_unit setvariable ["acpl_civilian_panicking_time",time,true];
	_unit setvariable ["acpl_moveto_completed", true, true];
	
	if (_distance < 20) then {
		_unit DisableAI "PATH";
		_unit setunitpos "DOWN";
		
		sleep (5 + (random 25));
		
		_unit setunitpos "UP";
		_unit EnableAI "PATH";
	};
	
	_pos = [_unit] call acpl_civ_findcover;
	
	[_unit, _pos] spawn acpl_moveto;
	_unit setSpeedMode "FULL";
	_unit forceWalk false;
	
	sleep acpl_loop_sleep;
	_unit setunitpos "AUTO";
	
	[_unit,"ApanPercMstpSnonWnonDnon_G01"] remoteExec ["switchmove", 0, true];
	
	_time = random acpl_civs_hidetime;
	
	_unit setunitpos "AUTO";
	_unit setBehaviour "STEALTH";
	
	waitUntil {sleep 1;_unit getvariable "acpl_moveto_completed"};
	
	[_unit,"AmovPercMstpSnonWnonDnon"] remoteExec ["switchmove", 0, true];
	
	_unit disableAI "PATH";
	
	_unit setunitpos "MIDDLE";
	
	_do = true;
	
	while {_do} do {
		_time_wait = ((_unit getvariable "acpl_civilian_panicking_time") + _time);
		
		if (time > _time_wait) then {_do = false;};
		
		sleep acpl_loop_sleep;
	};
	
	_unit setBehaviour "CARELESS";
	_unit setunitpos "UP";
	_unit setSpeedMode "NORMAL";
	
	_unit EnableAI "PATH";
	
	[_unit,"PlayerStand"] remoteExec ["playAction",0];
	
	_unit forceWalk true;
	
	_unit setvariable ["acpl_civilian_panicking",false,true];
	
	if (_unit getvariable "acpl_civilian_panicking_inside") then {acpl_buildings_takenpos = acpl_buildings_takenpos - [_pos];};
};
publicvariable "acpl_civ_hide";

acpl_civ_simulation = {
	params ["_civ"];
	private ["_veh", "_vehs_checked", "_vehs", "_buildings_full", "_nobuildings", "_check_positions", "_town", "_group", "_name", "_townpos", "_buildings", "_building", "_stay", "_tochoosefrom", "_random"];
	
	_civ setvariable ["acpl_civilian_simulated", true, true];
	
	if (isNil "acpl_mainloop_done") then {acpl_mainloop_done = false};

	waitUntil {acpl_mainloop_done};
	
	_nobuildings = false;
	_buildings_full = false;
	
	_group = group _civ;
	if (count (units _group) > 1) then {
		_group = createGroup [civilian, false];
		[_civ] join _group;
		_group deleteGroupWhenEmpty true;
	};
	
	_town = [getpos _civ] call acpl_civ_closesttown;
	
	_townpos = _town select 0;
	_name = _town select 1;
	_buildings = _town select 2;
	
	if ((count _buildings) == 0) then {
		_nobuildings = true;
	} else {
		if ((count (_buildings - acpl_civs_buildings)) == 0) then {
			_buildings_full = true;
		};
	};
	
	_civ setvariable ["acpl_civilian_town", _town, true];
	
	_vehs = nearestObjects [_townpos, acpl_civ_cars, acpl_civs_locationradius];
	_vehs_checked = [];
	
	{
		if (((count (crew _x)) == 0) AND !(_x in acpl_civilian_car)) then {
			_vehs_checked = _vehs_checked + [_x];
		};
	} foreach _vehs;
	
	if ((count _vehs_checked) == 0) then {} else {
	
		_veh = _vehs_checked select floor(random(count _vehs_checked));
		
		acpl_civilian_car = acpl_civilian_car + [_veh];
		
		_civ setvariable ["acpl_civilian_car", _veh, true];
		
		[_veh,"LOCKED"] remoteExec ["setVehicleLock",0,true];
	
	};
	
	if (_nobuildings) then {
		_civ setvariable ["acpl_civilian_home", [], true];
		_stay = false;
	} else {
	
		if (_buildings_full) then {
			_tochoosefrom = _buildings;
		} else {
			_tochoosefrom = _buildings - acpl_civs_buildings;
		};
		_building = _tochoosefrom select floor(random(count _tochoosefrom));
		acpl_civs_buildings = acpl_civs_buildings + [_building];
		
		_check_positions = [_building] call BIS_fnc_buildingPositions;
		
		while {count _check_positions == 0} do {
			_building = (_buildings - [_building]) select floor(random(count (_buildings - [_building])));
			
			_check_positions = [_building] call BIS_fnc_buildingPositions;
			
			acpl_civs_buildings = acpl_civs_buildings + [_building];
			
			sleep 1;
		};
		
		_civ setvariable ["acpl_civilian_home", _building, true];
		
		_random = random 100;
		if (_random > acpl_civs_stayinhome) then {
			_stay = false;
		} else {
			_stay = true;
		};
		
	};
	
	_civ forceWalk true;
	_civ setBehaviour "CARELESS";
	_civ setunitpos "UP";
	_civ DisableAI "AUTOCOMBAT";
	
	sleep 5;
	
	while {alive _civ} do {
		if (!(_civ getvariable "acpl_civilian_panicking")) then {
			_civ forceWalk true;
			_civ setBehaviour "CARELESS";
			_civ setunitpos "UP";
			
			if (_stay) then {
				private ["_positions", "_available_positions", "_chosen", "_sleep"];
				
				_positions = [_building] call BIS_fnc_buildingPositions;
				
				_available_positions = _positions - acpl_buildings_takenpos;
				_available_positions = [_available_positions] call acpl_check_takenpositions;
				_chosen = _available_positions select floor(random(count _available_positions));
				
				acpl_buildings_takenpos = acpl_buildings_takenpos + [_chosen];
				
				sleep 0.1;
				
				[_civ, _chosen] spawn acpl_moveto;
				
				waitUntil {sleep acpl_loop_sleep;_civ getvariable "acpl_moveto_completed"};
				
				_sleep = random acpl_civs_stayinhome_sleep;
				sleep _sleep;
				
				acpl_buildings_takenpos = acpl_buildings_takenpos - [_chosen];
			} else {
				private ["_citynobuildings", "_random", "_city", "_citypos", "_cityname", "_citybuildings", "_bul", "_pos", "_sleep", "_available_positions", "_positions"];
				
				_city = [_town] call acpl_civ_citynearby;
						
				_citypos = _city select 0;
				_cityname = _city select 1;
				_citybuildings = _city select 2;
				
				_citynobuildings = false;
				
				if ((count _citybuildings) == 0) then {
					_citynobuildings = true;
				};
				
				_random = random 100;
				if (_random < acpl_civs_changecity) then {			//idzie do innego miasta
						
					_random = random 100;
					if ((_random < 50) OR _citynobuildings) then {						//chodzi po mieście	
						
						if (_citynobuildings) then {
						
							_pos = [_citypos, 1, acpl_civs_locationradius, 3, 0, 20, 0] call BIS_fnc_findSafePos;
							
						} else {
						
							_bul = _citybuildings select floor(random(count _citybuildings));
							
							_pos = [(getpos _bul), 1, 30, 3, 0, 20, 0] call BIS_fnc_findSafePos;
						
						};
								
						[_civ, _pos] spawn acpl_moveto;
						
						waitUntil {sleep acpl_loop_sleep;_civ getvariable "acpl_moveto_completed"};
								
						_sleep = random acpl_civs_wait;
						sleep _sleep;
					} else {										//idzie do czyjegoś domu
						_bul = _citybuildings select floor(random(count _citybuildings));
							
						_positions = [_bul] call BIS_fnc_buildingPositions;
								
						while {count _positions == 0} do {
							_bul = (_citybuildings - [_bul]) select floor(random(count (_citybuildings - [_bul])));
									
							_positions = [_bul] call BIS_fnc_buildingPositions;
							sleep 1;
						};
								
						_available_positions = _positions - acpl_buildings_takenpos;
						_available_positions = [_available_positions] call acpl_check_takenpositions;
						_pos = _available_positions select floor(random(count _available_positions));
									
						acpl_buildings_takenpos = acpl_buildings_takenpos + [_pos];
									
						[_civ, _pos] spawn acpl_moveto;
						
						waitUntil {sleep acpl_loop_sleep;_civ getvariable "acpl_moveto_completed"};
								
						_sleep = random acpl_civs_wait;
						sleep _sleep;
									
						acpl_buildings_takenpos = acpl_buildings_takenpos - [_pos];
					};
				} else {
					private ["_bul", "_pos", "_sleep", "_available_positions", "_positions"];
							
					_random = random 100;
					if ((_random < 50) OR _nobuildings) then {						//chodzi po mieście
						if (_nobuildings) then {
							_pos = [_townpos, 1, acpl_civs_locationradius, 3, 0, 20, 0] call BIS_fnc_findSafePos;
						} else {
							
							_bul = _buildings select floor(random(count _buildings));
								
							_pos = [(getpos _bul), 1, 30, 3, 0, 20, 0] call BIS_fnc_findSafePos;
							
						};
							
						[_civ, _pos] spawn acpl_moveto;
						
						waitUntil {sleep acpl_loop_sleep;_civ getvariable "acpl_moveto_completed"};
								
						_sleep = random acpl_civs_wait;
						sleep _sleep;
					} else {
						if (_random < 75) then {					//idzie do czyjegoś domu
							_bul = (_buildings - [_building]) select floor(random(count (_buildings - [_building])));
									
							_positions = [_bul] call BIS_fnc_buildingPositions;
									
							while {count _positions == 0} do {
								_bul = (_buildings - [_building]) select floor(random(count (_buildings - [_building])));
									
								_positions = [_bul] call BIS_fnc_buildingPositions;
								sleep 1;
							};
								
							_available_positions = _positions - acpl_buildings_takenpos;
							_available_positions = [_available_positions] call acpl_check_takenpositions;
							_pos = _available_positions select floor(random(count _available_positions));
										
							acpl_buildings_takenpos = acpl_buildings_takenpos + [_pos];
								
							[_civ, _pos] spawn acpl_moveto;
							
							waitUntil {sleep acpl_loop_sleep;_civ getvariable "acpl_moveto_completed"};
									
							_sleep = random acpl_civs_wait;
							sleep _sleep;
									
							acpl_buildings_takenpos = acpl_buildings_takenpos - [_pos];
						} else {									//idzie do swojego domu
							_available_positions = _check_positions - acpl_buildings_takenpos;
							_available_positions = [_available_positions] call acpl_check_takenpositions;
							_pos = _available_positions select floor(random(count _available_positions));
									
							acpl_buildings_takenpos = acpl_buildings_takenpos + [_pos];
								
							[_civ, _pos] spawn acpl_moveto;
						
							waitUntil {sleep acpl_loop_sleep;_civ getvariable "acpl_moveto_completed"};
								
							_sleep = random acpl_civs_wait;
							sleep _sleep;
								
							acpl_buildings_takenpos = acpl_buildings_takenpos - [_pos];
						};
					};
				};
				
				sleep acpl_loop_sleep;
			};
		} else {
			sleep acpl_loop_sleep;
		};
	};
};
publicvariable "acpl_civ_simulation";

acpl_civ_citynearby = {
	params ["_town"];
	private ["_return", "_distance", "_pos"];
	
	_return = [];
	_distance = 100000;
	
	_pos = _town select 0;
	
	{
		if (_distance > (_pos distance (_x select 0))) then {
			_distance = (_pos distance (_x select 0));
			_return = _x;
		};
	} foreach acpl_cities - [_town];
	
	_return
};
publicvariable "acpl_civ_citynearby";

acpl_civ_closesttown = {
	params ["_pos"];
	private ["_return", "_distance"];
	
	_return = [];
	_distance = 100000;
	
	{
		if (_distance > (_pos distance (_x select 0))) then {
			_distance = (_pos distance (_x select 0));
			_return = _x;
		};
	} foreach acpl_cities;
	
	_return;
};
publicvariable "acpl_civ_closesttown";