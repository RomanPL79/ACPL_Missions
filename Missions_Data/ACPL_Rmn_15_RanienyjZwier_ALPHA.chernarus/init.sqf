private ["_type", "_mc", "_betterAI", "_static", "_medical_ex", "_ied_system", "_safestart", "_text", "_hetman", "_viewdistance"];

_type = 0;								//typ teatru 														(0 -> modern, 1 -> WW2)
_mc = [];								//nazwy centr medycznych 											([nazwa1,nazwa2])
_betterAI = true;						//czy u�ywa� lepszego AI? 											(true/false)
_static = true;							//czy zatrzyma� grywalne AI na pocz�tku misji? 						(true/false)
_medical_ex = [];						//jednostki kt�rym nie ma dodawa� automatycznie medykament�w 		([jednostka1,jednostka2])
_ied_system = false;					//czy w��czy� zaawansowany system IED? 								(true/false)
_safestart = false;						//czy w�aczy� system safestart? 									(true/false)
_text = "Operation in progress";	 //text wy�wietlany przy starcie misji ("Wy�wietlany text")
_hetman = false;						//czy uruchomi� HAL (naczelny dow�dca AI)							(true/false)
_viewdistance = 1600;					//viewdistance

if (isserver) then {
[[_type,_mc,_betterAI,_static,_medical_ex,_ied_system,_safestart,_text,_hetman,_viewdistance],"acpl_fncs_init.sqf"] remoteExec ["execVM",2];
};

