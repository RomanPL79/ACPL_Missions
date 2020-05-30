private ["_type", "_mc", "_betterAI", "_static", "_medical_ex", "_ied_system", "_safestart", "_text", "_hetman", "_viewdistance"];

_type = 0;								//typ teatru 														(0 -> modern, 1 -> WW2)
_mc = [];								//nazwy centr medycznych 											([nazwa1,nazwa2])
_betterAI = true;						//czy u¿ywaæ lepszego AI? 											(true/false)
_static = true;							//czy zatrzymaæ grywalne AI na pocz¹tku misji? 						(true/false)
_medical_ex = [];						//jednostki którym nie ma dodawaæ automatycznie medykamentów 		([jednostka1,jednostka2])
_ied_system = false;					//czy w³¹czyæ zaawansowany system IED? 								(true/false)
_safestart = false;						//czy w³aczyæ system safestart? 									(true/false)
_text = "FOB WASHINGTON";	 //text wyœwietlany przy starcie misji ("Wyœwietlany text")
_hetman = false;						//czy uruchomiæ HAL (naczelny dowódca AI)							(true/false)
_viewdistance = 1600;					//viewdistance

if (isserver) then {
[[_type,_mc,_betterAI,_static,_medical_ex,_ied_system,_safestart,_text,_hetman,_viewdistance],"acpl_fncs_init.sqf"] remoteExec ["execVM",2];
};

nul = [0] execVM "explosion.sqf";



desant1 = compile preprocessFileLineNumbers "uh1start.sqf";
desant2 = compile preprocessFileLineNumbers "uh2start.sqf";
desant3 = compile preprocessFileLineNumbers "uh3start.sqf";
desant4 = compile preprocessFileLineNumbers "uh4start.sqf";

PPeffect_colorC = ppEffectCreate ["ColorCorrections",1500];
PPeffect_colorC ppEffectAdjust [1,0.997219,0.00178254,[0.1,0.2,0.3,-0.354724],[1,1,1,0.781699],[0.5,0.2,0,0]];
PPeffect_colorC ppEffectEnable true;
PPeffect_colorC ppEffectCommit 0;

PPeffect_grain = ppEffectCreate ["FilmGrain",1550];
PPeffect_grain ppEffectAdjust [0.04,1,1,0,1];
PPeffect_grain ppEffectEnable true;
PPeffect_grain ppEffectCommit 0;




