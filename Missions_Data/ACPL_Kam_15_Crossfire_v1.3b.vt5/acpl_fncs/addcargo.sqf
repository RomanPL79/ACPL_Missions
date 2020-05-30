private ["_box","_list_w","_list_m","_list_i"];

_box = _this select 0;
_list_w = _this select 1;
_list_m = _this select 2;
_list_i = _this select 3;

if (!isserver) exitwith {};

//_nul = [_box,[[weapon_class,count],[weapon_class,count]],[[magazine_class,count],[magazine_class,count]],[[item_class,count],[item_class,count]]] execVM "acpl_fncs\addcargo.sqf";
//v1.0

clearItemCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;

{
	private ["_x0","_x1"];
	_x0 = _x select 0;
	_x1 = _x select 1;
	
	_box addWeaponCargoGlobal [_x0, _x1];
} foreach _list_w;

{
	private ["_x0","_x1"];
	_x0 = _x select 0;
	_x1 = _x select 1;
	
	_box addMagazineCargoGlobal [_x0, _x1];
} foreach _list_m;

{
	private ["_x0","_x1"];
	_x0 = _x select 0;
	_x1 = _x select 1;
	
	_box addItemCargoGlobal [_x0, _x1];
} foreach _list_i;