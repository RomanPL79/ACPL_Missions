params ["_unit", "_type"];
private ["_class"];

if (!isserver) exitwith {};

//_nul = [this,0] execVM "acpl_fncs\RYD_arty.sqf";
//v1.0
//0 dla ruchomej arty, 1 dla moüdzierzy, 2 dla rakietowej

if (isNil "acpl_fncs_initied") then {acpl_fncs_initied = false};

waitUntil {acpl_fncs_initied};

_class = typeof _unit;

if (isNil "RydFFE_Add_SPMortar") then {RydFFE_Add_SPMortar = []};
if (isNil "RydFFE_Add_Mortar") then {RydFFE_Add_Mortar = []};
if (isNil "RydFFE_Add_Rocket") then {RydFFE_Add_Rocket = []};

if (_type == 0) then {
	if (!(_class in RydFFE_Add_SPMortar)) then {
		RydFFE_Add_SPMortar = RydFFE_Add_SPMortar + [_class];
	};
};
if (_type == 1) then {
	if (!(_class in RydFFE_Add_Mortar)) then {
		RydFFE_Add_Mortar = RydFFE_Add_Mortar + [_class];
	};
};
if (_type == 2) then {
	if (!(_class in RydFFE_Add_Rocket)) then {
		RydFFE_Add_Rocket = RydFFE_Add_Rocket + [_class];
	};
};