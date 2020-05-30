if (!isServer) exitWith {};
_flarePos = [Jammer2, random 30, random 360] call BIS_fnc_relPos;
_flare = createVehicle ["F_20mm_Red", _flarePos, [], 0, "NONE"];
_flare setPosATL [getPosATL _flare select 0, getPosATL _flare select 1, 150 + (random 75)];
_flare setVelocity [0,0,-0.1];
deleteVehicle Jammer2;
