//Tasking

Action1ct = {

	(group (_this select 0)) setVariable [('Resting' + (str (group (_this select 0)))),false]; 
	(group (_this select 0)) setVariable [('Garrisoned' + (str (group (_this select 0)))),false];
	(group (_this select 0)) setVariable [('NOGarrisoned' + (str (group (_this select 0)))),true];


	[(_this select 0),RydxHQ_AIC_OrdDen,'OrdDen'] call RYD_AIChatter;
	deleteWaypoint [(group (_this select 0)),(currentWaypoint (group (_this select 0)))];

	{
	[_x,'CANCELED',true] call BIS_fnc_taskSetState;
	} foreach ((group (_this select 0)) getVariable ['HACAddedTasks',[]]);

	group (_this select 0) setVariable ['Unable',true];

	sleep 30;

	group (_this select 0) setVariable ['Unable',group (_this select 0) getVariable ['BUnable',false]];



};

Action1fnc = {

	private ["_Unit","_Action"];

	_Unit = _this select 0;

	_Action = _Unit addAction ["[HAL] Deny Assigned Task","[_this select 3] remoteExec ['Action1ct',2]",_Unit,-1.5,false,false,"","true",0.01];
	_Unit setVariable ["HAL_TaskAddedID",_Action];
};

ACEAction1fnc = {

	private ["_Unit","_ACEAction","_ACEActionP"];

	_Unit = _this select 0;

	_ACEActionP = ["ACEActionP","HAL Tasking","",{},{true}] call ace_interact_menu_fnc_createAction;
	_ACEAction = ["HALDenyAssignedTask","Deny Assigned Task","",{

		[_target] remoteExec ['Action1ct',2]
				
		},{true},{}] call ace_interact_menu_fnc_createAction;
	[_Unit, 1, ["ACE_SelfActions"], _ACEActionP] call ace_interact_menu_fnc_addActionToObject;
	[_Unit, 1, ["ACE_SelfActions","ACEActionP"], _ACEAction] call ace_interact_menu_fnc_addActionToObject;

};

Action2ct = {

	[(_this select 0),'Command, we are unavailable for further tasking - Over'] remoteExecCall ["RYD_MP_Sidechat"];
	group (_this select 0) setVariable ['Unable',true];
	group (_this select 0) setVariable ['BUnable',true];

};

Action2fnc = {

	private ["_Unit","_Action"];

	_Unit = _this select 0;

	_Action = _Unit addAction ["[HAL] Disable Tasking", 
		"
		[_this select 3] remoteExecCall ['Action2ct',2]
		"
		, 
		_Unit,-1.7,false,false,"","true",0.01];

	_Unit setVariable ["HAL_TaskDisabledID",_Action];

};

ACEAction2fnc = {

	private ["_Unit","_ACEAction"];

	_Unit = _this select 0;

	_ACEAction = ["HALDisableTasking","Disable Tasking","",{

			[_target] remoteExecCall ['Action2ct',2]

		},{true},{}] call ace_interact_menu_fnc_createAction;
		[_Unit, 1, ["ACE_SelfActions","ACEActionP"], _ACEAction] call ace_interact_menu_fnc_addActionToObject;

};

Action3ct = {

	[(_this select 0),'Command, we are available for further tasking - Over'] remoteExecCall ["RYD_MP_Sidechat"];
	group (_this select 0) setVariable ['Unable',false];
	group (_this select 0) setVariable ['BUnable',false];

};

Action3fnc = {

	private ["_Unit","_Action"];

	_Unit = _this select 0;

	_Action = _Unit addAction ["[HAL] Enable Tasking", 
		"
		[_this select 3] remoteExecCall ['Action3ct',2]
		"
		, 
		_Unit,-1.6,false,false,"","true",0.01];
	
	_Unit setVariable ["HAL_TaskEnabledID",_Action];

};

