private ["_check_wounded"];

_check_wounded_radius = {
	params ["_group"];
	private ["_return", "_distance"];
	
	_distance = acpl_medicalhelp_distance;
	
};

while {true} do {
	private ["_sleep", "_fps", "_slower"];
	
	_slower = false;
	
	_fps = diag_fps;
	if (_fps > 60) then {_sleep = 1;};
	if (_fps < 30) then {_sleep = 5;};
	if (_fps < 15) then {_sleep = 10;_slower = true;};
	
	{
		
	} foreach allgroups;
	sleep _sleep;
};