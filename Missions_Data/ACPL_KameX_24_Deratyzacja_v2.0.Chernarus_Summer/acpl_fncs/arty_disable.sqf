params ["_group"];

if (!isserver) exitwith {};

//_nul = [(group this)] execVM "acpl_fncs\arty_disable.sqf";


waitUntil {!(isNil "RydFFE_NoControl")};

RydFFE_NoControl = RydFFE_NoControl + [_group];