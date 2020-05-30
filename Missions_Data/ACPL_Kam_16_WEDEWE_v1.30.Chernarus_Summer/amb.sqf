if (!isServer) exitWith {};
sleep 5;
UH80 setCollisionLight true;
UH80 engineON false;
UH80 setFuel 0;
sleep 2;

_mission = selectRandom [2,3];


switch (_mission) do {

    case 2: {
	{deleteVehicle _x} forEach nearestObjects [Jammer3, ["all"], 50];
	
	deleteVehicle Jammer3;
	};

   case 3: {

	{deleteVehicle _x} forEach nearestObjects [Jammer2, ["all"], 50];
	deleteVehicle Jammer2;
	
	};
    default { hint "error" };
};















UH80D moveInAny UH80;
UH80D_1 moveInAny UH80;
UH80D_2 moveInAny UH80;

while{alive banan} do {
soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString; 
soundToPlay = soundPath + "music\apu.ogg";
playSound3D [soundToPlay, UH80, false, getPosASL UH80, 10, 1, 500]; 
sleep 63;
};
       