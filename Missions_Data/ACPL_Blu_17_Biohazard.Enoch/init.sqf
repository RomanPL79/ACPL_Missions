private _text = "Bio Threat";	 //text wyświetlany przy starcie misji ("Wyświetlany text")

if (isserver) then {
	[[_text],"briefing.sqf"] remoteExec ["execVM",2];
};

acpl_fnc_debug = false;