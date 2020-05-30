private ["_cm","_units","_AI_meds","_units_AI"];

_cm = _this select 0;
_AI_meds = _this select 1;

if (!isserver) exitwith {};
waitUntil {time >= 1};

/*	Skrypt dodaj¹cy wyposa¿enie medyczne By Roman79
	U¿ywamy automatycznie, wykrywa stronê i dodaje odpowiedni¹ iloœæ medykamentów
	_null = [centra_medyczne] execVM "acpl_fncs\acpl_addmeds.sqf";
	
	Version: 1.3
	
	CHANGELOG:
	1.1
	- Poprawiono ustawienia domyœlne, teraz s¹ zgodne z domyœlnym wyposa¿eniem.
	
	1.1a
	- Poprawiono ustawienia domyœlne, teraz s¹ zgodne z domyœlnym wyposa¿eniem. (drugi raz)
	
	1.2
	- Zmieniono zasadê dzia³ania, teraz dzia³a dla wszystkich grywalnych jednostek i sam wykrywa sanitariuszy (³atwiejsze w zastosowaniu)
	- Uruchamiany przez g³ówny skrypt
	
	1.3
	- Dodano mo¿liwoœæ nadpisania medykamentów AI (równie¿ dla spawnowanych jednostek)
*/

_units = playableUnits + switchableUnits + allPlayers;

