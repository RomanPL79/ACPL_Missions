if (!isServer)  exitwith {}; 
uh3 engineOn true;


//_firingdata = <fdata> ; 

_sequence = [uh3, _movementdata] spawn BIS_fnc_UnitPlay;

sleep 60;
waitUntil {isTouchingGround uh1};
sleep 2;
_excluded = [z1,z2,z3,z4,uh1D,uh2D,uh3D,uh4D];
_crew = crew uh3 - _excluded;
{
moveOut _x;
} forEach _crew;


waitUntil {scriptDone _sequence};
//hint "Playback finished";

uh3 engineOn false;
deleteVehicle uh3;
deleteVehicle uh3D;