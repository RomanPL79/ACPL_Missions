if (!isServer) exitWith {};

//_firingdata = <fdata> ; 



UH80 setFuel 1;
UH80 engineON true;
banan setDamage 1;


_sequence = [UH80, _movementdata] spawn BIS_fnc_UnitPlay;
//[VehicleName, _firingdata] spawn BIS_fnc_UnitPlayFiring;
waitUntil {scriptDone _sequence};
deleteVehicle UH80;
deleteVehicle UH80D;