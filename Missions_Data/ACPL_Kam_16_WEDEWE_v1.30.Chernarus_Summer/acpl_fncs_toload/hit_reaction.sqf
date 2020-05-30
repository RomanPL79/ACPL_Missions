acpl_hit_drophelmet = {
	params ["_unit", "_velocity"];
	private ["_helmet", "_nvg", "_weaponHolder", "_random", "_dummy", "_weaponHolder0", "_new_velocity", "_moving", "_pos", "_vel", "_mass", "_dummy0"];
	
	_random = random 100;
	if ((_random < acpl_hit_helmet_chance) AND !(_unit getvariable "acpl_helmet")) then {
	
		_helmet = headgear _unit;
		if (_helmet != "") then {
			_nvg = hmd _unit;
			
			_new_velocity = [(_velocity select 0)/75,(_velocity select 1)/75,(_velocity select 2)/14];
			
			_mass = getNumber (configfile >> "CfgWeapons" >> _helmet >> "ItemInfo" >> "mass");
			
			_weaponHolder = "GroundWeaponHolder_Scripted" createVehicle [0,0,0];
			_weaponHolder addItemCargoGlobal [_helmet,1];
			[_unit] remoteExec ["removeHeadgear",0];
			
			_dummy = "ACE_Chemlight_IR_Dummy" createVehicle [0,0,0];
			_dummy enableSimulationGlobal true;
			_dummy allowdamage false;
			[_dummy, true] remoteExec ["hideobject",-2,true];
			
			_dummy setmass _mass;
			
			IF (_nvg != "") then {
				_dummy0 = "ACE_Chemlight_IR_Dummy" createVehicle [0,0,0];
				_dummy0 enableSimulationGlobal true;
				_dummy0 allowdamage false;
				[_dummy0, true] remoteExec ["hideobject",-2,true];
				
				[_unit, _nvg] remoteExec ["unlinkItem",0];
				_weaponHolder0 = "GroundWeaponHolder_Scripted" createVehicle [0,0,0];
				_weaponHolder0 addItemCargoGlobal [_nvg,1];
				_weaponHolder0 attachTo [_dummy0, [-0.1,-0.62,-0.7]];
			};
			
			_weaponHolder attachTo [_dummy, [-0.1,-0.62,-0.7]]; 
			_weaponHolder setVectorDirAndUp [[0, 0, 0.5],[0, -0.5, -1]];

			IF ("STAND" == stance _unit )  then {
				_dummy setPos (_unit modelToWorld [0.02,0.05,1.7]); 
				IF (_nvg != "") then {_dummy0 setPos (_unit modelToWorld [0.02,0.05,1.73]);};
			};

			IF ("CROUCH" == stance _unit ) then {
				_dummy setPos (_unit modelToWorld [0.02,0.05,1.1]); 
				IF (_nvg != "") then {_dummy0 setPos (_unit modelToWorld [0.02,0.05,1.13]);};	
			};

			IF ("PRONE" == stance _unit ) then {
				_dummy setPos (_unit modelToWorld [0.02,0.75,0.4]); 
				IF (_nvg != "") then {_dummy0 setPos (_unit modelToWorld [0.02,0.75,0.43]);};
			};

			IF ("UNDEFINED" == stance _unit ) then {
				_dummy setPos (_unit modelToWorld [0.02,0.05,1.4]); 
				IF (_nvg != "") then {_dummy0 setPos (_unit modelToWorld [0.02,0.05,1.43]);};
			};

			_dummy setDir (getdir _unit);
			IF (_nvg != "") then {_dummy0 setDir (getdir _unit);};

			_dummy setVelocity _new_velocity;
			IF (_nvg != "") then {
				_dummy0 setVelocity [(random 1), (random 1), (random 3)];
				
				[_dummy0, _weaponHolder0] spawn {
					params ["_dummy", "_weaponholder"];
					private ["_vel", "_pos", "_moving"];
					
					_moving = true;
					
					while {_moving} do {
					
						_vel = velocity _dummy;
						_pos = getposATL _dummy;
						
						if (((_vel select 0 == 0) AND (_vel select 1 == 0) AND (_vel select 2 == 0)) OR (_pos select 2 < 0)) then {
							detach _weaponholder;
							_weaponholder enableSimulationGlobal true;
							deletevehicle _dummy;
							_weaponHolder setdir (getDir _weaponHolder);
							_weaponholder setposATL _pos;
							_weaponholder setVelocity [0,0,0];
							
							_moving = false;
						};
						
						sleep 0.05;
					};
				};
			};
			
			_moving = true;
			
			while {_moving} do {
				
				_vel = velocity _dummy;
				_pos = getposATL _dummy;
				
				if (((_vel select 0 == 0) AND (_vel select 1 == 0) AND (_vel select 2 == 0)) OR (_pos select 2 < 0)) then {
					detach _weaponholder;
					_weaponholder enableSimulationGlobal true;
					deletevehicle _dummy;
					_weaponHolder setdir (getDir _weaponHolder);
					_weaponholder setposATL _pos;
					_weaponholder setVelocity [0,0,0];
					
					_moving = false;
				};
				
				sleep 0.05;
			};
		};
	};
};
publicvariable "acpl_hit_drophelmet";