ACEAction3fnc = {

	private ["_Unit","_ACEAction"];

	_Unit = _this select 0;

	_ACEAction = ["HALEnableTasking","Enable Tasking","",{

			[_target] remoteExecCall ['Action3ct',2]

		},{true},{}] call ace_interact_menu_fnc_createAction;
		[_Unit, 1, ["ACE_SelfActions","ACEActionP"], _ACEAction] call ace_interact_menu_fnc_addActionToObject;


};

Action1fncR = {

	private ["_Unit","_Action"];

	_Unit = _this select 0;

	_Action = _Unit getVariable "HAL_TaskAddedID";
	_Unit removeAction _Action;

};

ACEAction1fncR = {

	private ["_Unit"];

	_Unit = _this select 0;

	[_Unit,1,["ACE_SelfActions","ACEActionP","HALDenyAssignedTask"]] call ace_interact_menu_fnc_removeActionFromObject;

};

Action2fncR = {

	private ["_Unit","_Action"];

	_Unit = _this select 0;

	_Action = _Unit getVariable "HAL_TaskDisabledID";
	_Unit removeAction _Action;

};

ACEAction2fncR = {

	private ["_Unit"];

	_Unit = _this select 0;

	[_Unit,1,["ACE_SelfActions","ACEActionP","HALDisableTasking"]] call ace_interact_menu_fnc_removeActionFromObject;

};

Action3fncR = {

	private ["_Unit","_Action"];

	_Unit = _this select 0;

	_Action = _Unit getVariable "HAL_TaskEnabledID";
	_Unit removeAction _Action;

};

ACEAction3fncR = {

	private ["_Unit"];

	_Unit = _this select 0;

	[_Unit,1,["ACE_SelfActions","ACEActionP","HALEnableTasking"]] call ace_interact_menu_fnc_removeActionFromObject;
	[_Unit,1,["ACE_SelfActions","ACEActionP"]] call ace_interact_menu_fnc_removeActionFromObject;

};

//Supports

Action4ct = {

	private ["_trg","_chosen","_HQ","_dist"];

	if not (isnil "LeaderHQ") then {if ((group (_this select 0)) in ((group LeaderHQ) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQ)}};
	if not (isnil "LeaderHQB") then {if ((group (_this select 0)) in ((group LeaderHQB) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQB)}};
	if not (isnil "LeaderHQC") then {if ((group (_this select 0)) in ((group LeaderHQC) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQC)}};
	if not (isnil "LeaderHQD") then {if ((group (_this select 0)) in ((group LeaderHQD) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQD)}};
	if not (isnil "LeaderHQE") then {if ((group (_this select 0)) in ((group LeaderHQE) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQE)}};
	if not (isnil "LeaderHQF") then {if ((group (_this select 0)) in ((group LeaderHQF) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQF)}};
	if not (isnil "LeaderHQG") then {if ((group (_this select 0)) in ((group LeaderHQG) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQG)}};
	if not (isnil "LeaderHQH") then {if ((group (_this select 0)) in ((group LeaderHQH) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQH)}};

	[(_this select 0), 'Command, requesting close air support at our position - Over'] remoteExecCall ["RYD_MP_Sidechat"];

	sleep 3;

	_trg = (_this select 0) findNearestEnemy (position (_this select 0));

	if (_trg isEqualTo objNull) exitwith {[leader _HQ, (groupId (group (_this select 0))) + ', negative. No valid targets have been spotted by your squad - Out'] remoteExecCall ["RYD_MP_Sidechat"]};

	_trg = (vehicle (leader (group _trg)));

	_chosen = grpNull;

	_dist = 10000000;

	{
	
	if (not (_x getvariable [("Busy" + (str _x)),false]) and not (_x getvariable ["Unable",false]) and (((_this select 0) distance2D (leader _x)) < _dist)) then {_chosen = _x; _dist = ((_this select 0) distance2D (leader _x));};
	
	} forEach ((_HQ getVariable ["RydHQ_AirG",[]]) - ((_HQ getVariable ["RydHQ_NCAirG",[]]) + (_HQ getVariable ["RydHQ_NCrewInfG",[]])));

	if (_chosen isEqualTo grpNull) exitwith {[leader _HQ, (groupId (group (_this select 0))) + ', negative. No air support units are available at the moment - Out'] remoteExecCall ["RYD_MP_Sidechat"]};

	if (((_this select 0) distance2D _trg) < 2000) then {
	_chosen setVariable ["Busy" + (str _chosen),true];
	_HQ setVariable ["RydHQ_AttackAv",(_HQ getVariable ["RydHQ_AttackAv",[]]) - [_chosen]];
								
	[[_chosen,_trg,_HQ],(["AIR"] call RYD_GoLaunch)] call RYD_Spawn;

	[leader _HQ, (groupId (group (_this select 0))) + ', ' + (groupId _chosen) + ' has been dispatched for CAS - Out'] remoteExecCall ["RYD_MP_Sidechat"];

	} else {

	[leader _HQ, (groupId (group (_this select 0))) + ', negative. No valid targets have been spotted nearby your position - Out'] remoteExecCall ["RYD_MP_Sidechat"];

	};

};

