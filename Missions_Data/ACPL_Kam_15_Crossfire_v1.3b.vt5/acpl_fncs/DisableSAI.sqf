params ["_unit"];

//_nul = [this] execVM "acpl_fncs\DisableSAI.sqf";
//v1.0

_unit setVariable ["VCOM_NOAI",true];
_unit setVariable ["Vcm_Disable",true];
_unit setvariable ["TCL_Disabled",true];
(group _unit) setVariable ["Vcm_Disable",true];
(group _unit) setvariable ["TCL_Disabled",true];