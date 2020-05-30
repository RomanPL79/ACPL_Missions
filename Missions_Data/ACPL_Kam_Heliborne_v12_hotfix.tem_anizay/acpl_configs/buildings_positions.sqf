acpl_building_pos_checkconfig = {
	params ["_class"];
	private ["_return"];
	
	_return = false;
	
	{
		if (_class in _x) then {
			_return = true;
		};
	} foreach acpl_building_pos;
	
	_return
};
publicvariable "acpl_building_pos_checkconfig";

acpl_building_pos_getconfig = {
	params ["_class"];
	private ["_return"];
	
	_return = [];
	
	{
		if (_class in _x) then {
			_return = _x;
		};
	} foreach acpl_building_pos;
	
	_return
};
publicvariable "acpl_building_pos_getconfig";

acpl_building_pos = [];
publicvariable "acpl_building_pos";