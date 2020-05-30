private ["_grp","_waypoints"];

_grp = _this select 0;
_waypoints = _this select 1;

//v1.0

if (!isserver) exitwith {};

{
	private ["_pos","_complete","_type","_formation","_behaviour","_combatmode","_speed","_wp"];
	
	_pos = _x select 0;
	_complete = _x select 1;
	_type = _x select 2;
	_formation = _x select 3;
	_behaviour = _x select 4;
	_combatmode = _x select 5;
	_speed = _x select 6;
	
	_wp = _grp addWaypoint [_pos, 0];
	_wp setWaypointCompletionRadius _complete;
	_wp setWaypointType _type;
	_wp setWaypointFormation _formation;
	_wp setWaypointBehaviour _behaviour;
	_wp setWaypointCombatMode _combatmode;
	_wp setWaypointSpeed _speed;
} foreach _waypoints;