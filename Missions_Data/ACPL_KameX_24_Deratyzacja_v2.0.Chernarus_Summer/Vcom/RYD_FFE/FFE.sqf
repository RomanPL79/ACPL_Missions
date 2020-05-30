
sleep 5;

missionNameSpace setVariable ["RydFFE_FiredShells",[]];

if (isNil "RydFFE_Active") then {RydFFE_Active = true};
if (isNil "RydFFE_Manual") then {RydFFE_Manual = false};
if (isNil "RydFFE_NoControl") then {RydFFE_NoControl = []};
if (isNil "RydFFE_ArtyShells") then {RydFFE_ArtyShells = 2};
if (isNil "RydFFE_Interval") then {RydFFE_Interval = 300};
if (isNil "RydFFE_Debug") then {RydFFE_Debug = false};
if (isNil "RydFFE_FO") then {RydFFE_FO = []};
if (isNil "RydFFE_2PhWithoutFO") then {RydFFE_2PhWithoutFO = true};
if (isNil "RydFFE_OnePhase") then {RydFFE_OnePhase = false};

if (isNil ("RydFFE_Amount")) then {RydFFE_Amount = 6};
//if (isNil ("RydFFE_Disp")) then {RydFFE_Disp = 1.5};
if (isNil ("RydFFE_Acc")) then {RydFFE_Acc = 6};
if (isNil ("RydFFE_Safe")) then {RydFFE_Safe = 200};
if (isNil ("RydFFE_Monogamy")) then {RydFFE_Monogamy = true};
if (isNil ("RydFFE_ShellView")) then {RydFFE_ShellView = false};
if (isNil ("RydFFE_FOAccGain")) then {RydFFE_FOAccGain = 1};
if (isNil ("RydFFE_FOClass")) then {RydFFE_FOClass =
[
	"i_spotter_f",
	"o_spotter_f",
	"b_spotter_f",
	"o_recon_jtac_f",
	"b_recon_jtac_f",
	"i_sniper_f",
	"o_sniper_f",
	"b_sniper_f",
	"i_soldier_m_f",
	"o_soldier_m_f",
	"b_g_soldier_m_f",
	"b_soldier_m_f",
	"o_recon_m_f",
	"b_recon_m_f",
	"o_soldieru_m_f",
	"i_uav_01_f",
	"i_uav_02_cas_f",
	"i_uav_02_f",
	"o_uav_01_f",
	"o_uav_02_cas_f",
	"o_uav_02_f",
	"b_uav_01_f",
	"b_uav_02_cas_f",
	"b_uav_02_f"
]};

if (isNil "RydFFE_Add_SPMortar") then {RydFFE_Add_SPMortar = []};
if (isNil "RydFFE_Add_Mortar") then {RydFFE_Add_Mortar = []};
if (isNil "RydFFE_Add_Rocket") then {RydFFE_Add_Rocket = []};
if (isNil "RydFFE_Add_Other") then {RydFFE_Add_Other = []
};
if (isNil "RydFFE_IowaMode") then {RydFFE_IowaMode = false};

RydFFE_SPMortar = ["o_mbt_02_arty_f","b_mbt_01_arty_f","rhs_2s3_tv","rhsusf_m109d_usarmy","rhsusf_m109_usarmy"] + RydFFE_Add_SPMortar;
RydFFE_Mortar = ["i_mortar_01_f","o_mortar_01_f","b_g_mortar_01_f","b_mortar_01_f","rhs_m252_d","rhs_m252_wd","rhs_d30_vmf","rhs_d30_msv","rhs_d30_vdv","rhs_2b14_82mm_vdv","rhs_2b14_82mm_msv","cup_b_m119_us","lop_tka_static_d30","rhs_m119_d","rhs_m119_wd","rhs_2b14_82mm_vmf"] + RydFFE_Add_Mortar;
RydFFE_Rocket = ["b_mbt_01_mlrs_f","rhsusf_m142_usarmy_wd","rhsusf_m142_usarmy_d","rhs_bm21_msv_01","rhs_bm21_chdkz","rhs_bm21_vdv_01","rhs_bm21_vv_01","rhs_bm21_vmf_01","cup_b_m270_he_usa"] + RydFFE_Add_Rocket;
RydFFE_Other = [[["cup_b_m270_he_usa","cup_b_m119_us"],["CUP_12Rnd_MLRS_HE","CUP_12Rnd_MLRS_HE","CUP_12Rnd_MLRS_HE","",""]],
		[["rhs_m119_d","rhs_m119_wd"],["RHS_mag_m1_he_12","RHS_mag_m1_he_12","RHS_mag_m1_he_12","rhs_mag_m60a2_smoke_4","rhs_mag_m314_ilum_4"]],
		[["lop_tka_static_d30"],["rhs_mag_of462_10","rhs_mag_of462_10","rhs_mag_of462_10","",""]],
		[["rhs_2b14_82mm_vmf","rhs_2b14_82mm_msv","rhs_2b14_82mm_vdv"],["rhs_mag_3vo18_10","rhs_mag_3vo18_10","rhs_mag_3vo18_10","rhs_mag_d832du_10","rhs_mag_3vs25m_10"]],
		[["rhs_d30_vmf","rhs_d30_msv","rhs_d30_vdv"],["rhs_mag_3of56_10","rhs_mag_3of69m_2","rhs_mag_3of56_10","rhs_mag_d462_2","rhs_mag_s463_2"]],
		[["rhs_2s3_tv"],["rhs_mag_HE_2a33","rhs_mag_LASER_2a33","rhs_mag_WP_2a33","rhs_mag_SMOKE_2a33","rhs_mag_ILLUM_2a33"]],
		[["rhsusf_m109d_usarmy","rhsusf_m109_usarmy"],["rhs_mag_155mm_m795_28","rhs_mag_155mm_m712_2","rhs_mag_155mm_m864_3","rhs_mag_155mm_m825a1_2","rhs_mag_155mm_485_2"]],
		[["rhs_m252_d","rhs_m252_wd"],["rhs_12Rnd_m821_HE","rhs_12Rnd_m821_HE","rhs_12Rnd_m821_HE","",""]],
		[["rhs_bm21_msv_01","rhs_bm21_chdkz","rhs_bm21_vdv_01","rhs_bm21_vv_01","rhs_bm21_vmf_01"],["RHS_mag_40Rnd_122mm_rockets","RHS_mag_40Rnd_122mm_rockets","RHS_mag_40Rnd_122mm_rockets","",""]],
		[["rhsusf_m142_usarmy_wd","rhsusf_m142_usarmy_d"],["rhs_ammo_m26a1_rocket","rhs_ammo_m26a1_rocket","rhs_ammo_m26a1_rocket","",""]]] + RydFFE_Add_Other;

