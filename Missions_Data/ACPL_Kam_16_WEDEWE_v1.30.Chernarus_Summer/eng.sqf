if (!isServer) exitWith {};



soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString; 
soundToPlay = soundPath + "music\eng.ogg";
playSound3D [soundToPlay, UH80, false, getPosASL UH80, 3, 1, 300]; 
sleep 30;
UH80 engineOn true;
       