{
	private ["_items","_medic"];
	_items = items _x;
	for "_i" from 1 to ({_x == "ACE_fieldDressing"} count _items) do {_x removeitem "ACE_fieldDressing"};
	for "_i" from 1 to ({_x == "ACE_elasticBandage"} count _items) do {_x removeitem "ACE_elasticBandage"};
	for "_i" from 1 to ({_x == "ACE_adenosine"} count _items) do {_x removeitem "ACE_adenosine"};
	for "_i" from 1 to ({_x == "ACE_atropine"} count _items) do {_x removeitem "ACE_atropine"};
	for "_i" from 1 to ({_x == "ACE_bloodIV"} count _items) do {_x removeitem "ACE_bloodIV"};
	for "_i" from 1 to ({_x == "ACE_bloodIV_250"} count _items) do {_x removeitem "ACE_bloodIV_250"};
	for "_i" from 1 to ({_x == "ACE_bloodIV_500"} count _items) do {_x removeitem "ACE_bloodIV_500"};
	for "_i" from 1 to ({_x == "ACE_bodyBag"} count _items) do {_x removeitem "ACE_bodyBag"};
	for "_i" from 1 to ({_x == "ACE_epinephrine"} count _items) do {_x removeitem "ACE_epinephrine"};
	for "_i" from 1 to ({_x == "ACE_morphine"} count _items) do {_x removeitem "ACE_morphine"};
	for "_i" from 1 to ({_x == "ACE_packingBandage"} count _items) do {_x removeitem "ACE_packingBandage"};
	for "_i" from 1 to ({_x == "ACE_personalAidKit"} count _items) do {_x removeitem "ACE_personalAidKit"};
	for "_i" from 1 to ({_x == "ACE_plasmaIV"} count _items) do {_x removeitem "ACE_plasmaIV"};
	for "_i" from 1 to ({_x == "ACE_plasmaIV_250"} count _items) do {_x removeitem "ACE_plasmaIV_250"};
	for "_i" from 1 to ({_x == "ACE_plasmaIV_500"} count _items) do {_x removeitem "ACE_plasmaIV_500"};
	for "_i" from 1 to ({_x == "ACE_salineIV"} count _items) do {_x removeitem "ACE_salineIV"};
	for "_i" from 1 to ({_x == "ACE_salineIV_250"} count _items) do {_x removeitem "ACE_salineIV_250"};
	for "_i" from 1 to ({_x == "ACE_salineIV_500"} count _items) do {_x removeitem "ACE_salineIV_500"};
	for "_i" from 1 to ({_x == "ACE_surgicalKit"} count _items) do {_x removeitem "ACE_surgicalKit"};
	for "_i" from 1 to ({_x == "ace_tourniquet"} count _items) do {_x removeitem "ace_tourniquet"};
	
	_medic = [_x] call ace_medical_fnc_isMedic;
	
	if (_medic) then {
		for "_i" from 1 to acpl_fieldDressing_med do {_x additem "ACE_fieldDressing"};
		for "_i" from 1 to acpl_elasticBandage_med do {_x additem "ACE_elasticBandage"};
		for "_i" from 1 to acpl_adenosine_med do {_x additem "ACE_adenosine"};
		for "_i" from 1 to acpl_atropine_med do {_x additem "ACE_atropine"};
		for "_i" from 1 to acpl_bloodIV_250_med do {_x additem "ACE_bloodIV_250"};
		for "_i" from 1 to acpl_epinephrine_med do {_x additem "ACE_epinephrine"};
		for "_i" from 1 to acpl_morphine_med do {_x additem "ACE_morphine"};
		for "_i" from 1 to acpl_packingBandage_med do {_x additem "ACE_packingBandage"};
		for "_i" from 1 to acpl_personalAidKit_med do {_x additem "ACE_personalAidKit"};
		for "_i" from 1 to acpl_plasmaIV_med do {_x additem "ACE_plasmaIV"};
		for "_i" from 1 to acpl_plasmaIV_250_med do {_x additem "ACE_plasmaIV_250"};
		for "_i" from 1 to acpl_plasmaIV_500_med do {_x additem "ACE_plasmaIV_500"};
		for "_i" from 1 to acpl_salineIV_med do {_x additem "ACE_salineIV"};
		for "_i" from 1 to acpl_salineIV_250_med do {_x additem "ACE_salineIV_250"};
		for "_i" from 1 to acpl_salineIV_500_med do {_x additem "ACE_salineIV_500"};
		for "_i" from 1 to acpl_surgicalKit_med do {_x additem "ACE_surgicalKit"};
		for "_i" from 1 to acpl_tourniquet_med do {_x additem "ace_tourniquet"};
	} else {
		for "_i" from 1 to acpl_fieldDressing_sol do {_x additem "ACE_fieldDressing"};
		for "_i" from 1 to acpl_elasticBandage_sol do {_x additem "ACE_elasticBandage"};
		for "_i" from 1 to acpl_adenosine_sol do {_x additem "ACE_adenosine"};
		for "_i" from 1 to acpl_atropine_sol do {_x additem "ACE_atropine"};
		for "_i" from 1 to acpl_epinephrine_sol do {_x additem "ACE_epinephrine"};
		for "_i" from 1 to acpl_morphine_sol do {_x additem "ACE_morphine"};
		for "_i" from 1 to acpl_packingBandage_sol do {_x additem "ACE_packingBandage"};
		for "_i" from 1 to acpl_personalAidKit_sol do {_x additem "ACE_personalAidKit"};
		for "_i" from 1 to acpl_tourniquet_sol do {_x additem "ace_tourniquet"};
	};
} foreach _units;
{
	_x additemCargoGlobal ["ACE_fieldDressing",acpl_fieldDressing_veh];
	_x additemCargoGlobal ["ACE_elasticBandage",acpl_elasticBandage_veh];
	_x additemCargoGlobal ["ACE_adenosine",acpl_adenosine_veh];
	_x additemCargoGlobal ["ACE_atropine",acpl_atropine_veh];
	_x additemCargoGlobal ["ACE_bloodIV",acpl_bloodIV_veh];
	_x additemCargoGlobal ["ACE_bodyBag",acpl_bodyBag_veh];
	_x additemCargoGlobal ["ACE_epinephrine",acpl_epinephrine_veh];
	_x additemCargoGlobal ["ACE_morphine",acpl_morphine_veh];
	_x additemCargoGlobal ["ACE_packingBandage",acpl_packingBandage_veh];
	_x additemCargoGlobal ["ACE_plasmaIV",acpl_plasmaIV_veh];
	_x additemCargoGlobal ["ACE_salineIV",acpl_salineIV_veh];
	_x additemCargoGlobal ["ACE_surgicalKit",acpl_surgicalKit_veh];
	_x additemCargoGlobal ["ace_tourniquet",acpl_tourniquet_veh];
	
	_x setVariable ["ace_medical_isMedicalFacility",true,true];
	_x setVariable ["ace_medical_medicClass",2,true];
} foreach _cm;