_allArty = RydFFE_SPMortar + RydFFE_Mortar + RydFFE_Rocket;

{
	_allArty = _allArty + (_x select 0)
}
foreach RydFFE_Other;

_allArty = [_allArty] call RYD_fnc_AutoConfig;

_civF = ["civ_f","civ","civ_ru","bis_tk_civ","bis_civ_special"];
_sides = [west,east,resistance];

_enemies = [];
_friends = [];
RydFFE_Fire = false;

if (isNil ("RydFFE_SVRange")) then {RydFFE_SVRange = 3000};

if (RydFFE_ShellView) then {[] spawn RYD_fnc_Shellview};

while {RydFFE_Active} do
{
	if (RydFFE_Manual) then {waitUntil {sleep 0.1;((RydFFE_Fire) || !(RydFFE_Manual))};RydFFE_Fire = false};

	{
		_side = _x;

		_eSides = [sideEnemy];
		_fSides = [sideFriendly];

		{
			_getF = _side getFriend _x;
			if (_getF >= 0.6) then
			{
				_fSides set [(count _fSides),_x]
			}
			else
			{
				_eSides set [(count _eSides),_x]
			};
		} foreach _sides;

		if (({((side _x) == _side)} count AllGroups) > 0) then
		{
			
			_artyGroups = [];
			_enemies = [];
			_friends = [];

			{
				
				_gp = _x;

				if ((side _gp) == _side && {!(_gp in RydFFE_NoControl)}) then
				{
					
					{
						
						if (
							(toLower (typeOf (vehicle _x))) in _allArty &&
							{!(_gp in _artyGroups)}
						) 
						exitWith
						{
							if !(_gp in _artyGroups) then
							{
								_artyGroups pushBack _gp
							}
							
						}
						
					} foreach (units _gp)
					
				};

				_isCiv = false;
				if ((toLower (faction (leader _gp))) in _civF) then {_isCiv = true};

				if (!_isCiv && {!(isNull _gp)} && {(alive (leader _gp))}) then
				{
					
					if ((side _gp) in _eSides && {!(_gp in _enemies)}) then
					{
						_enemies pushBack _gp;
					}
					else
					{
						if ((side _gp) in _fSides && {!(_gp in _friends)}) then
						{
							_friends pushBack _gp;
							if ((toLower (typeOf (leader _x))) in RydFFE_FOClass && {(count RydFFE_FO) > 0} && {!(_gp in RydFFE_FO)}) then
							{
								RydFFE_FO pushBack _gp;
							}
							
						}
						
					}
				
				}
				
			} foreach allGroups;

			_knEnemies = [];

			{
				
				{
					
					_eVeh = vehicle _x;

					{
						if 
						(
							!((toLower (faction (leader _x))) in _civF) && 
							{(count RydFFE_FO) == 0 || (_x in RydFFE_FO)} &&
							{(_x knowsAbout _eVeh) >= 0.05} &&
							{!(_eVeh in _knEnemies)}
						) 
						then
						{
							_eVeh setVariable ["RydFFE_MyFO",(leader _x)];
							_knEnemies pushBack _eVeh;
						};
						
					} foreach _friends;
					
				} foreach (units _x);
				
			} foreach _enemies;

			_enArmor = [];

			{
				if ((_x isKindOf "Tank") || {_x isKindOf "Wheeled_APC"}) then
				{
					if !(_x in _enArmor) then
					{
						_enArmor pushBack _x
					};
					
				};
				
			} foreach _knEnemies;

			[_artyGroups,RydFFE_ArtyShells] call RYD_fnc_ArtyPrep;

			[_artyGroups,_knEnemies,_enArmor,_friends,RydFFE_Debug,RydFFE_Amount] call RYD_fnc_CFF;
		}
	}
	foreach _sides;

	sleep RydFFE_Interval;

	_shells = missionNameSpace getVariable ["RydFFE_FiredShells",[]];

	{
		_shell = _x;
		if (isNil "_shell") then
		{
			_shells set [_foreachIndex,0]
		}
		else
		{
			if (isNull _x) then
			{
				_shells set [_foreachIndex,0]
			};
		};
	} foreach _shells;

	_shells = _shells - [0];
	missionNameSpace setVariable ["RydFFE_FiredShells",_shells];
	
	_allArty = [_allArty] call RYD_fnc_AutoConfig;
	
};