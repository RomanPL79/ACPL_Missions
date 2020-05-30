if (!isserver) exitwith {};

acpl_load_actions_HC = {
	params ["_unit"];
	
	acpl_hc_action = ["acpl_hc_action", "Take HC Command", "", {private ["_text"];[acpl_hc_unit] remoteExec ["hcRemoveAllGroups",0];{[_player,[_x]] remoteExec ["hcSetGroup",0];} foreach acpl_hc_groups;_text = (str (name _player) + " przejął kontrolę nad HC");[_text] remoteExec ["systemchat",acpl_hc_unit];acpl_hc_unit = _player;publicvariable "acpl_hc_unit";hint "Przejąłeś kontrole nad HC";}, {true}] call ace_interact_menu_fnc_createAction;
	
	publicvariable "acpl_hc_action";
};
publicvariable "acpl_load_actions_HC";

acpl_add_actions_HC = {
	params ["_unit"];
	
	[[(_unit), 1, ["ACE_SelfActions", "acpl_menu"], acpl_hc_action],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
};
publicvariable "acpl_add_actions_HC";

acpl_load_actions = {
	hidebody_act = ["acpl_hidebody", "Ukryj Ciało", "acpl_icons\hide.paa", {[_target] remoteExec ["hideBody",0,true];}, {!(alive _target)}] call ace_interact_menu_fnc_createAction;
	
	acpl_act_menu = ["acpl_menu", "ACPL", "", {}, {true}] call ace_interact_menu_fnc_createAction;
		
	radio_act = ["acpl_radio_menu", "Opcje Radia", "acpl_icons\radio.paa", {}, {(call TFAR_fnc_haveSWRadio) OR (call TFAR_fnc_haveLRRadio)}] call ace_interact_menu_fnc_createAction;
	radio_act_lower_sw = ["acpl_radio_lowerheadset_sw", "Zdejmij słuchawki (SW)", "acpl_icons\radio.paa", {private ["_volume"];_volume = (call TFAR_fnc_ActiveSwRadio) call TFAR_fnc_getSwVolume;_player setvariable ["acpl_radio_volume_sw",_volume,true];_player setvariable ["acpl_radio_lower_sw",true,true];[(call TFAR_fnc_ActiveSWRadio), 1] call TFAR_fnc_setSwVolume;hint "Zdjąłeś słuchawki z radia krótkiego";}, {(call TFAR_fnc_haveSWRadio) AND !(_player getvariable "acpl_radio_lower_sw")}] call ace_interact_menu_fnc_createAction;
	radio_act_onhead_sw = ["acpl_radio_headset_sw", "Załóż słuchawki (SW)", "acpl_icons\radio.paa", {_player setvariable ["acpl_radio_lower_sw",false,true];[(call TFAR_fnc_ActiveSWRadio), (_player getvariable "acpl_radio_volume_sw")] call TFAR_fnc_setSwVolume;hint "Założyłeś słuchawki z radia krótkiego";}, {(call TFAR_fnc_haveSWRadio) AND (_player getvariable "acpl_radio_lower_sw")}] call ace_interact_menu_fnc_createAction;
	radio_act_lower_lr = ["acpl_radio_lowerheadset_lr", "Zdejmij słuchawki (LR)", "acpl_icons\radio.paa", {private ["_volume"];_volume = (call TFAR_fnc_ActiveLrRadio) call TFAR_fnc_getLrVolume;_player setvariable ["acpl_radio_volume_lr",_volume,true];_player setvariable ["acpl_radio_lower_lr",true,true];[(call TFAR_fnc_ActiveLrRadio), 1] call TFAR_fnc_setLrVolume;hint "Zdjąłeś słuchawki z radia długiego";}, {(call TFAR_fnc_haveLRRadio) AND !(_player getvariable "acpl_radio_lower_lr")}] call ace_interact_menu_fnc_createAction;
	radio_act_onhead_lr = ["acpl_radio_headset_lr", "Załóż słuchawki (LR)", "acpl_icons\radio.paa", {_player setvariable ["acpl_radio_lower_lr",false,true];[(call TFAR_fnc_ActiveLRRadio), (_player getvariable "acpl_radio_volume_lr")] call TFAR_fnc_setLrVolume;hint "Założyłeś słuchawki z radia długiego";}, {(call TFAR_fnc_haveLRRadio) AND (_player getvariable "acpl_radio_lower_lr")}] call ace_interact_menu_fnc_createAction;
	radio_act_ask_sw = ["acpl_radio_ask_sw", "Poproś o pożyczenie radia (SW)", "acpl_icons\radio.paa", {
		if (isPlayer _target) then {
			["Zostałeś poproszony o pożyczenie radia (SW)"] remoteExec ["hint",_target];
			_target setVariable ["acpl_radio_asked_sw_target",_player,true];
			_target setVariable ["acpl_radio_asked_sw",true,true];
		} else {
			_target setVariable ["acpl_radio_asked_sw_target",_player,true];
			[[_target],acpl_tfr_giveradio_sw] remoteExec ["call",2];
		};
	}, {([_target] call acpl_tfr_check_swradio) AND !(_player getvariable "acpl_radio_borrowed_sw") AND !(_target getvariable "acpl_radio_borrowed_sw")}] call ace_interact_menu_fnc_createAction;
	radio_act_ask_lr = ["acpl_radio_ask_lr", "Poproś o pożyczenie radia (LR)", "acpl_icons\radio.paa", {
		if (isPlayer _target) then {
			["Zostałeś poproszony o pożyczenie radia (LR)"] remoteExec ["hint",_target];
			_target setVariable ["acpl_radio_asked_lr_target",_player,true];
			_target setVariable ["acpl_radio_asked_lr",true,true];
		} else {
			_target setVariable ["acpl_radio_asked_lr_target",_player,true];
			[[_target],acpl_tfr_giveradio_lr] remoteExec ["call",2];
		};
	}, {([_target] call acpl_tfr_check_lrradio) AND !(_player getvariable "acpl_radio_borrowed_lr") AND !(_target getvariable "acpl_radio_borrowed_lr")}] call ace_interact_menu_fnc_createAction;
	radio_act_2 = ["acpl_radio_menu_2", "Radio", "acpl_icons\radio.paa", {}, {([_target] call acpl_tfr_check_swradio) OR ([_target] call acpl_tfr_check_lrradio)}] call ace_interact_menu_fnc_createAction;
	radio_act_asked_sw = ["acpl_radio_asked_sw_act", "Podaj radio (SW)", "acpl_icons\radio.paa", {[[_player],acpl_tfr_giveradio_sw] remoteExec ["call",2];}, {(_player getvariable "acpl_radio_asked_sw") AND !(_player getvariable "acpl_radio_borrowed_sw")}] call ace_interact_menu_fnc_createAction;
	radio_act_asked_lr = ["acpl_radio_asked_lr_act", "Podaj radio (LR)", "acpl_icons\radio.paa", {[[_player],acpl_tfr_giveradio_lr] remoteExec ["call",2];}, {(_player getvariable "acpl_radio_asked_lr") AND !(_player getvariable "acpl_radio_borrowed_lr")}] call ace_interact_menu_fnc_createAction;
	radio_act_return_sw = ["acpl_radio_return_sw", "Oddaj radio (SW)", "acpl_icons\radio.paa", {[[_player],acpl_tfr_giveback_sw] remoteExec ["call",2];}, {(_player getvariable "acpl_radio_borrowed_sw")}] call ace_interact_menu_fnc_createAction;
	radio_act_return_lr = ["acpl_radio_return_lr", "Oddaj radio (LR)", "acpl_icons\radio.paa", {[[_player],acpl_tfr_giveback_lr] remoteExec ["call",2];}, {(_player getvariable "acpl_radio_borrowed_lr")}] call ace_interact_menu_fnc_createAction;
	
	acpl_act_animations = ["acpl_animations", "Animacje", "acpl_icons\anim.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
	acpl_act_piss = ["acpl_piss", "Sikaj", "acpl_icons\anim.paa", {[_player] spawn acpl_piss;}, {true}] call ace_interact_menu_fnc_createAction;
	acpl_act_pushup = ["acpl_pushup", "Rób pompki", "acpl_icons\anim.paa", {[_player,"AmovPercMstpSnonWnonDnon_exercisePushup"] remoteExec ["playMove",0];}, {true}] call ace_interact_menu_fnc_createAction;
	
	acpl_unlock_action_act = ["acpl_ai_action", "Odblokuj AI", "acpl_icons\run.paa", {{[_x,"move"] remoteExec ["enableAI",0];} foreach (units (group _player));hint "Odblokowałeś AI w swojej grupie";}, {_player == leader (group _player)}] call ace_interact_menu_fnc_createAction;

	acpl_helmet_fast_act = ["acpl_helmet_fast", "Zapnij Hełm", "acpl_icons\helmet.paa", {_player setVariable ["acpl_helmet",true,true];hint "Zapiąłeś swój hełm";}, {!(_player getvariable "acpl_helmet") AND (headgear _player != "")}] call ace_interact_menu_fnc_createAction;
	acpl_helmet_unfast_act = ["acpl_helmet_unfast", "Odepnij Hełm", "acpl_icons\helmet.paa", {_player setVariable ["acpl_helmet",false,true];hint "Odpiąłeś swój hełm";}, {(_player getvariable "acpl_helmet") AND (headgear _player != "")}] call ace_interact_menu_fnc_createAction;

	acpl_weapon_fast_act = ["acpl_weapon_fast", "Przypnij Karabin", "acpl_icons\gun.paa", {_player setVariable ["acpl_weapon_fasten",true,true];hint "Przypiąłeś swój karabin";}, {!(_player getvariable "acpl_weapon_fasten") AND (primaryweapon _player != "")}] call ace_interact_menu_fnc_createAction;
	acpl_weapon_unfast_act = ["acpl_weapon_unfast", "Odepnij Karabin", "acpl_icons\gun.paa", {_player setVariable ["acpl_weapon_fasten",false,true];hint "Odpiąłeś swój karabin";}, {(_player getvariable "acpl_weapon_fasten") AND (primaryweapon _player != "")}] call ace_interact_menu_fnc_createAction;
};
publicvariable "acpl_load_actions";

acpl_add_actions = {
	params ["_unit"];
	
	[[_unit, 1, ["ACE_SelfActions"], acpl_act_menu],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	
	[[_unit, 1, ["ACE_SelfActions", "acpl_menu"], radio_act],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 1, ["ACE_SelfActions", "acpl_menu","acpl_radio_menu"], radio_act_lower_sw],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 1, ["ACE_SelfActions", "acpl_menu","acpl_radio_menu"], radio_act_onhead_sw],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 1, ["ACE_SelfActions", "acpl_menu","acpl_radio_menu"], radio_act_lower_lr],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 1, ["ACE_SelfActions", "acpl_menu","acpl_radio_menu"], radio_act_onhead_lr],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 0, ["ACE_MainActions"], radio_act_2],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 0, ["ACE_MainActions","acpl_radio_menu_2"], radio_act_ask_sw],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 0, ["ACE_MainActions","acpl_radio_menu_2"], radio_act_ask_lr],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 1, ["ACE_SelfActions", "acpl_menu","acpl_radio_menu"], radio_act_asked_sw],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 1, ["ACE_SelfActions", "acpl_menu","acpl_radio_menu"], radio_act_asked_lr],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 1, ["ACE_SelfActions", "acpl_menu","acpl_radio_menu"], radio_act_return_sw],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 1, ["ACE_SelfActions", "acpl_menu","acpl_radio_menu"], radio_act_return_lr],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	
	[[_unit, 1, ["ACE_SelfActions", "acpl_menu"], acpl_act_animations],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 1, ["ACE_SelfActions", "acpl_menu", "acpl_animations"], acpl_act_piss],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 1, ["ACE_SelfActions", "acpl_menu", "acpl_animations"], acpl_act_pushup],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	
	[[_unit, 1, ["ACE_SelfActions", "ACE_Equipment"], acpl_helmet_fast_act],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 1, ["ACE_SelfActions", "ACE_Equipment"], acpl_helmet_unfast_act],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 1, ["ACE_SelfActions", "ACE_Equipment"], acpl_weapon_fast_act],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
	[[_unit, 1, ["ACE_SelfActions", "ACE_Equipment"], acpl_weapon_unfast_act],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
};
publicvariable "acpl_add_actions";

acpl_add_action_static = {
	params ["_unit"];
	
	[[_unit, 1, ["ACE_SelfActions", "acpl_menu"], acpl_unlock_action_act],ace_interact_menu_fnc_addActionToObject] remoteExec ["call",_unit,true];
};
publicvariable "acpl_add_action_static";