Action4fnc = {

	private ["_Unit","_Action"];

	_Unit = _this select 0;

	_Action = _Unit addAction ["[HAL] Request Air Support", 
		"
		[_this select 3] remoteExec ['Action4ct',2]
		"
		, 
		_Unit,-1.6,false,false,"","true",0.01];
	
	_Unit setVariable ["HAL_ReqAirID",_Action];

};

ACEAction4fnc = {

	private ["_Unit","_ACEAction","_ACEActionR"];

	_Unit = _this select 0;

	_ACEActionR = ["ACEActionR","HAL Supports","",{},{true}] call ace_interact_menu_fnc_createAction;

	[_Unit, 1, ["ACE_SelfActions"], _ACEActionR] call ace_interact_menu_fnc_addActionToObject;

	_ACEAction = ["HALReqAir","Request Air Support","",{

		[_target] remoteExec ['Action4ct',2]

		},{true},{}] call ace_interact_menu_fnc_createAction;

	[_Unit, 1, ["ACE_SelfActions","ACEActionR"], _ACEAction] call ace_interact_menu_fnc_addActionToObject;


};

Action4fncR = {

	private ["_Unit","_Action"];

	_Unit = _this select 0;

	_Action = _Unit getVariable "HAL_ReqAirID";
	_Unit removeAction _Action;

};

ACEAction4fncR = {

	private ["_Unit"];

	_Unit = _this select 0;

	[_Unit,1,["ACE_SelfActions","ACEActionR","HALReqAir"]] call ace_interact_menu_fnc_removeActionFromObject;

};

