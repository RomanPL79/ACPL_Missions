private _text = "Bio Threat";	 //text wyœwietlany przy starcie misji ("Wyœwietlany text")

if (isserver) then {
	[[_text],"briefing.sqf"] remoteExec ["execVM",2];
};

acpl_fnc_debug = false;