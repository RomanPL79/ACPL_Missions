params ["_unit", "_type"];

//_nul = [this,0] execVM "acpl_fncs\create_doc.sqf";
//v1.0
//
//0 for assistant
//1 for doctor

if (!isserver) exitwith {};

if (isNil "acpl_fncs_initied") then {acpl_fncs_initied = false};
if (isNil "acpl_medical_done") then {acpl_medical_done = []};

waitUntil {acpl_fncs_initied};

if (_unit in acpl_medical_done) then {} else {
	acpl_medical_done = acpl_medical_done + [_unit];
	publicvariable "acpl_medical_done";
};

[_unit] call acpl_medic_remove;
_unit setVariable ["ace_medical_medicClass", 2, true];

if (_type == 0) then {
	for "_i" from 1 to acpl_fieldDressing_doc do {[_unit,"ACE_fieldDressing"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_elasticBandage_doc do {[_unit,"ACE_elasticBandage"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_adenosine_doc do {[_unit,"ACE_adenosine"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_atropine_doc do {[_unit,"ACE_atropine"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_bloodIV_250_doc do {[_unit,"ACE_bloodIV_250"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_epinephrine_doc do {[_unit,"ACE_epinephrine"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_morphine_doc do {[_unit,"ACE_morphine"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_packingBandage_doc do {[_unit,"ACE_packingBandage"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_personalAidKit_doc do {[_unit,"ACE_personalAidKit"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_plasmaIV_doc do {[_unit,"ACE_plasmaIV"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_plasmaIV_250_doc do {[_unit,"ACE_plasmaIV_250"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_plasmaIV_500_doc do {[_unit,"ACE_plasmaIV_500"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_salineIV_doc do {[_unit,"ACE_salineIV"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_salineIV_250_doc do {[_unit,"ACE_salineIV_250"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_salineIV_500_doc do {[_unit,"ACE_salineIV_500"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_surgicalKit_doc do {[_unit,"ACE_surgicalKit"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_tourniquet_doc do {[_unit,"ace_tourniquet"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_quicklot_doc do {[_unit,"ACE_quikclot"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_medicbag_doc do {[_unit,"FSGm_ItemMedicBagMil"] remoteExec ["additem",_unit];};
};
if (_type == 1) then {
	for "_i" from 1 to acpl_fieldDressing_doc_main do {[_unit,"ACE_fieldDressing"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_elasticBandage_doc_main do {[_unit,"ACE_elasticBandage"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_adenosine_doc_main do {[_unit,"ACE_adenosine"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_atropine_doc_main do {[_unit,"ACE_atropine"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_bloodIV_250_doc_main do {[_unit,"ACE_bloodIV_250"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_epinephrine_doc_main do {[_unit,"ACE_epinephrine"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_morphine_doc_main do {[_unit,"ACE_morphine"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_packingBandage_doc_main do {[_unit,"ACE_packingBandage"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_personalAidKit_doc_main do {[_unit,"ACE_personalAidKit"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_plasmaIV_doc_main do {[_unit,"ACE_plasmaIV"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_plasmaIV_250_doc_main do {[_unit,"ACE_plasmaIV_250"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_plasmaIV_500_doc_main do {[_unit,"ACE_plasmaIV_500"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_salineIV_doc_main do {[_unit,"ACE_salineIV"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_salineIV_250_doc_main do {[_unit,"ACE_salineIV_250"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_salineIV_500_doc_main do {[_unit,"ACE_salineIV_500"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_surgicalKit_doc_main do {[_unit,"ACE_surgicalKit"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_tourniquet_doc_main do {[_unit,"ace_tourniquet"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_quicklot_doc_main do {[_unit,"ACE_quikclot"] remoteExec ["additem",_unit];};
	for "_i" from 1 to acpl_medicbag_doc_main do {[_unit,"FSGm_ItemMedicBagMil"] remoteExec ["additem",_unit];};
};