Action5ct = {

	private ["_trg","_chosen","_HQ","_dist"];

	if not (isnil "LeaderHQ") then {if ((group (_this select 0)) in ((group LeaderHQ) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQ)}};
	if not (isnil "LeaderHQB") then {if ((group (_this select 0)) in ((group LeaderHQB) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQB)}};
	if not (isnil "LeaderHQC") then {if ((group (_this select 0)) in ((group LeaderHQC) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQC)}};
	if not (isnil "LeaderHQD") then {if ((group (_this select 0)) in ((group LeaderHQD) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQD)}};
	if not (isnil "LeaderHQE") then {if ((group (_this select 0)) in ((group LeaderHQE) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQE)}};
	if not (isnil "LeaderHQF") then {if ((group (_this select 0)) in ((group LeaderHQF) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQF)}};
	if not (isnil "LeaderHQG") then {if ((group (_this select 0)) in ((group LeaderHQG) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQG)}};
	if not (isnil "LeaderHQH") then {if ((group (_this select 0)) in ((group LeaderHQH) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQH)}};

	[(_this select 0), 'Command, requesting infantry support at our position - Over'] remoteExecCall ["RYD_MP_Sidechat"];

	sleep 3;

	_trg = (_this select 0) findNearestEnemy (position (_this select 0));

	if (_trg isEqualTo objNull) exitwith {[leader _HQ, (groupId (group (_this select 0))) + ', negative. No valid targets have been spotted by your squad - Out'] remoteExecCall ["RYD_MP_Sidechat"]};

	_trg = (vehicle (leader (group _trg)));

	_chosen = grpNull;

	_dist = 10000000;

	{
	
	if (not (_x getvariable [("Busy" + (str _x)),false]) and not (_x getvariable ["Unable",false]) and (((_this select 0) distance2D (leader _x)) < _dist)) then {_chosen = _x; _dist = ((_this select 0) distance2D (leader _x));};
	
	} forEach (((_HQ getVariable ["RydHQ_NCrewInfG",[]]) - (_HQ getVariable ["RydHQ_SpecForG",[]])) + ((_HQ getVariable ["RydHQ_CarsG",[]]) - ((_HQ getVariable ["RydHQ_ATInfG",[]]) + (_HQ getVariable ["RydHQ_AAInfG",[]]) + (_HQ getVariable ["RydHQ_SupportG",[]]) + (_HQ getVariable ["RydHQ_NCCargoG",[]]))));

	if (_chosen isEqualTo grpNull) exitwith {[leader _HQ, (groupId (group (_this select 0))) + ', negative. No infantry squads are available at the moment - Out'] remoteExecCall ["RYD_MP_Sidechat"]};

	if (((_this select 0) distance2D _trg) < 2000) then {
	_chosen setVariable ["Busy" + (str _chosen),true];
	_HQ setVariable ["RydHQ_AttackAv",(_HQ getVariable ["RydHQ_AttackAv",[]]) - [_chosen]];
								
	[[_chosen,_trg,_HQ],(["INF"] call RYD_GoLaunch)] call RYD_Spawn;

	[leader _HQ, (groupId (group (_this select 0))) + ', ' + (groupId _chosen) + ' has been dispatched - Out'] remoteExecCall ["RYD_MP_Sidechat"];

	} else {

	[leader _HQ, (groupId (group (_this select 0))) + ', negative. No valid targets have been spotted nearby your position - Out'] remoteExecCall ["RYD_MP_Sidechat"];

	};

};

Action5fnc = {

	private ["_Unit","_Action"];

	_Unit = _this select 0;

	_Action = _Unit addAction ["[HAL] Request Infantry Support", 
		"
		[_this select 3] remoteExec ['Action5ct',2]
		"
		, 
		_Unit,-1.6,false,false,"","true",0.01];
	
	_Unit setVariable ["HAL_ReqInfID",_Action];

};

ACEAction5fnc = {

	private ["_Unit","_ACEAction"];

	_Unit = _this select 0;

	_ACEAction = ["HALReqInf","Request Infantry Support","",{

		[_target] remoteExec ['Action5ct',2]

		},{true},{}] call ace_interact_menu_fnc_createAction;

	[_Unit, 1, ["ACE_SelfActions","ACEActionR"], _ACEAction] call ace_interact_menu_fnc_addActionToObject;


};

Action5fncR = {

	private ["_Unit","_Action"];

	_Unit = _this select 0;

	_Action = _Unit getVariable "HAL_ReqInfID";
	_Unit removeAction _Action;

};

ACEAction5fncR = {

	private ["_Unit"];

	_Unit = _this select 0;

	[_Unit,1,["ACE_SelfActions","ACEActionR","HALReqInf"]] call ace_interact_menu_fnc_removeActionFromObject;

};

