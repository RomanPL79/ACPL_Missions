/*
ACPL Animation Script
By Roman79
Version BETA-1 WIP
*/

if (!isserver) exitwith {};

acpl_animations_start = compile preprocessFileLineNumbers "acpl_fncs\acpl_animations\acpl_animations_start.sqf";

waitUntil {time > 2};
acpl_animations_activated = true;
publicvariable "acpl_animations_activated";