if (!isserver) exitwith {};

acpl_heavywounded = {
	params ["_unit"];
	private ["_type", "_status", "_most", "_head", "_torso", "_hands", "_legs", "_vars", "_anims", "_anim"];
	
	_type = "NONE";
	_status = _unit getVariable "ace_medical_bodypartstatus";
	_most = 0;
	
	_head = _status select 0;
	_torso = _status select 1;
	_hands = (_status select 2) + (_status select 3);
	_legs = (_status select 4) + (_status select 5);
	
	_vars = [_head, _torso, _hands, _legs];
	
	{
		if (_x > _most) then {
			_most = _x;
			if (_x == _head) then {_type = "HEAD"};
			if (_x == _torso) then {_type = "TORSO"};
			if (_x == _hands) then {_type = "HANDS"};
			if (_x == _legs) then {_type = "LEGS"};
		};
	} foreach _vars;
	
	_unit setVariable ["acpl_anim",true,true];
	
	[_unit,true] remoteExec ["setUnconscious", 0, true];
	
	waitUntil {sleep acpl_loop_sleep;((AnimationState _unit == "UnconsciousReviveDefault") OR !(alive _unit) OR (_unit getvariable "ace_isunconscious"))};
	
	if (!(alive _unit) OR (_unit getvariable "ace_isunconscious")) exitwith {
		_unit setVariable ["acpl_anim",false,true];
	};
	
	if (_type == "NONE") then {
		_anims = ["UnconsciousReviveDefault_A","UnconsciousReviveDefault_B","UnconsciousReviveDefault_C"];
	};
	if (_type == "HEAD") then {
		_anims = ["UnconsciousReviveHead_A","UnconsciousReviveHead_B","UnconsciousReviveHead_C"];
	};
	if (_type == "LEGS") then {
		_anims = ["UnconsciousReviveLegs_A","UnconsciousReviveLegs_B"];
	};
	if (_type == "HANDS") then {
		_anims = ["UnconsciousReviveArms_A","UnconsciousReviveArms_B","UnconsciousReviveArms_C"];
	};
	if (_type == "TORSO") then {
		_anims = ["UnconsciousReviveBody_A","UnconsciousReviveBody_B","UnconsciousReviveDefault_A"];
	};
	
	_anim = _anims select floor(random(count _anims));
	
	[_unit,_anim] remoteExec ["switchmove", 0, true];
	
	[_unit,"ANIM"] remoteExec ["DisableAI", 0, true];
	
	while {(_unit getVariable "acpl_heal_heavy") AND (alive _unit) AND !(_unit getvariable "ace_isunconscious") AND ([_unit] call acpl_heal_wounded)} do {
		if (!(_unit getVariable "acpl_heal_dragging") AND (AnimationState _unit != _anim)) then {
			[_unit,true] remoteExec ["setUnconscious", 0, true];
	
			waitUntil {sleep acpl_loop_sleep;((AnimationState _unit == "UnconsciousReviveDefault") OR !(alive _unit) OR (_unit getvariable "ace_isunconscious"))};
			
			[_unit,_anim] remoteExec ["switchmove", 0, true];
		};
		
		sleep acpl_loop_sleep;
	};
	
	[_unit,"ANIM"] remoteExec ["EnableAI", 0, true];
	
	if (!(alive _unit) OR (_unit getvariable "ace_isunconscious")) exitwith {};
	
	[_unit,false] remoteExec ["setUnconscious", 0, true];
	[_unit,"UnconsciousReviveDefault"] remoteExec ["switchmove", 0, true];
	_unit setVariable ["acpl_anim",false,true];
};
publicvariable "acpl_heavywounded";

