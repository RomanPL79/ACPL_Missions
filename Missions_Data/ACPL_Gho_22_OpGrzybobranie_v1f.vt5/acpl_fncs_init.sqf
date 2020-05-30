private ["_type","_vcom","_mc","_static","_playable","_action","_meds_AI"];

//Podstawowe skrypty ACPL
//v1.0b

_type = _this select 0;
_mc = _this select 1;
_vcom = _this select 2;
_static = _this select 3;

[1600] remoteExec ["setViewDistance",0];

_meds_AI = true; //Zmiana ilości medykamentów dla jednotek AI

if (!isserver) exitwith {};

_playable = playableUnits + switchableUnits + allPlayers;

//Ustawienia medykamentów
//Dla zwykłego żołdaka grywalnego
acpl_fieldDressing_sol = 5;
acpl_elasticBandage_sol = 2;
acpl_adenosine_sol = 0;
acpl_atropine_sol = 0;
acpl_epinephrine_sol = 0;
acpl_morphine_sol = 1;
acpl_packingBandage_sol = 2;
acpl_personalAidKit_sol = 0;
acpl_tourniquet_sol = 1;

//Dla medyka
acpl_fieldDressing_med = 10;
acpl_elasticBandage_med = 30;
acpl_adenosine_med = 6;
acpl_atropine_med = 6;
acpl_epinephrine_med = 30;
acpl_morphine_med = 30;
acpl_packingBandage_med = 20;
acpl_personalAidKit_med = 0;
acpl_plasmaIV_med = 0;
acpl_plasmaIV_250_med = 3;
acpl_plasmaIV_500_med = 0;
acpl_salineIV_med = 0;
acpl_salineIV_250_med = 4;
acpl_salineIV_500_med = 0;
acpl_tourniquet_med = 6;
acpl_surgicalKit_med = 0;
acpl_bloodIV_250_med = 2;

//Dla zwykłego żołdaka, AI
acpl_fieldDressing_AI = 5;
acpl_elasticBandage_AI = 2;
acpl_adenosine_AI = 0;
acpl_atropine_AI = 0;
acpl_epinephrine_AI = 0;
acpl_morphine_AI = 1;
acpl_packingBandage_AI = 2;
acpl_personalAidKit_AI = 0;
acpl_tourniquet_AI = 1;

//Dla centrum medycznego
acpl_fieldDressing_veh = 50;
acpl_elasticBandage_veh = 50;
acpl_adenosine_veh = 50;
acpl_atropine_veh = 50;
acpl_bloodIV_veh = 10;
acpl_bodyBag_veh = 10;
acpl_epinephrine_veh = 50;
acpl_morphine_veh = 50;
acpl_packingBandage_veh = 50;
acpl_plasmaIV_veh = 10;
acpl_salineIV_veh = 10;
acpl_surgicalKit_veh = 10;
acpl_tourniquet_veh = 50;

if (_type == 1) then {
	acpl_WZ28_Enabled = false; //włącza możliwość przeładowania dla polskiej wersji BAR'a (na 7,92), tylko WW2
};

{publicvariable _x;} foreach ["acpl_fieldDressing_sol","acpl_elasticBandage_sol","acpl_adenosine_sol","acpl_atropine_sol","acpl_epinephrine_sol","acpl_morphine_sol","acpl_packingBandage_sol","acpl_personalAidKit_sol","acpl_tourniquet_sol"];
{publicvariable _x;} foreach ["acpl_fieldDressing_AI","acpl_elasticBandage_AI","acpl_adenosine_AI","acpl_atropine_AI","acpl_epinephrine_AI","acpl_morphine_AI","acpl_packingBandage_AI","acpl_personalAidKit_AI","acpl_tourniquet_AI"];
{publicvariable _x;} foreach ["acpl_bloodIV_250_med","acpl_surgicalKit_med","acpl_tourniquet_med","acpl_salineIV_500_med","acpl_salineIV_250_med","acpl_salineIV_med","acpl_plasmaIV_500_med","acpl_plasmaIV_250_med","acpl_plasmaIV_med","acpl_fieldDressing_med","acpl_elasticBandage_med","acpl_adenosine_med","acpl_atropine_med","acpl_epinephrine_med","acpl_morphine_med","acpl_packingBandage_med","acpl_personalAidKit_med"];
{publicvariable _x;} foreach ["acpl_tourniquet_veh","acpl_surgicalKit_veh","acpl_salineIV_veh","acpl_plasmaIV_veh","acpl_packingBandage_veh","acpl_morphine_veh","acpl_epinephrine_veh","acpl_bodyBag_veh","acpl_bloodIV_veh","acpl_atropine_veh","acpl_adenosine_veh","acpl_elasticBandage_veh","acpl_fieldDressing_veh"];

if (_type == 0) then {
};

if (_type == 1) then {
	_nul = execVM "acpl_fncs\IF44\acpl_repack_init.sqf";
};

[] execVM "acpl_fncs\acpl_animations\acpl_animations_init.sqf";
[_mc,_meds_AI] execVM "acpl_fncs\acpl_addmeds.sqf";

[] execVM "acpl_fncs\acpl_msc\main.sqf";
if (_vcom) then {
	[] execVM "Vcom\VcomInit.sqf";
	
	//USTAWIENIA VCOMAI ZNAJDUJĄ SIĘ W "Vcom\Functions\VCM_CBASettings.sqf"
};

{
	(group _x) setVariable ["VCM_DisableForm",true,true];
	(group _x) setVariable ["VCM_TOUGHSQUAD",true,true];
	(group _x) setVariable ["VCM_NORESCUE",true,true];
	(group _x) setVariable ["VCM_NOFLANK",true,true];
} foreach _playable;

if (_static) then {
	{[_x,"move"] remoteExec ["disableAI",0];} foreach _playable;
	
	_action = ["acpl_ai_action", "Odblokuj możliwość chodzenia AI w grupie", "", {{[_x,"move"] remoteExec ["enableAI",0];} foreach (units (group _player));hint "Odblokowałeś AI w swojej grupie";}, {_player == leader (group _player)}] call ace_interact_menu_fnc_createAction;
	{[[(_x), 1, ["ACE_SelfActions"], _action],ace_interact_menu_fnc_addActionToObject] remoteExec ["call"];} foreach allunits;
};