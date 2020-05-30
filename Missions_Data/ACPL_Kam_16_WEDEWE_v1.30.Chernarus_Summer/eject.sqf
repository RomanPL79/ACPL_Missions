

if (!isServer) exitWith {};
private ["_paras","_vehicle","_item","_item2"];
_vehicle = _this select 0;
_paras = [];
_crew = crew _vehicle;



{
    _isCrew = assignedVehicleRole _x;
        if(count _isCrew > 0) then
    {
        if((_isCrew select 0) == "Cargo") then
        {
        _paras pushback _x
        };
    };
} foreach _crew;

///Hotfix
//_paras pushback x18;

_chuteheight = if ( count _this > 1 ) then { _this select 1 } else { 120 };
_item = if ( count _this > 2 ) then {_this select 2} else {nil};
_item2 = if ( count _this > 3 ) then {_this select 3} else {nil};
_vehicle allowDamage false;
_dir = direction _vehicle;


ParaLandSafeAI =
{
    private ["_unit"];
    _unit = _this select 0;
    _chuteheight = _this select 1;
    (vehicle _unit) allowDamage false;
	waitUntil {(position _unit select 2) <= _chuteheight};
	_unit addBackPackGlobal "rhs_d6_Parachute_backpack";
	sleep 0.2;
	[_unit,["openParachute",_unit]] remoteExec ["action",_unit];
    waitUntil { isTouchingGround _unit || (position _unit select 2) < 1 };
	
	sleep 1;
	
	_unit setUnitLoadout (_unit getVariable ["Saved_Loadout",[]]);

	sleep 10;
	[_unit,true] remoteExec ["allowdamage",_unit];
};


ParaLandSafe =
{
    private ["_unit"];
    _unit = _this select 0;
    _chuteheight = _this select 1;
    (vehicle _unit) allowDamage false;
	waitUntil {(position _unit select 2) <= _chuteheight};
	sleep 0.2;
	[_unit,["openParachute",_unit]] remoteExec ["action",_unit];
    waitUntil { isTouchingGround _unit || (position _unit select 2) < 1 };
	sleep 10;
	[_unit,true] remoteExec ["allowdamage",_unit];
};


CargoLandSafe =
{
    private ["_unit"];
    _unit = _this select 0;
	waitUntil { isTouchingGround _unit || (position _unit select 2) < 2 };
    detach _unit;
	_unit SetVelocity [0,0,-5]; 
	sleep 0.3;
	_unit setPos [(position _unit) select 0, (position _unit) select 1, 1];
	_unit SetVelocity [0,0,0]; 
	sleep 2;
	_unit allowDamage true;
};


{
	if(!isPlayer _x) then {
	_x setVariable ["Saved_Loadout",getUnitLoadout _x];
    removeBackpack _x;
	};
	
    _x disableCollisionWith _vehicle;
    [_x,false] remoteExec ["allowdamage",_x];
    unassignvehicle _x;
    moveout _x;
    _x setDir (_dir + 90);
    _x setvelocity [0,0,-5];
    sleep 0.5;
	
	if(!isPlayer _x) then {
	[_x,_chuteheight] spawn ParaLandSafeAI;
	};
	
	if(isPlayer _x) then {
	[_x,_chuteheight] spawn ParaLandSafe;
	};
	
} forEach _paras;




if (!isNil ("_item")) then
{
_para = "B_Parachute_02_F" createVehicle [0,0,100];
_para setPos [(position _vehicle select 0) - (sin (getdir _vehicle)* 15), (position _vehicle select 1) - (cos (getdir _vehicle) * 15), (position _vehicle select 2)+2];
_CargoDrop = _item createVehicle getpos _vehicle;
_CargoDrop allowDamage false;
_CargoDrop disableCollisionWith _vehicle;
_CargoDrop setPos [(position _vehicle select 0) - (sin (getdir _vehicle)* 15), (position _vehicle select 1) - (cos (getdir _vehicle) * 15), (position _vehicle select 2)];
_CargoDrop attachTo [_para,[0,0,0]];
[_CargoDrop] spawn CargoLandSafe;

sleep 3;
_para2 = "B_Parachute_02_F" createVehicle [0,0,100];
_para2 setPos [(position _vehicle select 0) - (sin (getdir _vehicle)* 15), (position _vehicle select 1) - (cos (getdir _vehicle) * 15), (position _vehicle select 2)+2];
_CargoDrop2 = _item2 createVehicle getpos _vehicle;
_CargoDrop2 allowDamage false;
_CargoDrop2 disableCollisionWith _vehicle;
_CargoDrop2 setPos [(position _vehicle select 0) - (sin (getdir _vehicle)* 15), (position _vehicle select 1) - (cos (getdir _vehicle) * 15), (position _vehicle select 2)]; 
_CargoDrop2 attachTo [_para2,[0,0,0]]; 
[_CargoDrop2] spawn CargoLandSafe;

};

_vehicle allowDamage true;
