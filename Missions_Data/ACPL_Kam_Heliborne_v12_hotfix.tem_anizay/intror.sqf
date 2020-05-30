if ((!isServer) && (player != player)) then {waitUntil {player == player};};


nul = [0] execVM "AL_intro\intro.sqf";


if (!isServer)  exitwith {}; 
sleep 45;
_rtx1 = [] spawn desant1; 
_rtx2 = [] spawn desant2; 
_rtx3 = [] spawn desant3; 
_rtx4 = [] spawn desant4;