Action6ct = {

	private ["_trg","_chosen","_HQ","_dist"];

	if not (isnil "LeaderHQ") then {if ((group (_this select 0)) in ((group LeaderHQ) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQ)}};
	if not (isnil "LeaderHQB") then {if ((group (_this select 0)) in ((group LeaderHQB) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQB)}};
	if not (isnil "LeaderHQC") then {if ((group (_this select 0)) in ((group LeaderHQC) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQC)}};
	if not (isnil "LeaderHQD") then {if ((group (_this select 0)) in ((group LeaderHQD) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQD)}};
	if not (isnil "LeaderHQE") then {if ((group (_this select 0)) in ((group LeaderHQE) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQE)}};
	if not (isnil "LeaderHQF") then {if ((group (_this select 0)) in ((group LeaderHQF) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQF)}};
	if not (isnil "LeaderHQG") then {if ((group (_this select 0)) in ((group LeaderHQG) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQG)}};
	if not (isnil "LeaderHQH") then {if ((group (_this select 0)) in ((group LeaderHQH) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQH)}};

	[(_this select 0), 'Command, requesting armored support at our position - Over'] remoteExecCall ["RYD_MP_Sidechat"];

	sleep 3;

	_trg = (_this select 0) findNearestEnemy (position (_this select 0));

	if (_trg isEqualTo objNull) exitwith {[leader _HQ, (groupId (group (_this select 0))) + ', negative. No valid targets have been spotted by your squad - Out'] remoteExecCall ["RYD_MP_Sidechat"]};

	_trg = (vehicle (leader (group _trg)));

	_chosen = grpNull;

	_dist = 10000000;

	{
	
	if (not (_x getvariable [("Busy" + (str _x)),false]) and not (_x getvariable ["Unable",false]) and (((_this select 0) distance2D (leader _x)) < _dist)) then {_chosen = _x; _dist = ((_this select 0) distance2D (leader _x));};
	
	} forEach ((_HQ getVariable ["RydHQ_HArmorG",[]]) + (_HQ getVariable ["RydHQ_LArmorATG",[]]));

	if (_chosen isEqualTo grpNull) exitwith {[leader _HQ, (groupId (group (_this select 0))) + ', negative. No armored units are available at the moment - Out'] remoteExecCall ["RYD_MP_Sidechat"]};

	if (((_this select 0) distance2D _trg) < 2000) then {
	_chosen setVariable ["Busy" + (str _chosen),true];
	_HQ setVariable ["RydHQ_AttackAv",(_HQ getVariable ["RydHQ_AttackAv",[]]) - [_chosen]];
								
	[[_chosen,_trg,_HQ],(["ARM"] call RYD_GoLaunch)] call RYD_Spawn;

	[leader _HQ, (groupId (group (_this select 0))) + ', ' + (groupId _chosen) + ' has been dispatched - Out'] remoteExecCall ["RYD_MP_Sidechat"];

	} else {

	[leader _HQ, (groupId (group (_this select 0))) + ', negative. No valid targets have been spotted nearby your position - Out'] remoteExecCall ["RYD_MP_Sidechat"];

	};

};

Action6fnc = {

	private ["_Unit","_Action"];

	_Unit = _this select 0;

	_Action = _Unit addAction ["[HAL] Request Armored Support", 
		"
		[_this select 3] remoteExec ['Action6ct',2]
		"
		, 
		_Unit,-1.6,false,false,"","true",0.01];
	
	_Unit setVariable ["HAL_ReqArmID",_Action];

};

ACEAction6fnc = {

	private ["_Unit","_ACEAction"];

	_Unit = _this select 0;

	_ACEAction = ["HALReqArm","Request Armored Support","",{

		[_target] remoteExec ['Action6ct',2]

		},{true},{}] call ace_interact_menu_fnc_createAction;

	[_Unit, 1, ["ACE_SelfActions","ACEActionR"], _ACEAction] call ace_interact_menu_fnc_addActionToObject;


};

Action6fncR = {

	private ["_Unit","_Action"];

	_Unit = _this select 0;

	_Action = _Unit getVariable "HAL_ReqArmID";
	_Unit removeAction _Action;

};

