private ["_unit","_animation","_code"];

_unit = _this select 0;
_animation = _this select 1;

_code = {
	private ["_unit","_animation"];
	_unit = _this select 0;
	_animation = _this select 1;
	
	_unit setVariable ["acpl_animation_active",true,true];
	_unit disableAI "move";
	_unit disableAI "anim";
	
	while {(alive _unit) AND (_unit getvariable "acpl_animation_active")} do {
		[_unit,_animation] remoteExec ["playMoveNow",0];
		waitUntil {(animationState _unit != _animation) OR (!(_unit getvariable "acpl_animation_active"))};
	};
	if (_unit setVariable "acpl_animation_active") then {
		_unit setVariable ["acpl_animation_active",false,true];
	} else {
		[_unit,""] remoteExec ["switchMove",0];
	};
	_unit enableAI "move";
	_unit enableAI "anim";
};

[_unit,_animation] spawn _code;