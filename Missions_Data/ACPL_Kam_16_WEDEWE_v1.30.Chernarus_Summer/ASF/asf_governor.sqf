exitWith {};
#include "asf_settings.sqf"

acpl_asf_shooters = [];
_asf_start = [];
_asf_playerforces=[];
_asf_temp_playerforces=[];
_asf_playerforces_checked=[];
acpl_asf_shooters_checked=[];

sleep 5;



Zgarnia wszystko co ma ASF_AI=1, ważne żeby zgarniał też obiekty (bo działa na pojazdy i statyczne)
{
	if (_x getVariable "ASF_AI" == 1) then
		{
			acpl_asf_shooters_checked pushback _x  ;
			
		};
} forEach (allMissionObjects "");





//hint (format ["%1, %2",acpl_asf_shooters_checked, switchableUnits]);




while {true} do {


acpl_asf_shooters = [];
_asf_playerforces = [];
_asf_checkforces = playableUnits + switchableUnits; ///Zbiera wszystkich graczy i grywalne sloty do tablicy;

{
	if ((_x getVariable "ASF_AI" == 1)&&(_x getVariable "ASF_READY" == 1)) then
		{
			acpl_asf_shooters pushback _x  ;
			
		};  
} forEach acpl_asf_shooters_checked;

{
	_asf_playerforces pushback _x  ;	
} forEach _asf_checkforces;

	


	{
	_nul = [_x,_asf_playerforces,_asf_supp_time,_asf_offset,_asf_supp_break,_asf_rearming] execVM "ASF\asf_viewcheck.sqf";
	} forEach acpl_asf_shooters;
	sleep 1;
};


///TODO! PRZENIEsc ready check z supress do viewcheck






