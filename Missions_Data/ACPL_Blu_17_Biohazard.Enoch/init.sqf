private _text = "Bio Threat";	 //text wy�wietlany przy starcie misji ("Wy�wietlany text")

if (isserver) then {
	[[_text],"briefing.sqf"] remoteExec ["execVM",2];
};

acpl_fnc_debug = false;