if (_AI_meds) then {	
	private ["_items","_medic","_units_AI"];
	acpl_addmeds_units_done = [];
	while {true} do {
		_units_AI = allunits - _units - acpl_addmeds_units_done;
		{
			_items = items _x;
			for "_i" from 1 to ({_x == "ACE_fieldDressing"} count _items) do {_x removeitem "ACE_fieldDressing"};
			for "_i" from 1 to ({_x == "ACE_elasticBandage"} count _items) do {_x removeitem "ACE_elasticBandage"};
			for "_i" from 1 to ({_x == "ACE_adenosine"} count _items) do {_x removeitem "ACE_adenosine"};
			for "_i" from 1 to ({_x == "ACE_atropine"} count _items) do {_x removeitem "ACE_atropine"};
			for "_i" from 1 to ({_x == "ACE_bloodIV"} count _items) do {_x removeitem "ACE_bloodIV"};
			for "_i" from 1 to ({_x == "ACE_bloodIV_250"} count _items) do {_x removeitem "ACE_bloodIV_250"};
			for "_i" from 1 to ({_x == "ACE_bloodIV_500"} count _items) do {_x removeitem "ACE_bloodIV_500"};
			for "_i" from 1 to ({_x == "ACE_bodyBag"} count _items) do {_x removeitem "ACE_bodyBag"};
			for "_i" from 1 to ({_x == "ACE_epinephrine"} count _items) do {_x removeitem "ACE_epinephrine"};
			for "_i" from 1 to ({_x == "ACE_morphine"} count _items) do {_x removeitem "ACE_morphine"};
			for "_i" from 1 to ({_x == "ACE_packingBandage"} count _items) do {_x removeitem "ACE_packingBandage"};
			for "_i" from 1 to ({_x == "ACE_personalAidKit"} count _items) do {_x removeitem "ACE_personalAidKit"};
			for "_i" from 1 to ({_x == "ACE_plasmaIV"} count _items) do {_x removeitem "ACE_plasmaIV"};
			for "_i" from 1 to ({_x == "ACE_plasmaIV_250"} count _items) do {_x removeitem "ACE_plasmaIV_250"};
			for "_i" from 1 to ({_x == "ACE_plasmaIV_500"} count _items) do {_x removeitem "ACE_plasmaIV_500"};
			for "_i" from 1 to ({_x == "ACE_salineIV"} count _items) do {_x removeitem "ACE_salineIV"};
			for "_i" from 1 to ({_x == "ACE_salineIV_250"} count _items) do {_x removeitem "ACE_salineIV_250"};
			for "_i" from 1 to ({_x == "ACE_salineIV_500"} count _items) do {_x removeitem "ACE_salineIV_500"};
			for "_i" from 1 to ({_x == "ACE_surgicalKit"} count _items) do {_x removeitem "ACE_surgicalKit"};
			for "_i" from 1 to ({_x == "ace_tourniquet"} count _items) do {_x removeitem "ace_tourniquet"};
			
			_medic = [_x] call ace_medical_fnc_isMedic;
			
			if (_medic) then {
				for "_i" from 1 to acpl_fieldDressing_med do {_x additem "ACE_fieldDressing"};
				for "_i" from 1 to acpl_elasticBandage_med do {_x additem "ACE_elasticBandage"};
				for "_i" from 1 to acpl_adenosine_med do {_x additem "ACE_adenosine"};
				for "_i" from 1 to acpl_atropine_med do {_x additem "ACE_atropine"};
				for "_i" from 1 to acpl_bloodIV_250_med do {_x additem "ACE_bloodIV_250"};
				for "_i" from 1 to acpl_epinephrine_med do {_x additem "ACE_epinephrine"};
				for "_i" from 1 to acpl_morphine_med do {_x additem "ACE_morphine"};
				for "_i" from 1 to acpl_packingBandage_med do {_x additem "ACE_packingBandage"};
				for "_i" from 1 to acpl_personalAidKit_med do {_x additem "ACE_personalAidKit"};
				for "_i" from 1 to acpl_plasmaIV_med do {_x additem "ACE_plasmaIV"};
				for "_i" from 1 to acpl_plasmaIV_250_med do {_x additem "ACE_plasmaIV_250"};
				for "_i" from 1 to acpl_plasmaIV_500_med do {_x additem "ACE_plasmaIV_500"};
				for "_i" from 1 to acpl_salineIV_med do {_x additem "ACE_salineIV"};
				for "_i" from 1 to acpl_salineIV_250_med do {_x additem "ACE_salineIV_250"};
				for "_i" from 1 to acpl_salineIV_500_med do {_x additem "ACE_salineIV_500"};
				for "_i" from 1 to acpl_surgicalKit_med do {_x additem "ACE_surgicalKit"};
				for "_i" from 1 to acpl_tourniquet_med do {_x additem "ace_tourniquet"};
			} else {
				for "_i" from 1 to acpl_fieldDressing_AI do {_x additem "ACE_fieldDressing"};
				for "_i" from 1 to acpl_elasticBandage_AI do {_x additem "ACE_elasticBandage"};
				for "_i" from 1 to acpl_adenosine_AI do {_x additem "ACE_adenosine"};
				for "_i" from 1 to acpl_atropine_AI do {_x additem "ACE_atropine"};
				for "_i" from 1 to acpl_epinephrine_AI do {_x additem "ACE_epinephrine"};
				for "_i" from 1 to acpl_morphine_AI do {_x additem "ACE_morphine"};
				for "_i" from 1 to acpl_packingBandage_AI do {_x additem "ACE_packingBandage"};
				for "_i" from 1 to acpl_personalAidKit_AI do {_x additem "ACE_personalAidKit"};
				for "_i" from 1 to acpl_tourniquet_AI do {_x additem "ace_tourniquet"};
			};
			acpl_addmeds_units_done = acpl_addmeds_units_done + [_x];
		} foreach _units_AI;
		sleep 10;
	};
};