ACEAction6fncR = {

	private ["_Unit"];

	_Unit = _this select 0;

	[_Unit,1,["ACE_SelfActions","ACEActionR","HALReqArm"]] call ace_interact_menu_fnc_removeActionFromObject;
//	[_Unit,1,["ACE_SelfActions","ACEActionR"]] call ace_interact_menu_fnc_removeActionFromObject;

};

Action7ct = {

	private ["_unitvar","_chosen","_HQ","_dist"];

	if not (isnil "LeaderHQ") then {if ((group (_this select 0)) in ((group LeaderHQ) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQ)}};
	if not (isnil "LeaderHQB") then {if ((group (_this select 0)) in ((group LeaderHQB) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQB)}};
	if not (isnil "LeaderHQC") then {if ((group (_this select 0)) in ((group LeaderHQC) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQC)}};
	if not (isnil "LeaderHQD") then {if ((group (_this select 0)) in ((group LeaderHQD) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQD)}};
	if not (isnil "LeaderHQE") then {if ((group (_this select 0)) in ((group LeaderHQE) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQE)}};
	if not (isnil "LeaderHQF") then {if ((group (_this select 0)) in ((group LeaderHQF) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQF)}};
	if not (isnil "LeaderHQG") then {if ((group (_this select 0)) in ((group LeaderHQG) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQG)}};
	if not (isnil "LeaderHQH") then {if ((group (_this select 0)) in ((group LeaderHQH) getVariable ["RydHQ_Friends",[]])) then {_HQ = (group LeaderHQH)}};

	[(_this select 0), 'Command, requesting airlift at our position - Over'] remoteExecCall ["RYD_MP_Sidechat"];

	_unitvar = str (group (_this select 0));

	if not ((group (_this select 0)) getVariable [("CC" + _unitvar), true]) exitwith {[leader _HQ, (groupId (group (_this select 0))) + ', negative. air transport already assigned - Out'] remoteExecCall ["RYD_MP_Sidechat"]};

	(group (_this select 0)) setVariable [("CC" + _unitvar), false];

	[[(group (_this select 0)),_HQ,[0,0],false,true],HAL_SCargo] call RYD_Spawn;

	sleep 15;

	if ((group (_this select 0)) getVariable [("CC" + _unitvar), false]) exitwith {[leader _HQ, (groupId (group (_this select 0))) + ', negative. No air assets are available - Out'] remoteExecCall ["RYD_MP_Sidechat"]};

	[leader _HQ, (groupId (group (_this select 0))) + ', affirmative. Air transport has been assigned - Out'] remoteExecCall ["RYD_MP_Sidechat"];

};

Action7fnc = {

	private ["_Unit","_Action"];

	_Unit = _this select 0;

	_Action = _Unit addAction ["[HAL] Request Transport Support", 
		"
		[_this select 3] remoteExec ['Action7ct',2]
		"
		, 
		_Unit,-1.6,false,false,"","true",0.01];
	
	_Unit setVariable ["HAL_ReqTraID",_Action];

};

ACEAction7fnc = {

	private ["_Unit","_ACEAction"];

	_Unit = _this select 0;

	_ACEAction = ["HALReqTra","Request Transport Support","",{

		[_target] remoteExec ['Action7ct',2]

		},{true},{}] call ace_interact_menu_fnc_createAction;

	[_Unit, 1, ["ACE_SelfActions","ACEActionR"], _ACEAction] call ace_interact_menu_fnc_addActionToObject;


};

Action7fncR = {

	private ["_Unit","_Action"];

	_Unit = _this select 0;

	_Action = _Unit getVariable "HAL_ReqTraID";
	_Unit removeAction _Action;

};

ACEAction7fncR = {

	private ["_Unit"];

	_Unit = _this select 0;

	[_Unit,1,["ACE_SelfActions","ACEActionR","HALReqTra"]] call ace_interact_menu_fnc_removeActionFromObject;
	[_Unit,1,["ACE_SelfActions","ACEActionR"]] call ace_interact_menu_fnc_removeActionFromObject;

};