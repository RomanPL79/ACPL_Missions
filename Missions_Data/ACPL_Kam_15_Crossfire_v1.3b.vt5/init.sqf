private ["_type", "_mc", "_betterAI", "_static", "_medical_ex", "_ied_system", "_safestart", "_text", "_hetman", "_viewdistance"];

_type = 0;								//typ teatru 														(0 -> modern, 1 -> WW2)
_mc = [med1,med2];								//nazwy centr medycznych 											([nazwa1,nazwa2])
_betterAI = true;						//czy u¿ywaæ lepszego AI? 											(true/false)
_static = false;							//czy zatrzymaæ grywalne AI na pocz¹tku misji? 						(true/false)
_medical_ex = [];						//jednostki którym nie ma dodawaæ automatycznie medykamentów 		([jednostka1,jednostka2])
_ied_system = false;					//czy w³¹czyæ zaawansowany system IED? 								(true/false)
_safestart = false;						//czy w³aczyæ system safestart? 									(true/false)
_text = "Gdzies na Ukrainie";	 //text wyœwietlany przy starcie misji ("Wyœwietlany text")
_hetman = false;						//czy uruchomiæ HAL (naczelny dowódca AI)							(true/false)
_viewdistance = 800;					//viewdistance
if (isserver) then {
[[_type,_mc,_betterAI,_static,_medical_ex,_ied_system,_safestart,_text,_hetman,_viewdistance],"acpl_fncs_init.sqf"] remoteExec ["execVM",2];
};



titleCut ["","BLACK IN", 7];

execVM "ambient.sqf";
