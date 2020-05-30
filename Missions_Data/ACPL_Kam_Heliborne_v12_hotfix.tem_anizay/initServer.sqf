{
  if ((side _x) == West) then
  {
     _x removeweapon "ItemRadio";
	 _x addWeapon "TFAR_anprc152";
  };
} forEach allUnits;