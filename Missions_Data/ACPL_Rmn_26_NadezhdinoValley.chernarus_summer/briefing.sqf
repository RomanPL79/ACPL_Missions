params ["_text"];

[["","BLACK IN", 7]] remoteExec ["titleCut",0];

if (isDedicated) then {
	{[[_text, str(date select 2) + "." + str(date select 1) + "." + str(date select 0), str(name _x)],BIS_fnc_infoText] remoteExec ["spawn",_x,true];} foreach allPlayers;
} else {
	[[_text, str(date select 2) + "." + str(date select 1) + "." + str(date select 0), str(name player)],BIS_fnc_infoText] remoteExec ["spawn",0,true];
};