acpl_piss = {
	params ["_unit"];
	private ["_stream", "_dir"];
	
	_unit playMove "Acts_AidlPercMstpSlowWrflDnon_pissing";
	sleep 4;

	_dir = getDir _unit;
	
	_stream = "#particlesource" createVehicle [0,0,0];
	[_stream,[0,[0.004,0.004,0.004],[0.01,0.01,0.01],30,0.01,[0,0,0,0],1,0.02,360]] remoteExec ["setParticleRandom",0];

	[_stream,0.001] remoteExec ["setDropInterval",0];

	_stream attachTo [_unit,[0.1,0.15,-0.10],"Pelvis"] ;

	for "_i" from 0 to 1 step 0.01 do {
		[_stream,[["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (_dir) * _i,cos (_dir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]]] remoteExec ["setParticleParams",0];
		sleep 0.01;
	};
	sleep 4;
	
	for "_i" from 1 to 0.4 step -0.01 do {
		[_stream,[["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (_dir) * _i,cos (_dir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]]] remoteExec ["setParticleParams",0];
		sleep 0.01;
	};
	
	for "_i" from 0.4 to 0.8 step 0.02 do {
		[_stream,[["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (_dir) * _i,cos (_dir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]]] remoteExec ["setParticleParams",0];
		sleep 0.01;
	};
	
	for "_i" from 0.8 to 0.2 step -0.01 do {
		[_stream,[["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (_dir) * _i,cos (_dir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]]] remoteExec ["setParticleParams",0];
		sleep 0.01;
	};
	
	for "_i" from 0.2 to 0.3 step 0.02 do {
		[_stream,[["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (_dir) * _i,cos (_dir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]]] remoteExec ["setParticleParams",0];
		sleep 0.01;
	};
	
	for "_i" from 0.3 to 0.1 step -0.01 do {
		[_stream,[["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (_dir) * _i,cos (_dir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0.1],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]]] remoteExec ["setParticleParams",0];
		sleep 0.01;
	};
	
	for "_i" from 0.1 to 0 step -0.01 do {
		[_stream,[["\a3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,8],"","BillBoard",1,3,[0,0,0],[sin (_dir) * _i,cos (_dir) * _i,0],0,1.5,1,0.1,[0.02,0.02,0.1],[[0.8,0.7,0.2,_i],[0.8,0.7,0.2,_i],[0.8,0.7,0.2,0]],[1],1,0,"","",_stream,0,true,0.1,[[0.8,0.7,0.2,0]]]] remoteExec ["setParticleParams",0];
		sleep 0.01;
	};

	deleteVehicle _stream;
	
};
publicvariable "acpl_piss";

acpl_play_anim = {
	private ["_params", "_anims", "_azimutFix", "_attachSnap", "_attachOffset", "_attachObj", "_attachSpecs", "_attachSpecsAuto", "_linked", "_canInterpolate"];
	params [
	"_unit",
	"_animset",
	["_forcedSnapPoint", objNull],
	["_interpolate", false],
	["_attach", true]
	];
	
	if (isNil "_unit") exitWith {
		if (acpl_fnc_debug) then {_unit GlobalChat "acpl_play_anim - No unit selected!";};
	};
	if (isNil "_animset") exitWith {
		if (acpl_fnc_debug) then {_unit GlobalChat "acpl_play_anim - No animset selected!";};
	};
	if (isNil "_forcedSnapPoint") then {
		if (acpl_fnc_debug) then {_unit GlobalChat "acpl_play_anim - ForcedSnapPoint is not existing!";};

		_forcedSnapPoint = objNull;
	};
	if ((_unit getVariable ["BIS_fnc_ambientAnim__animset",""]) != "") exitWith {
		if (acpl_fnc_debug) then {_unit GlobalChat "acpl_play_anim - is already playing! Can not call it second time!";};
	};
	
	{[_unit, _x] remoteExec ["disableAI",0];} forEach ["ANIM","AUTOTARGET","FSM","MOVE","TARGET"];
	[_unit] remoteExec ["detach",0];
	
	_params = _animset call BIS_fnc_ambientAnimGetParams;

	_anims		= _params select 0;
	_azimutFix 	= _params select 1;
	_attachSnap 	= _params select 2;
	_attachOffset 	= _params select 3;
	_canInterpolate = _params select 7;
	
	if (count _anims == 0) exitWith {
		if (acpl_fnc_debug) then {_unit GlobalChat "acpl_play_anim - Wrong animset!";};
	};
	
	_linked = _unit nearObjects ["man",5];
	_linked = _linked - [_unit];

	{
		_xSet = _x getVariable ["BIS_fnc_ambientAnim__animset",""];

		if (_xSet != _animset || _xSet == "") then
		{
			_linked set [_forEachIndex,objNull];
		}
		else
		{
			_xLinked = _x getVariable ["BIS_fnc_ambientAnim__linked",[]];

			if !(_unit in _xLinked) then
			{
				_xLinked = _xLinked + [_unit];
				_x setVariable ["BIS_fnc_ambientAnim__linked",_xLinked];
			};
		};
	} forEach _linked; _linked = _linked - [objNull];	
	
	_attachSpecsAuto = switch (_animset) do {
		case "SIT_AT_TABLE":
		{
			[
				["Land_CampingChair_V2_F",[0,0.08,-0.02],-180],
				["Land_ChairPlastic_F",[0,0.08,-0.02],90],
				["Land_ChairWood_F",[0,0.02,-0.02],-180]
			];
		};
		case "SIT";
		{
			[
				["Land_CampingChair_V2_F",[0,0.08,0.05],-180],
				["Land_ChairPlastic_F",[0,0.08,0.05],90],
				["Land_ChairWood_F",[0,0.02,0.05],-180]
			];
		};
		case "SIT1";
		{
			[
				["Land_CampingChair_V2_F",[0,0.08,0.05],-180],
				["Land_ChairPlastic_F",[0,0.08,0.05],90],
				["Land_ChairWood_F",[0,0.02,0.05],-180]
			];
		};
		case "SIT2";
		{
			[
				["Land_CampingChair_V2_F",[0,0.08,0.05],-180],
				["Land_ChairPlastic_F",[0,0.08,0.05],90],
				["Land_ChairWood_F",[0,0.02,0.05],-180]
			];
		};
		case "SIT3";
		{
			[
				["Land_CampingChair_V2_F",[0,0.08,0.05],-180],
				["Land_ChairPlastic_F",[0,0.08,0.05],90],
				["Land_ChairWood_F",[0,0.02,0.05],-180]
			];
		};
		case "SIT_U1";
		{
			[
				["Land_CampingChair_V2_F",[0,0.08,0.05],-180],
				["Land_ChairPlastic_F",[0,0.08,0.05],90],
				["Land_ChairWood_F",[0,0.02,0.05],-180]
			];
		};
		case "SIT_U2";
		{
			[
				["Land_CampingChair_V2_F",[0,0.08,0.05],-180],
				["Land_ChairPlastic_F",[0,0.08,0.05],90],
				["Land_ChairWood_F",[0,0.02,0.05],-180]
			];
		};
		case "SIT_U3":
		{
			[
				["Land_CampingChair_V2_F",[0,0.08,0.05],-180],
				["Land_ChairPlastic_F",[0,0.08,0.05],90],
				["Land_ChairWood_F",[0,0.02,0.05],-180]
			];
		};

		case "SIT_SAD1":
		{
			[
				["Box_NATO_Wps_F",[0,-0.27,0.03],0]
			];
		};
		case "SIT_SAD2":
		{
			[
				["Box_NATO_Wps_F",[0,-0.3,0.05],0]
			];
		};
		case "SIT_HIGH1":
		{
			[
				["Box_NATO_Wps_F",[0,-0.23,0.03],0]
			];
		};
		case "SIT_HIGH";
		case "SIT_HIGH2":
		{
			[
				["Box_NATO_Wps_F",[0,-0.12,-0.20],0]
			];
		};


		default
		{
			[];
		};
	};
	
	if !(isNull _forcedSnapPoint) then
	{
		_attachObj = _forcedSnapPoint;
		_attachSpecs = [typeOf _forcedSnapPoint,[0,0,_attachOffset],0];

		//get the attach specs
		{
			if ((_x select 0) == typeOf _forcedSnapPoint) exitWith
			{
				_attachSpecs = _x;
			};
		}
		forEach _attachSpecsAuto;
	}
	else
	{
		//default situation, snappoint not found = using unit position
		_attachSpecs = [typeOf _unit,[0,0,_attachOffset],0];
		_attachObj = _unit;

		//get the snappoint object
		private["_obj"];

		{
			_obj = nearestObject [_unit, _x select 0];

			if (([_obj,_unit] call BIS_fnc_distance2D) < _attachSnap) exitWith {
				_attachSpecs = _x;
				_attachObj = _obj;
			};
		} forEach _attachSpecsAuto;
	};
	
	_unit setVariable ["BIS_fnc_ambientAnim__linked",_linked];
	
	_unit setVariable ["acpl_anim",true,true];
	_unit setVariable ["BIS_fnc_ambientAnim__anims",_anims];
	_unit setVariable ["BIS_fnc_ambientAnim__animset",_animset];
	_unit setVariable ["BIS_fnc_ambientAnim__interpolate",_interpolate && _canInterpolate];
	
	_unit setVariable ["BIS_fnc_ambientAnim__time",0];
	
	[_attachObj, _unit] remoteExec ["disableCollisionWith",0];
	[_unit, _attachObj] remoteExec ["disableCollisionWith",0];
	
	[_unit,_attachObj,_attachSpecs,_azimutFix,_attach] spawn
	{
		private ["_unit", "_attachObj", "_attachSpecs", "_azimutFix", "_attach", "_group", "_logic", "_ehAnimDone", "_ehKilled"];
		
		_unit = _this select 0;
		_attachObj = _this select 1;
		_attachSpecs = _this select 2;
		_azimutFix = _this select 3;
		_attach = _this select 4;
		
		waitUntil {time > 0};
		
		if (isNil "_unit") exitWith {};
		if (isNull _unit) exitWith {};
		if !(alive _unit && canMove _unit) exitWith {};
		
		_attachPos = getPosASL _attachObj;
		
		_group = group _unit;
		_logic = _group createUnit ["Logic", [_attachPos select 0,_attachPos select 1,0], [], 0, "NONE"];
		
		if (isNull _logic) exitWith {
			_unit call acpl_func_playAnim;

			if (count units _group == 0) then
			{
				deleteGroup _group;
			};
		};
		
		_logic setPosASL _attachPos;
		_logic setDir ((getDir _attachObj) + _azimutFix);
		
		_unit setVariable ["BIS_fnc_ambientAnim__logic",_logic];
		_unit setVariable ["BIS_fnc_ambientAnim__helper",_attachObj];
		
		if (_attach) then
		{
			_unit attachTo [_logic,_attachSpecs select 1];
			_unit setVariable ["BIS_fnc_ambientAnim__attached",true];
		};
		
		_unit call acpl_func_playAnim;
		
		_ehAnimDone = _unit addEventHandler [
			"AnimDone",
			{
				private["_unit","_anim","_pool"];

				_unit = _this select 0;
				_anim = _this select 1;
				_pool = _unit getVariable ["BIS_fnc_ambientAnim__anims",[]];

				if (alive _unit) then
				{
					_unit call acpl_func_playAnim;
				}
				else
				{
					_unit call acpl_func_animterminate;
				};
			}
		];
		_unit setVariable ["BIS_EhAnimDone", _ehAnimDone];
	
		_ehKilled = _unit addEventHandler [
			"Killed",
			{
				(_this select 0) call acpl_func_animterminate;
			}
		];
		_unit setVariable ["BIS_EhKilled", _ehKilled];
	};
};
publicvariable "acpl_play_anim";

acpl_func_playAnim = {
	private["_unit","_anims","_anim","_available","_time","_linkedUnits","_linkedAnims","_xTime","_interpolate"];

	if (isNull _this) exitWith {};
	if !(alive _this && canMove _this) exitWith {};

	_unit = _this;
	_anims 	= _unit getVariable ["BIS_fnc_ambientAnim__anims",[]];

	if (count _anims == 0) exitWith
	{
		if (acpl_fnc_debug) then {_unit GlobalChat "acpl_play_anim - doesn't have defined ambient anims!";};
	};

	_linkedUnits = _unit getVariable ["BIS_fnc_ambientAnim__linked",[]];

	_linkedAnims = [];

	_time = time - 10;

	{
		_xTime = _x getVariable ["BIS_fnc_ambientAnim__time",_time];

		if (_xTime > _time) then
		{
			_linkedAnims = _linkedAnims + [animationState _x];
		};
	}
	forEach _linkedUnits;
	
	_available = _anims - _linkedAnims;

	if (count _available == 0) then
	{
		if (acpl_fnc_debug) then {_unit GlobalChat "acpl_play_anim - doesn't have an available/free animation to play!";};

		_available = _anims;
	};
	
	_anim = _available call BIS_fnc_selectRandom;

	_interpolate = _unit getVariable ["BIS_fnc_ambientAnim__interpolate",false];

	if (_interpolate) then
	{
		[_unit, _anim] remoteExec ["playMoveNow",0];
	}
	else
	{
		[_unit, _anim] remoteExec ["switchMove",0];
	};
	
	_unit setVariable ["acpl_anim",true,true];
	_unit setVariable ["acpl_anim_class",_anim,true];
};
publicvariable "acpl_func_playAnim";

acpl_func_animterminate = {
	private["_unit","_ehAnimDone","_ehKilled","_fnc_log_disable","_detachCode"];

	_fnc_log_disable = false;

	if (typeName _this == typeName []) exitWith
	{
		{
			_x call acpl_func_animterminate;
		}
		forEach _this;
	};

	if (typeName _this != typeName objNull) exitWith {};

	if (isNull _this) exitWith {};

	_unit = _this;
	
	{[_unit, _x] remoteExec ["enableAI",0];} forEach ["ANIM", "AUTOTARGET", "FSM", "MOVE", "TARGET"];

	_ehAnimDone 	= _unit getVariable ["BIS_EhAnimDone",-1];
	_ehKilled 	= _unit getVariable ["BIS_EhKilled",-1];

	if (_ehAnimDone != -1) then
	{
		_unit removeEventHandler ["AnimDone",_ehAnimDone];
		_unit setVariable ["BIS_EhAnimDone",-1];
	};
	if (_ehKilled != -1) then
	{
		_unit removeEventHandler ["Killed",_ehKilled];
		_unit setVariable ["BIS_EhKilled",-1];
	};

	_detachCode =
	{
		private["_logic"];
		
		if (isNull _this) exitWith {};

		_logic = _this getVariable ["BIS_fnc_ambientAnim__logic",objNull];

		//delete the game logic
		if !(isNull _logic) then
		{
			deleteVehicle _logic;
		};

		_this setVariable ["BIS_fnc_ambientAnim__attached",nil];
		_this setVariable ["BIS_fnc_ambientAnim__animset",nil];
		_this setVariable ["BIS_fnc_ambientAnim__anims",nil];
		_this setVariable ["BIS_fnc_ambientAnim__interpolate",nil];
		_this setVariable ["BIS_fnc_ambientAnim__time",nil];
		_this setVariable ["BIS_fnc_ambientAnim__logic",nil];
		_this setVariable ["BIS_fnc_ambientAnim__helper",nil];
		_this setVariable ["BIS_fnc_ambientAnim__linked",nil];
		
		detach _this;
		
		if (alive _this) then {
			[_unit, ""] remoteExec ["switchMove",0];
			_unit setVariable ["acpl_anim",false,true];
			_unit setVariable ["acpl_playanim",false,true];
			_unit setVariable ["acpl_anim_class",objNull,true];
		};
	};

	if (time > 0) then
	{
		_unit call _detachCode;
	}
	else
	{
		[_unit,_detachCode] spawn
		{
			sleep 0.3; (_this select 0) call (_this select 1);
		};
	};
};
publicvariable "acpl_func_animterminate";

acpl_load_animations = true;
publicvariable "acpl_load_animations";

if (acpl_fnc_debug) then {["ACPL FNCS ANIMATIONS LOADED"] remoteExec ["systemchat",0];};