

_asf_shooters = _this param [0];
_asf_playerforces = _this param [1];
_asf_supp_time = _this param [2];
_asf_offset = _this param [3];
_asf_supp_break = _this param [4];
_asf_rearming = _this param [5];




/////






_asf_visible_units=[];

{
	_asf_viewpoint = eyePos _asf_shooters;
	_asf_viewpoint set [2,((_asf_viewpoint select 2)+_asf_offset)];
	_asf_target = eyePos _x;
	_asf_target set [2,((_asf_target select 2)+_asf_offset)];
	_cansee = [objNull, "VIEW"] checkVisibility [_asf_viewpoint, _asf_target];
	_knowsabout = _asf_shooters knowsAbout _x; 
	_knowsabout2 = (gunner _asf_shooters) knowsAbout _x; 
	
	if ((_cansee > 0)&&((_knowsabout > 0)||(_knowsabout2 > 0))) then {
		_asf_visible_units pushback _x ;
	};
	
	//x1 groupChat format ["%1",e1 getVariable "ASF_AI"];
 
} forEach _asf_playerforces;

sleep 0.5;

if ( count _asf_visible_units > 0) then {
	_asf_shooters setVariable ["ASF_AI", 0];
	_asf_shooters setVariable ["ASF_READY", 0];
	sleep 0.5;
	0 = [[_asf_shooters], [_asf_visible_units], _asf_supp_time,_asf_supp_break, _asf_rearming ] execVM "ASF\asf_suppress.sqf";
};


