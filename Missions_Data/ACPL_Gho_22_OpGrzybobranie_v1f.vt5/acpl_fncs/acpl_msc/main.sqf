#include "ustawienia.sqf";
if ((!isServer)||(msc_switch == 0))  exitwith {}; 
if (msc_debug == 1) then {hint "skrypt dziala"};
private ["_changed","_accuracy_r", "_shake_r","_speed_r","_spot_r","_time_r","_general_r","_courage_r","_reload_r","_rando_r","_accuracy_e", "_shake_e","_speed_e","_spot_e","_time_e","_general_e","_courage_e","_reload_e","_rando_e","_accuracy_w", "_shake_w","_speed_w","_spot_w","_time_w","_general_w","_courage_w","_reload_w","_rando_w"];
///////////////////////////////////////////////
//Tabela
_changed = [];
while {true} do {
	msc_array_w = [];
	msc_array_e = [];
	msc_array_r = [];
	{ if (side _x == WEST) then {msc_array_w pushback _x}} foreach allunits;
	msc_array_w = msc_array_w - msc_exception - _changed;
	{ if (side _x == EAST) then {msc_array_e pushback _x}} foreach allunits;
	msc_array_e = msc_array_e - msc_exception - _changed;
	{ if (side _x == resistance) then {msc_array_r pushback _x}} foreach allunits;
	msc_array_r = msc_array_r - msc_exception - _changed;
	//////////////
	{
	
		//Randomizer WEST
		msc_skill_accuracy_mid_w = ((msc_skill_accuracy_min_w + msc_skill_accuracy_max_w)/_rando_w);
		_accuracy_w = random [msc_skill_accuracy_min_w,msc_skill_accuracy_mid_w,msc_skill_accuracy_max_w];
		
		msc_skill_shake_mid_w = ((msc_skill_shake_min_w + msc_skill_shake_max_w)/_rando_w);
		_shake_w = random [msc_skill_shake_min_w,msc_skill_shake_mid_w,msc_skill_shake_max_w];
		
		msc_skill_speed_mid_w = ((msc_skill_speed_min_w + msc_skill_speed_max_w)/_rando_w);
		_speed_w = random [msc_skill_speed_min_w,msc_skill_speed_mid_w,msc_skill_speed_max_w];
		
		msc_skill_spot_mid_w = ((msc_skill_spot_min_w + msc_skill_spot_max_w)/_rando_w);
		_spot_w = random [msc_skill_spot_min_w,msc_skill_spot_mid_w,msc_skill_spot_max_w];
		
		msc_skill_time_mid_w = ((msc_skill_time_min_w + msc_skill_time_max_w)/_rando_w);
		_time_w = random [msc_skill_time_min_w,msc_skill_time_mid_w,msc_skill_time_max_w];
		
		msc_skill_general_mid_w = ((msc_skill_general_min_w + msc_skill_general_max_w)/_rando_w);
		_general_w = random [msc_skill_general_min_w,msc_skill_general_mid_w,msc_skill_general_max_w];
		
		msc_skill_courage_mid_w = ((msc_skill_courage_min_w + msc_skill_courage_max_w)/_rando_w);
		_courage_w = random [msc_skill_courage_min_w,msc_skill_courage_mid_w,msc_skill_courage_max_w];
		
		msc_skill_reload_mid_w = ((msc_skill_reload_min_w + msc_skill_reload_max_w)/_rando_w);
		_reload_w = random [msc_skill_reload_min_w,msc_skill_reload_mid_w,msc_skill_reload_max_w];
		
		if (msc_debug == 1) then {hint format ["Reload %1", _reload_w]};
		
		//ustawienie skilla
		_x setSkill ["aimingAccuracy", _accuracy_w];
		_x setSkill ["aimingShake", _shake_w];
		_x setSkill ["aimingSpeed", _speed_w];
		_x setSkill ["spotDistance", _spot_w];
		_x setSkill ["spotTime", _time_w];
		_x setSkill ["general", _general_w];
		_x setSkill ["courage", _courage_w];
		_x setSkill ["reloadSpeed", _reload_w];
		
		_changed = _changed + [_x];
	
	} forEach msc_array_w;
	
	{
	
		//Randomizer EAST
		msc_skill_accuracy_mid_e = ((msc_skill_accuracy_min_e + msc_skill_accuracy_max_e)/_rando_e);
		_accuracy_e = random [msc_skill_accuracy_min_e,msc_skill_accuracy_mid_e,msc_skill_accuracy_max_e];
		
		msc_skill_shake_mid_e = ((msc_skill_shake_min_e + msc_skill_shake_max_e)/_rando_e);
		_shake_e = random [msc_skill_shake_min_e,msc_skill_shake_mid_e,msc_skill_shake_max_e];
		
		msc_skill_speed_mid_e = ((msc_skill_speed_min_e + msc_skill_speed_max_e)/_rando_e);
		_speed_e = random [msc_skill_speed_min_e,msc_skill_speed_mid_e,msc_skill_speed_max_e];
		
		msc_skill_spot_mid_e = ((msc_skill_spot_min_e + msc_skill_spot_max_e)/_rando_e);
		_spot_e = random [msc_skill_spot_min_e,msc_skill_spot_mid_e,msc_skill_spot_max_e];
	
		msc_skill_time_mid_e = ((msc_skill_time_min_e + msc_skill_time_max_e)/_rando_e);
		_time_e = random [msc_skill_time_min_e,msc_skill_time_mid_e,msc_skill_time_max_e];
	
		msc_skill_general_mid_e = ((msc_skill_general_min_e + msc_skill_general_max_e)/_rando_e);
		_general_e = random [msc_skill_general_min_e,msc_skill_general_mid_e,msc_skill_general_max_e];
	
		msc_skill_courage_mid_e = ((msc_skill_courage_min_e + msc_skill_courage_max_e)/_rando_e);
		_courage_e = random [msc_skill_courage_min_e,msc_skill_courage_mid_e,msc_skill_courage_max_e];
	
		msc_skill_reload_mid_e = ((msc_skill_reload_min_e + msc_skill_reload_max_e)/_rando_e);
		_reload_e = random [msc_skill_reload_min_e,msc_skill_reload_mid_e,msc_skill_reload_max_e];
	
		if (msc_debug == 1) then {hint format ["Reload %1", _reload_e]};
	
		//ustawienie skilla
		_x setSkill ["aimingAccuracy", _accuracy_e];
		_x setSkill ["aimingShake", _shake_e];
		_x setSkill ["aimingSpeed", _speed_e];
		_x setSkill ["spotDistance", _spot_e];
		_x setSkill ["spotTime", _time_e];
		_x setSkill ["general", _general_e];
		_x setSkill ["courage", _courage_e];
		_x setSkill ["reloadSpeed", _reload_e];
	
		_changed = _changed + [_x];

	} forEach msc_array_e;
	
	{
	
		//Randomizer RESISTANCE
		msc_skill_accuracy_mid_r = ((msc_skill_accuracy_min_r + msc_skill_accuracy_max_r)/_rando_r);
		_accuracy_r = random [msc_skill_accuracy_min_r,msc_skill_accuracy_mid_r,msc_skill_accuracy_max_r];
		
		msc_skill_shake_mid_r = ((msc_skill_shake_min_r + msc_skill_shake_max_r)/_rando_r);
		_shake_r = random [msc_skill_shake_min_r,msc_skill_shake_mid_r,msc_skill_shake_max_r];
		
		msc_skill_speed_mid_r = ((msc_skill_speed_min_r + msc_skill_speed_max_r)/_rando_r);
		_speed_r = random [msc_skill_speed_min_r,msc_skill_speed_mid_r,msc_skill_speed_max_r];
		
		msc_skill_spot_mid_r = ((msc_skill_spot_min_r + msc_skill_spot_max_r)/_rando_r);
		_spot_r = random [msc_skill_spot_min_r,msc_skill_spot_mid_r,msc_skill_spot_max_r];
		
		msc_skill_time_mid_r = ((msc_skill_time_min_r + msc_skill_time_max_r)/_rando_r);
		_time_r = random [msc_skill_time_min_r,msc_skill_time_mid_r,msc_skill_time_max_r];
	
		msc_skill_general_mid_r = ((msc_skill_general_min_r + msc_skill_general_max_r)/_rando_r);
		_general_r = random [msc_skill_general_min_r,msc_skill_general_mid_r,msc_skill_general_max_r];
	
		msc_skill_courage_mid_r = ((msc_skill_courage_min_r + msc_skill_courage_max_r)/_rando_r);
		_courage_r = random [msc_skill_courage_min_r,msc_skill_courage_mid_r,msc_skill_courage_max_r];
	
		msc_skill_reload_mid_r = ((msc_skill_reload_min_r + msc_skill_reload_max_r)/_rando_r);
		_reload_r = random [msc_skill_reload_min_r,msc_skill_reload_mid_r,msc_skill_reload_max_r];
	
		if (msc_debug == 1) then {hint format ["Reload %1", _reload_r]};
	
		//ustawienie skilla
		_x setSkill ["aimingAccuracy", _accuracy_r];
		_x setSkill ["aimingShake", _shake_r];
		_x setSkill ["aimingSpeed", _speed_r];
		_x setSkill ["spotDistance", _spot_r];
		_x setSkill ["spotTime", _time_r];
		_x setSkill ["general", _general_r];
		_x setSkill ["courage", _courage_r];
		_x setSkill ["reloadSpeed", _reload_r];
		
		_changed = _changed + [_x];
	
	} forEach msc_array_r;
	
	
	sleep 10;
};