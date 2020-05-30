
if (!isServer)  exitwith {}; 
uh4 engineOn true;

//_firingdata = <fdata> ; 

_sequence = [uh4, _movementdata] spawn BIS_fnc_UnitPlay;

sleep 60;
waitUntil {isTouchingGround uh1};
sleep 2;
_excluded = [z1,z2,z3,z4,uh1D,uh2D,uh3D,uh4D];
_crew = crew uh4 - _excluded;
{
moveOut _x;
} forEach _crew;


waitUntil {scriptDone _sequence};


uh4 engineOn false;
deleteVehicle uh4;
deleteVehicle uh4D;
deleteVehicle z1;
deleteVehicle z2;
deleteVehicle z3;
deleteVehicle z4;