acpl_hit_dropweapon = {
	params ["_unit"];
	private ["_weaponHolder", "_weapon", "_primary", "_random", "_weaponsItems", "_items", "_new_velocity", "_weaponHolder_dummy", "_dummy", "_attachments", "_magazines"];
	
	_primary = false;
	
	_random = random 100;
	
	if (alive _unit) then {
		_weapon = currentWeapon _unit;
		if (_weapon == primaryweapon _unit) then {_primary = true;};
		
		_new_velocity = [(random 2),(random 2),(random 1)];
		
		if ((_random < acpl_hit_weapon_chance) AND (_weapon != "")) then {
			
			if ((_primary) AND (_unit getvariable "acpl_weapon_fasten")) exitwith {};
			_weaponHolder = "GroundWeaponHolder_Scripted" createVehicle (getpos _unit);
			_weaponHolder_dummy = "GroundWeaponHolder_Scripted" createVehicle [0,0,0];
			
			_weaponHolder_dummy enableSimulationGlobal true;
			_weaponHolder enableSimulationGlobal true;
			
			[_weaponHolder, true] remoteExec ["hideobject",0,true];
			
			_dummy = "ACE_Chemlight_IR_Dummy" createVehicle [0,0,0];
			_dummy enableSimulationGlobal true;
			_dummy allowdamage false;
			[_dummy, true] remoteExec ["hideobject",-2,true];
			
			_weaponsItems = weaponsItems _unit;
			{
				if ((_x select 0) == _weapon) then {
					_items = _x;
				};
			} foreach _weaponsItems;
			
			[_unit,_weapon] remoteExec ["removeweapon",0];
			
			_weapon = [_weapon] call BIS_fnc_baseWeapon;
			_weaponHolder_dummy addweaponcargoglobal [_weapon, 1];
			_weaponHolder_dummy attachto [_dummy,[0,0,0.6]];
			
			_attachments = [];
			_magazines = [];
			
			if (count _items > 6) then
			{
				if ((_items select 1) != "") then {_attachments = _attachments + [(_items select 1)];};
				if ((_items select 2) != "") then {_attachments = _attachments + [(_items select 2)];};
				if ((_items select 3) != "") then {_attachments = _attachments + [(_items select 3)];};
				if (((_items select 4) select 0) != "") then {_magazines = _magazines + [(_items select 4)];};
				if (((_items select 5) select 0) != "") then {_magazines = _magazines + [(_items select 5)];};
				if ((_items select 6) != "") then {_attachments = _attachments + [(_items select 6)];};
			} else {
				if ((_items select 1) != "") then {_attachments = _attachments + [(_items select 1)];};
				if ((_items select 2) != "") then {_attachments = _attachments + [(_items select 2)];};
				if ((_items select 3) != "") then {_attachments = _attachments + [(_items select 3)];};
				if (((_items select 4) select 0) != "") then {_magazines = _magazines + [(_items select 4)];};
				if ((_items select 5) != "") then {_attachments = _attachments + [(_items select 5)];};
			};
			
			[_weaponHolder, _weapon, _attachments, _magazines] spawn acpl_drop_customweapon;
			
			If ("STAND" == stance _unit)  then {
				_dummy setPos (_unit modelToWorld [0,0.2,1.2]);
			};
			If ("CROUCH" == stance _unit) then {
				_dummy setPos (_unit modelToWorld [0,0.2,0.8]);
			};
			If ("PRONE" == stance _unit) then {
				_dummy setPos (_unit modelToWorld [0,0.7,0.2]); 
			};
			If ("UNDEFINED" == stance _unit) then {
				_dummy setPos (_unit modelToWorld [0,0.2,1.1]); 
			};
			
			_dummy setDir (getDir _unit);
			
			_dummy setVelocity _new_velocity;
			
			[_dummy] spawn {
				params ["_dummy"];
				private ["_moving", "_pos", "_vel"];
				
				_moving = true;
				
				while {_moving} do {
					_vel = velocity _dummy;
					_pos = getposATL _dummy;
					if (((_vel select 0 == 0) AND (_vel select 1 == 0) AND (_vel select 2 == 0)) OR (_pos select 2 < 0)) then {
						_dummy setVelocity [0,0,0];
						_dummy setposATL [(_pos select 0), (_pos select 1), 0];
						_dummy enableSimulationGlobal false;
						[_dummy, true] remoteExec ["hideobject",0,true];
						
						_moving = false;
					};
					
					sleep 0.05;
				};
			};
			
			waitUntil { (_weapon in ((getWeaponCargo _weaponHolder) select 0)) };
			_weaponHolder attachto [_dummy,[0,0,0.6]];
			[_weaponHolder, false] remoteExec ["hideobject",0,true];
			deletevehicle _weaponHolder_dummy;
			
			detach _weaponholder;
			_weaponholder enableSimulationGlobal true;
			_pos = getposATL _dummy;
			deletevehicle _dummy;
			_weaponholder setposATL _pos;
			_weaponholder setVelocity [0,0,0];
		};
	};
};
publicvariable "acpl_hit_dropweapon";

acpl_hit_fallonground = {
	params ["_unit"];
	private ["_random"];
	
	_random = random 100;
	
	if ((alive _unit) AND !(_unit getvariable "ace_isunconscious") AND (_random < acpl_hit_fallonground_chance)) then {
		if ("STAND" == stance _unit)  then {
			[_unit,"PlayerProne"] remoteExec ["playAction",0];
		};
		if ("CROUCH" == stance _unit) then {
			[_unit,"PlayerProne"] remoteExec ["playAction",0];
		};
		if ("PRONE" == stance _unit) exitwith {};
		if ("UNDEFINED" == stance _unit) exitwith {};
		
	};
};
publicvariable "acpl_hit_fallonground";