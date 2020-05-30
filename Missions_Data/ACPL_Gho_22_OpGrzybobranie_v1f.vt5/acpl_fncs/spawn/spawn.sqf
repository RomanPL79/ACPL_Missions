private ["_side","_inf","_veh","_type","_spawn_point","_c_inf","_c_veh","_grp"];

//[strona,[klasy_piechoty],[klasy_pojazdow],typ,koordynaty] execVM "acpl_fncs\spawn\spawn.sqf";
//v1.0

_side = _this select 0;
_inf = _this select 1;
_veh = _this select 2;
_type = _this select 3;
_spawn_point = _this select 4;

if (!isserver) exitwith {};

_c_inf = count _inf;
_c_veh = count _veh;

_grp = createGroup _side;
acpl_spawn_name = _grp;
publicvariable "acpl_spawn_name";

if (_c_veh > 0) then {
	{
		private ["_v"];
		_v = createVehicle [_x, _spawn_point, [], 20];
		createVehicleCrew _v;
		(crew _v) joinSilent _grp;
	} foreach _veh;
};
sleep 1;
if (_c_inf > 0) then {
	{
		private ["_unit"];
		_unit = _grp createUnit [_x, _spawn_point, [], 20, _type];
	} foreach _inf;
};

_grp