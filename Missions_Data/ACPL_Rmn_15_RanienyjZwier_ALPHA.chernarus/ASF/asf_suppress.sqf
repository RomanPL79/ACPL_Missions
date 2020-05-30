private ["_asf_units","_asf_vehicles"];

// Params
_gunnerArray = _this param [0, [],[[]]];
_preposArray = _this param [1, [],[[]]];
_forSeconds = _this param [2, 60, [60]];
_sleepTime = _this param [3,[],[]];
_rearm = _this param [4, true, [true]];

_posArray = _preposArray select 0;
//_gunnerArray = _pregunnerArray select 0;

//_gunnerArray = [veh1,veh2,veh3,u1,u2,u3,u4,u5,u6,rt1,rt2,rt3,group1];
//1 groupChat (format ["%1",_posArray]);


//_gunnerArray = [];
//_gunnerArray pushback gunnerArray2;



// Covert Pos array into real pos

_allPos = [];
_allPosTurr = [];
{
	if !(isNil "_x") then {
		_posX = getPosASL _x;
		if (str _posX != "[0,0,0]") then {
			_allPos pushBack _posX;
		};
	};
} forEach _posArray;

{
	if !(isNil "_x") then {
		_posX = _x call BIS_fnc_position;
		if (str _posX != "[0,0,0]") then {
			_allPosTurr pushBack _posX;
		};
	};
} forEach _posArray;

// Split Units and vehicles; 
_asf_units = [];
_asf_vehicles = [];

{

	private "_unit";
	_unit = _x;
	switch (typeName _unit) do {
		case "GROUP": {
			{		
				if (_x isKindOf "man") then {
					_asf_units pushBack _x; 
				} else {
					_asf_vehicles pushBack _x; 
				};
						
			} forEach units _unit; 
		};
		case "OBJECT": {	
			if (_unit isKindOf "man") then {
				_asf_units pushBack _unit; 
			} else {
				_asf_vehicles pushBack _unit; 
			};
			
		};
	};
} forEach _gunnerArray;



// Set combat mode of units:
{
	_x setBehaviour "careless";
	_x setCombatMode "BLUE";
	_unit = _x; 
	{_unit reveal [_x,4];} forEach allUnits;
	_x forceSpeed 0;
	
	
} forEach _asf_units; 

{
	_x setVehicleAmmo 1; 
} forEach _asf_vehicles; 

sleep (random [0.5, 0.7, 1]);

_endTime = time + _forSeconds;

{
group _x enableAttack false;
doStop _x;
_x disableAI "TARGET";
_x disableAI "AUTOTARGET";


} forEach _gunnerArray;


While {time < _endTime} do {

	{

		{
			if (alive _x) then {
			
				
				
				
				//_x doWatch (_allPos call BIS_fnc_selectRandom);
				//
				
				
				_x doSuppressiveFire (_allPos call BIS_fnc_selectRandom);
				_knowledge = (_x knowsAbout (_posArray select 0));
				
				//x1 groupChat (format ["%1",currentCommand s1]);
				sleep 1;
				while {(currentCommand _x == "Suppress")} do {
				_x forceWeaponFire [(primaryWeapon _x), "FullAuto"];
				_x forceWeaponFire [(primaryWeapon _x), "Manual"];
				sleep random _sleepTime;
				};
			
				if(((_x ammo primaryWeapon _x)==0)&&(_rearm)) then {
				_x setAmmo [(primaryWeapon _x), 1000];
				};
	
				
					
			} else {
				_asf_units = _asf_units - [_x];
			};
		} forEach _asf_units;

		{
			if (canFire _x) then { 
				if _rearm then {
					//_x setVehicleAmmo 1; 
				};
				gunner _x doWatch (_allPosTurr call BIS_fnc_selectRandom); 
				sleep random _sleepTime;
				_x action ["useWeapon", _x, gunner _x,1];
				_knowledge = (_x knowsAbout (_posArray select 0));			
			} else {
				//_asf_vehicles = _asf_vehicles - [_x];
				_x setVehicleAmmo 1;
			};
		} forEach _asf_vehicles; 
		
	} forEach _gunnerArray;
	
};


{
_x setVariable ["ASF_AI", 1];
_x setVariable ["ASF_READY", 1];


} forEach _gunnerArray;



true;