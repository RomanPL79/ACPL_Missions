acpl_civ_findcover = {
	params ["_unit"];
	private ["_pos", "_emptyHouse", "_positions", "_houseList", "_randomHouse", "_coverobj", "_nearestcoppos"];
	
	_emptyHouse = [];
	_houseList = nearestObjects [_unit, ["house", "Building"], acpl_civs_hidedistance];

	if ((count _houseList) < 0) then {
		_randomHouse = _houseList select (floor (random (count _houseList)));
		_positions = [_randomHouse] call BIS_fnc_buildingPositions;
		_pos = _positions select floor(random(count _positions));
	} else { 	
		_pos = [_unit, 1, acpl_civs_hidedistance, 3, 0, 20, 0] call BIS_fnc_findSafePos;
	};
	
	_pos
};
publicvariable "acpl_civ_findcover";

acpl_civ_hide = {
	params ["_unit"];
	private ["_time"];
	
	_time = time + (random acpl_civs_hidetime);
	_pos = [_unit] call acpl_civ_findcover;
	
	[_unit, _pos] spawn acpl_moveto;
	
	waitUntil {sleep 1;_unit getvariable "acpl_moveto_completed"};
	
	dostop _unit;
	
	sleep _time;
	
	
};
publicvariable "acpl_civ_hide";

acpl_civ_simulation = {
	params ["_civ", "_distance"];
	
};
publicvariable "acpl_civ_simulation";