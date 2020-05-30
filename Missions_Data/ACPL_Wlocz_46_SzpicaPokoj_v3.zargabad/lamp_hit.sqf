params ["_lamp", ["_attach", [0,-0.5,0]]];

if (!isserver) exitwith {};

_lamp setvariable ["acpl_light", true, true];

[[_lamp, _attach],
{
	params ["_lamp", "_attach"];
	
	_light = "#lightpoint" createVehicleLocal [0,0,0];
	_light setLightColor [1,1,0.460816];
	_light setLightAmbient [0,0,0];
	_light setLightIntensity 12000;
	_light setLightUseFlare false;
	_light setLightFlareSize 1;
	_light setLightFlareMaxDistance 0;
	_light setLightDayLight false;
	_light setLightAttenuation [0,0,0,20,2.1,0];
	
	_light lightAttachObject [_lamp, _attach];
	
	waitUntil {sleep 0.1;!(_lamp getvariable "acpl_light") || (!alive _lamp)};
	
	deletevehicle _light;
}] remoteExec ["spawn",0,true];



[_lamp,
["HitPart", {
	(_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
	
	_target setvariable ["acpl_light", false, true];
}]] remoteExec ["addEventHandler", 0, true];