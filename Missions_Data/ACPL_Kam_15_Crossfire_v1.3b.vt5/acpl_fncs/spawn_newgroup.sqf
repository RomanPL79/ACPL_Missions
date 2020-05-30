private ["_marker","_side","_units","_vehicles","_spawnpoint","_group"];

_marker = _this select 0;
_side = _this select 1;
_units = _this select 2;
_vehicles = _this select 3;

//_nul = ["markername",independent,["classname","classname"],[["vehclasname","crewclassname",3]]] execVM "acpl_fncs\spawn_newgroup.sqf";
//v1.0

if (!isserver) exitwith {};

_spawnpoint = getmarkerpos _marker;
_group = createGroup _side;

if ((isNil "_units") OR (count _units == 0)) then {} else {
	{
		private ["_unit"];
		_unit = _group createUnit [_x, _spawnpoint, [], 0, "FORM"];
		_unit allowdamage false;
		sleep 0.5;
	} foreach _units;
};
if ((isNil "_vehicles") OR (count _vehicles == 0)) then {} else {
	{
		private ["_veh"];
		_veh = (_x select 0) createVehicle [(_spawnpoint select 0) + random 10,(_spawnpoint select 1) + random 10];
		sleep 1;
		if ((_x select 2) == 3) then {
			private ["_com"];
			_com = _group createUnit [(_x select 1), _spawnpoint, [], 0, "NONE"];
			_com moveInCommander _veh;
			_com allowdamage false;
		};
		if ((_x select 2) >= 2) then {
			private ["_gun"];
			_gun = _group createUnit [(_x select 1), _spawnpoint, [], 0, "NONE"];
			_gun moveingunner _veh;
			_gun allowdamage false;
		};
		private ["_driv"];
		_driv = _group createUnit [(_x select 1), _spawnpoint, [], 0, "NONE"];
		_driv moveindriver _veh;
		_driv allowdamage false;
		sleep 0.5;
	} foreach _vehicles;
};
_group deleteGroupWhenEmpty true;
{_x allowdamage true} foreach (units _group);

_group;