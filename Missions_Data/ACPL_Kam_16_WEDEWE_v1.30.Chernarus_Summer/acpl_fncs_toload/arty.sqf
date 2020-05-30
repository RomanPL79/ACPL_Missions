if (!isserver) exitwith {};

acpl_arty_doartilleryfire = {
	params ["_unit", "_pos", "_ammo", "_shells"];
	private ["_random", "_skill", "_dis", "_pos_x", "_pos_y"];
	
	_random = acpl_arty_dispersion;
	_skill = (gunner _unit) skill "aimingAccuracy";
	_dis = (_unit distance2D _pos) / 1000;
	
	_random = _random / _skill * _dis;
	
	_pos_x = _pos select 0;
	_pos_y = _pos select 1;
	
	for "_i" from 1 to _shells do {
		private ["_sleep", "_random_pos", "_random_x", "_random_y"];
		
		_sleep = 2 + (random 3);
		
		_random_x = -(_random/2) + (random _random);
		_random_y = -(_random/2) + (random _random);
		
		_random_pos = [(_pos_x + _random_x),(_pos_y + _random_y)];
		
		_unit doArtilleryFire [_random_pos, _ammo, 1];
		
		sleep _sleep;
	};
};
publicvariable "acpl_arty_doartilleryfire";