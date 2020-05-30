while {true} do {

	private ["_HalFriends"];

	if (isNil ("LeaderHQ")) then {LeaderHQ = objNull};
	if (isNil ("LeaderHQB")) then {LeaderHQB = objNull};
	if (isNil ("LeaderHQC")) then {LeaderHQC = objNull};
	if (isNil ("LeaderHQD")) then {LeaderHQD = objNull};
	if (isNil ("LeaderHQE")) then {LeaderHQE = objNull};
	if (isNil ("LeaderHQF")) then {LeaderHQF = objNull};
	if (isNil ("LeaderHQG")) then {LeaderHQG = objNull};
	if (isNil ("LeaderHQH")) then {LeaderHQH = objNull};


	_HalFriends = (group LeaderHQ getVariable ["RydHQ_Friends",[]]) + (group LeaderHQB getVariable ["RydHQ_Friends",[]]) + (group LeaderHQC getVariable ["RydHQ_Friends",[]]) + (group LeaderHQD getVariable ["RydHQ_Friends",[]]) + (group LeaderHQE getVariable ["RydHQ_Friends",[]]) + (group LeaderHQF getVariable ["RydHQ_Friends",[]]) + (group LeaderHQG getVariable ["RydHQ_Friends",[]]) + (group LeaderHQH getVariable ["RydHQ_Friends",[]]);


	{
		private ["_IsHal"];

		if ((group _x in _HalFriends) or ((group _x) getVariable ["EnableHALActions",false])) then {
			_IsHal = true;
		} else {
			_IsHal = false;
		};

		//Tasking

		if (RydHQ_TaskActions) then {
		
			if ((_x == leader _x) and not (_x getVariable ["HAL_Task1Added",false]) and (_IsHal)) then {

				if not (RydHQ_ActionsAceOnly) then {

					[_x] remoteExecCall ["Action1fnc",_x];
				};

				if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

					[_x] remoteExecCall ["ACEAction1fnc",_x];				
					
				};
				_x setVariable ["HAL_Task1Added",true];
			};

			if ((_x == leader _x) and not (_x getVariable ["HAL_Task2Added",false]) and (_IsHal)) then {

				if not (RydHQ_ActionsAceOnly) then {

					[_x] remoteExecCall ["Action2fnc",_x];
					
				};

				if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

					[_x] remoteExecCall ["ACEAction2fnc",_x];
					
				};

				_x setVariable ["HAL_Task2Added",true];
			};

			if ((_x == leader _x) and not (_x getVariable ["HAL_Task3Added",false]) and (_IsHal)) then {

				if not (RydHQ_ActionsAceOnly) then {

					[_x] remoteExecCall ["Action3fnc",_x];
					
				};

				if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

					[_x] remoteExecCall ["ACEAction3fnc",_x];
					
				};

				_x setVariable ["HAL_Task3Added",true];
			};

			if ((not (_x == leader _x) and (_x getVariable ["HAL_Task1Added",false])) or (not (_IsHal) and (_x getVariable ["HAL_Task1Added",false]))) then {

				if not (RydHQ_ActionsAceOnly) then {

					[_x] remoteExecCall ["Action1fncR",_x];

				};
				if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

					[_x] remoteExecCall ["ACEAction1fncR",_x];

				};
				_x setVariable ["HAL_Task1Added",false];

			};

			if ((not (_x == leader _x) and (_x getVariable ["HAL_Task2Added",false])) or (not (_IsHal) and (_x getVariable ["HAL_Task2Added",false]))) then {

				if not (RydHQ_ActionsAceOnly) then {

					[_x] remoteExecCall ["Action2fncR",_x];
					
				};
				if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

					[_x] remoteExecCall ["ACEAction2fncR",_x];

				};
				_x setVariable ["HAL_Task2Added",false];

			};

			if ((not (_x == leader _x) and (_x getVariable ["HAL_Task3Added",false])) or (not (_IsHal) and (_x getVariable ["HAL_Task3Added",false]))) then {

				if not (RydHQ_ActionsAceOnly) then {

					[_x] remoteExecCall ["Action3fncR",_x];
					
				};
				if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

					[_x] remoteExecCall ["ACEAction3fncR",_x];
					
				};
				_x setVariable ["HAL_Task3Added",false];

			};
		
		};

		//Supports

		if (RydHQ_SupportActions) then {

			if ((_x == leader _x) and not (_x getVariable ["HAL_Task4Added",false]) and (_IsHal)) then {

				if not (RydHQ_ActionsAceOnly) then {

					[_x] remoteExecCall ["Action4fnc",_x];
					
				};

				if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

					[_x] remoteExecCall ["ACEAction4fnc",_x];
					
				};

				_x setVariable ["HAL_Task4Added",true];
			};

			if ((not (_x == leader _x) and (_x getVariable ["HAL_Task4Added",false])) or (not (_IsHal) and (_x getVariable ["HAL_Task4Added",false]))) then {

				if not (RydHQ_ActionsAceOnly) then {

					[_x] remoteExecCall ["Action4fncR",_x];
					
				};
				if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

					[_x] remoteExecCall ["ACEAction4fncR",_x];

				};
				_x setVariable ["HAL_Task4Added",false];

			};

			if ((_x == leader _x) and not (_x getVariable ["HAL_Task5Added",false]) and (_IsHal)) then {

				if not (RydHQ_ActionsAceOnly) then {

					[_x] remoteExecCall ["Action5fnc",_x];
					
				};

				if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

					[_x] remoteExecCall ["ACEAction5fnc",_x];
					
				};

				_x setVariable ["HAL_Task5Added",true];
			};

			if ((not (_x == leader _x) and (_x getVariable ["HAL_Task5Added",false])) or (not (_IsHal) and (_x getVariable ["HAL_Task5Added",false]))) then {

				if not (RydHQ_ActionsAceOnly) then {

					[_x] remoteExecCall ["Action5fncR",_x];
					
				};
				if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

					[_x] remoteExecCall ["ACEAction5fncR",_x];

				};
				_x setVariable ["HAL_Task5Added",false];

			};

			if ((_x == leader _x) and not (_x getVariable ["HAL_Task6Added",false]) and (_IsHal)) then {

				if not (RydHQ_ActionsAceOnly) then {

					[_x] remoteExecCall ["Action6fnc",_x];
					
				};

				if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

					[_x] remoteExecCall ["ACEAction6fnc",_x];
					
				};

				_x setVariable ["HAL_Task6Added",true];
			};

			if ((not (_x == leader _x) and (_x getVariable ["HAL_Task6Added",false])) or (not (_IsHal) and (_x getVariable ["HAL_Task6Added",false]))) then {

				if not (RydHQ_ActionsAceOnly) then {

					[_x] remoteExecCall ["Action6fncR",_x];
					
				};
				if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

					[_x] remoteExecCall ["ACEAction6fncR",_x];

				};
				_x setVariable ["HAL_Task6Added",false];

			};

			if ((_x == leader _x) and not (_x getVariable ["HAL_Task7Added",false]) and (_IsHal)) then {

				if not (RydHQ_ActionsAceOnly) then {

					[_x] remoteExecCall ["Action7fnc",_x];
					
				};

				if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

					[_x] remoteExecCall ["ACEAction7fnc",_x];
					
				};

				_x setVariable ["HAL_Task7Added",true];
			};

			if ((not (_x == leader _x) and (_x getVariable ["HAL_Task7Added",false])) or (not (_IsHal) and (_x getVariable ["HAL_Task7Added",false]))) then {

				if not (RydHQ_ActionsAceOnly) then {

					[_x] remoteExecCall ["Action7fncR",_x];
					
				};
				if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

					[_x] remoteExecCall ["ACEAction7fncR",_x];

				};
				_x setVariable ["HAL_Task7Added",false];

			};
		};
		
	} forEach allplayers;

	sleep 15;
};