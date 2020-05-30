private ["_playable","_action","_version"];
params [
	"_type",
	["_medical", []],
	["_vcom", true],
	["_static", true],
	["_medical_exep", []],
	["_ied_init", false],
	["_safe_start", false],
	["_text", "Somewhere in far away land"],
	["_hetman", false],
	["_viewdistance", 1600]
];

//Podstawowe skrypty ACPL
//v1.4c

acpl_medical_mc = _medical;
acpl_medical_exep = _medical_exep;

_version = "v1.4c";

acpl_fncs_initied = false;
acpl_mainloop_done = false;

acpl_fnc_debug = true;
publicvariable "acpl_fnc_debug";

acpl_custommarkers = false;						//Czy nanosiæ markery dla dostawionych budynków?
publicvariable "acpl_custommarkers";

if (acpl_fnc_debug) then {["ACPL FNCS INITIATION"] remoteExec ["systemchat",0];};

[_viewdistance] remoteExec ["setViewDistance",0];

if (!isserver) exitwith {};

enableDynamicSimulationSystem false;

[2000,30,false,200000,300000,200000,false,false,false] execvm "zbe_cache\main.sqf";

[[],"briefing.sqf"] remoteExec ["execVM",2];
if (acpl_fnc_debug) then {["BRIEFING LOADED"] remoteExec ["systemchat",0];};

_nul = [_version] execVM "acpl_info_init.sqf";

_playable = [] + playableUnits + switchableUnits + allPlayers;

[["","BLACK IN", 7]] remoteExec ["titleCut",0];

if (isDedicated) then {
	{[[_text, str(date select 2) + "." + str(date select 1) + "." + str(date select 0), str(name _x)],BIS_fnc_infoText] remoteExec ["spawn",_x,true];} foreach _playable;
} else {
	[[_text, str(date select 2) + "." + str(date select 1) + "." + str(date select 0), str(name player)],BIS_fnc_infoText] remoteExec ["spawn",0,true];
};

acpl_AI_mod = 1;								//Który mod poprawiaj¹cy AI ma zostaæ uruchomiony? 0 = VCOM, 1 = TCL
publicvariable "acpl_AI_mod";

acpl_fncs_initied = false;
publicvariable "acpl_fncs_initied";

acpl_player_distance = 1000;					//jak daleko musz¹ byæ gracze aby wykonywaæ bardziej zawansowane operacje (wyœwietlanie animacji, etc)

if (_ied_init) then {
	acpl_ied_distance = 75; 						//Dystans po wejœciu w który IED mo¿e zostaæ odpalony
	acpl_ied_worth_modifier = 1.15;					//Modyfikator op³acalnoœci odpalenia IED (iloœæ osób * modyfikator * odwaga)
	acpl_ied_time = 10;								//Œredni czas do odpalania ³adunku
	acpl_ied_broken_chance = 10;					//Szansa w % na niewybuch (nie wybuchnie wcale), zale¿y od zapalnika (radiowe = szansa \ 2)
	acpl_ied_failed = 20;							//Szansa w % na nieudan¹ detonacje
	acpl_ied_jammer_effectivity = 95;				//Skutecznoœæ jammera
	acpl_ied_jammer_distance = 300;					//Maksymalny zasiêg dzia³ania
	acpl_ied_jammer_effective_distance = 200;		//Skuteczny zasiêg (poni¿ej jego zawsze skutecznoœæ zawsze równa acpl_ied_jammer_effectivity)
	acpl_ied_noiedsretreat = true;					//Czy jednostka ma zacz¹æ uciekaæ po odpaleniu wszystkich ied? Tylko dla jednostek 'cywilnych'
	acpl_ied_touchoff_whenleaving = 40;				//% szansa na to, ¿e IED zostanie odpalone gdy przeciwnik opuszcza zasieg razenia (zasieg razenia = acpl_ied_distance)
	acpl_ied_touchoff_wheninrange = 40;				//% szansa na to, ¿e IED zostanie odpalone odrazu gdy przeciwnik wejdzie w jego zasiêg razenia
	acpl_ied_debug = true;							//debug
	
	{publicvariable _x;} foreach ["acpl_ied_noiedsretreat","acpl_ied_distance","acpl_ied_worth_modifier","acpl_ied_time","acpl_ied_broken_chance","acpl_ied_failed","acpl_ied_jammer_effective_distance","acpl_ied_jammer_distance","acpl_ied_jammer_effectivity"];
} else {
	acpl_ied_noiedsretreat = false;
	publicvariable "acpl_ied_noiedsretreat";
};

acpl_camoscript = false;								//[UWAGA! Przy misjach z wiêksz¹ iloœci¹ jednostek mo¿e mocno spowolniæ serwer!] W³¹cza/wy³¹cza przeliczanie mno¿nika ukrycia dla wszystkich jednostek zale¿ny od warunków atmosferycznych, nate¿enia œwiat³a, etc.
acpl_camoscript_players = true;							//Czy ma obliczaæ mno¿nik ukrycia dla graczy [pozostawiæ na true, wy³aczyaæ TYLKO przy cie¿szych pod wzglêdem FPS misjach!]
publicvariable "acpl_camoscript_players";

acpl_dostop_weap_chance = 50;						//Szansa w % na wyci¹gniêcie broni przez przeciwnika z ukryt¹ broni¹. Im wiêcej przeciwników jednostki w pobli¿u tym szansa sie zmniejsza o x ludzi
acpl_dostop_weap_distance = 15;						//Od³eg³oœæ w której musi byæ przeciwnik aby jednostka z ukryt¹ broni¹ zacze³a siê zastanawiaæ nad wyjêciem broni
acpl_dostop_retreat_chance = 50;					//Szansa w % na ucieczkê z zajmowaniej pozycji przez jednostke (dodatkowo wp³ywa na ni¹ odwaga jednostki)
acpl_dostop_retreat_distance = 100;					//Odleg³oœæ w jakiej musi byæ przeciwnik aby rozwa¿yæ ucieczkê
acpl_dostop_ammo_rearm = 0.5;						//Ile % amunicji musi zostaæ zu¿yte aby j¹ uzupe³niæ
acpl_dostop_roam_chance = 25;						//Szansa w % na zmiane pozycji
acpl_dostop_roam_time = [60,120,300];				//Co jaki czas rozwa¿a zmiane pozycji?
acpl_dostop_roam_backtime = [10,60,300];			//Jak d³ugo pozostaæ na zmienionej pozycji?
acpl_dostop_react_chance = 75;						//Szansa w % na zmiane pozycji po rozpoczêciu walki
acpl_dostop_react_time = [5,20,60];					//Co ile czasu zmienia pozycje
acpl_dostop_ducktime = [2, 5, 10];					//Na jak d³ugo chowa siê AI?

acpl_arty_dispersion = 50;							//Domyœlny rozrzut (modyfikowany przez odleg³oœæ i skill strzelca -> dispersion * ((1 - _acc) * (_dis / 1000)))

acpl_patrol_building_distance = 30;					//Dystans w którym (po dotarciu do waypointa) patrol sprawdza budynki
acpl_patrol_building_coverage = [0.5, 0.75, 1];		//Jak dok³adnie Patrol sprawdza budynek, 1 - ca³y, 0 - nie sprawdza, [min, mid, max]
acpl_patrol_wait = [10, 30, 60];					//Jak d³ugo patrol pozostaje w wp po dotarciu, [min, mid, max]
acpl_patrol_dis = 10;								//odleg³oœæ od centrum waypoint do jego zaliczenia
acpl_patrol_building_maxtime = 300;					//Jak d³ugo mo¿e sprawdzaæ budynki (w celu braku zaciêæ)
acpl_patrol_domove_maxtime = 60;					//jak d³ugo mo¿na sprawdzaæ jedno miejsce

acpl_dostop_maxtime = (acpl_dostop_roam_time select 2);
acpl_dostop_react_maxtime = (acpl_dostop_react_time select 2);

acpl_medicalhelp_coverchance = 70;					//% szansy na schowanie siê przed leczeniem
acpl_medicalhelp_heavywounded = 3;					//Jak mocno musi byæ ranny aby byæ uznany za ciê¿ko rannego? (nie ruszaæ)
acpl_medicalhelp_dragwounded = 75;					//% szansy na odci¹gniêcie rannego przed leczeniem
acpl_medicalhelp_debrieslifetime = 300;				//Na ile sekund pozostaj¹ zu¿yte medykamenty?

acpl_civs_firedistance = 600;						//Jak daleko od cywila musz¹ padaæ strza³y aby siê schowa³
acpl_civs_hidedistance = 100;						//W jakiej odleg³oœci cywil bêdzie szuka³ schronienia?
acpl_civs_hidetime = [60,300,600];					//Na jak d³ugo cywil siê schowa?

{publicvariable _x;} foreach ["acpl_dostop_weap_chance","acpl_dostop_weap_distance","acpl_dostop_retreat_chance","acpl_dostop_retreat_distance"];

{publicvariable _x;} foreach ["acpl_enemy_artillery_time","acpl_enemy_artillery_disperce","acpl_enemy_artillery_modifier","acpl_enemy_artillery_min_range","acpl_enemy_artillery_max_range","acpl_enemy_artillery_insight"];

//Ustawienia skilla AI

acpl_msc = true;								//W³¹cznik
acpl_msc_exception = [];						//Wykluczone ze zmiany skilla jednostki
acpl_msc_debug = false;							//Debug

acpl_weather_changetime = [10, 60];				//Zakres czasu w minutach co ile zmieniana jest pogoda
acpl_weather_overcast = [0.1, 0.3];				//Zakres zachmurzenia
acpl_weather_rain = [0, 0.5];					//Zakres opadów
acpl_weather_fog = [0, 0];						//Zakres mg³y
acpl_weather_thunders = [0, 0];					//Zakres b³yskawic
acpl_weather_random = 4;						//Mno¿nik, im bli¿ej jedynki tym bêdzie losowany bli¿ej górnej granicy

acpl_weather_enabled = false;					//Czy w³¹czyæ zmiany pogodowe?

//WEST
acpl_msc_west_random = 2;						//Im bli¿ej jedynki tym skill bêdzie losowany bli¿ej górnej granicy

acpl_msc_west_acc = [0.2, 0.4];					//Granice ustawienia celnoœci
acpl_msc_west_shake = [0.2, 0.4];				//Stabilnoœæ rêki w czasie strzelania
acpl_msc_west_speed = [0.2, 0.4];				//Prêdkoœæ celowania
acpl_msc_west_spot = [0.6, 0.8];				//Dystans wykrywania
acpl_msc_west_time = [0.6, 0.8];				//Czas wykrywania
acpl_msc_west_general = [0.6, 0.8];				//Skill generalny - u¿ywanie os³on, flankowanie, generalny brain-factor
acpl_msc_west_courage = [0.6, 0.8];				//Odwaga - im wiêcej tej wartoœci tym trudniej przycisn¹æ wroga
acpl_msc_west_reload = [0.2, 0.4];				//Prêdkoœæ prze³adowania

//EAST
acpl_msc_east_random = 6;						//Im bli¿ej jedynki tym skill bêdzie losowany bli¿ej górnej granicy

acpl_msc_east_acc = [0.05, 0.15];				//Granice ustawienia celnoœci
acpl_msc_east_shake = [0.05, 0.15];				//Stabilnoœæ rêki w czasie strzelania
acpl_msc_east_speed = [0.05, 0.15];				//Prêdkoœæ celowania
acpl_msc_east_spot = [0.35, 0.7];				//Dystans wykrywania
acpl_msc_east_time = [0.2, 0.4];				//Czas wykrywania
acpl_msc_east_general = [0.3, 0.6];				//Skill generalny - u¿ywanie os³on, flankowanie, generalny brain-factor
acpl_msc_east_courage = [0.4, 0.7];				//Odwaga - im wiêcej tej wartoœci tym trudniej przycisn¹æ wroga
acpl_msc_east_reload = [0.1, 0.2];				//Prêdkoœæ prze³adowania

//RESISTANCE
acpl_msc_resistance_random = 2;					//Im bli¿ej jedynki tym skill bêdzie losowany bli¿ej górnej granicy

acpl_msc_resistance_acc = [0.1, 0.25];			//Granice ustawienia celnoœci
acpl_msc_resistance_shake = [0.1, 0.25];		//Stabilnoœæ rêki w czasie strzelania
acpl_msc_resistance_speed = [0.1, 0.25];		//Prêdkoœæ celowania
acpl_msc_resistance_spot = [0.2, 0.3];			//Dystans wykrywania
acpl_msc_resistance_time = [0.2, 0.4];			//Czas wykrywania
acpl_msc_resistance_general = [0.4, 0.6];		//Skill generalny - u¿ywanie os³on, flankowanie, generalny brain-factor
acpl_msc_resistance_courage = [0.4, 0.6];		//Odwaga - im wiêcej tej wartoœci tym trudniej przycisn¹æ wroga
acpl_msc_resistance_reload = [0.1, 0.2];		//Prêdkoœæ prze³adowania

{publicvariable _x;} foreach ["acpl_msc_resistance_reload","acpl_msc_resistance_courage","acpl_msc_resistance_general","acpl_msc_resistance_time","acpl_msc_resistance_spot","acpl_msc_resistance_speed","acpl_msc_resistance_shake","acpl_msc_resistance_acc","acpl_msc_resistance_random","acpl_msc_east_reload","acpl_msc_east_courage","acpl_msc_east_general","acpl_msc_east_time","acpl_msc_east_spot","acpl_msc_east_speed","acpl_msc_east_shake","acpl_msc_east_acc","acpl_msc_east_random","acpl_msc_west_reload","acpl_msc_west_courage","acpl_msc_west_general","acpl_msc_west_time","acpl_msc_west_spot","acpl_msc_west_speed","acpl_msc_west_shake","acpl_msc_west_acc","acpl_msc_west_random","acpl_msc_debug","acpl_msc_exception","acpl_msc"];

acpl_betterAI_detection = 1;					//Wartoœæ powy¿ej której jednostka 'widzi' przeciwnika
acpl_betterAI_detection_time = 10;				//Czas po którym jednostka wykrywa przeciwnika globalnie
acpl_betterAI_morale_enabled = false;			//W³acznik systemu morali (im mniejsze morale tym przeciwnik gorzej walczy)
acpl_betterAI_morale_changer = 0.4;				//Jak bardzo morale mog¹ wp³yn¹æ na skill AI

acpl_betterAI_startmorale_blue = 100;			//Pocz¹tkowe morale dla WEST
acpl_betterAI_startmorale_red = 100;			//Pocz¹tkowe morale dla EAST
acpl_betterAI_startmorale_green = 100;			//Pocz¹tkowe morale dla RESISTANCE

acpl_betterAI_morale_lostleader = 0.2;			//O ile spadaj¹ morale za utratê dowódcy (pierwotny dowódca to 1.5 tej wartoœci)
acpl_betterAI_lostunit_modifier = 0.2;			//O jak¹ wartoœæ zmieniaj¹ siê morale po utraconej jednostce (jest to % wyliczany z aktualnych morali)
acpl_betterAI_kill_modifier = 0.15;				//Jak bardzo podbija morale za zabicie przeciwnika
acpl_betterAI_groups_modifier = 15;				//Jak obecnoœæ grup sojuszniczych wp³ywa na morale
acpl_betterAI_countgroups_modifier = 7.5;		//Jak dzielona jest iloœæ grup wp³ywaj¹cych na morale grupy
acpl_betterAI_groups_distance = 200;			//Odlegoœæ w której obecnoœæ innej grupy poprawia morale

_null = [] execVM "acpl_betterAI\betterAI_init.sqf";

publicvariable "acpl_camoscript_players";

acpl_hit_helmet_chance = 75;					//Szansa w % na stracenie he³mu przy postrzale w g³owe
acpl_hit_weapon_chance = 10;					//Szansa w % na stracenie broni przy postrzale w rêke
acpl_hit_fallonground_chance = 66;				//Szansa w % na przewrócenie siê przy postrzale w nogi

//Ustawienia medykamentów
acpl_medical = true;							//Czy automatyczne dodawanie medykamentów jest uruchomione?
acpl_medical_AI = true; 						//Zmiana iloœci medykamentów dla jednotek AI

//Dla zwyk³ego ¿o³daka grywalnego
acpl_fieldDressing_sol = 6;
acpl_elasticBandage_sol = 4;
acpl_adenosine_sol = 0;
acpl_atropine_sol = 0;
acpl_epinephrine_sol = 0;
acpl_morphine_sol = 0;
acpl_packingBandage_sol = 2;
acpl_personalAidKit_sol = 0;
acpl_tourniquet_sol = 2;
acpl_plasmaIV_500_sol = 0;
acpl_salineIV_500_sol = 0;
acpl_plasmaIV_250_sol = 0;
acpl_salineIV_250_sol = 2;
acpl_quicklot_sol = 0;

//Dla medyka z dru¿yny (Ratownika)
acpl_fieldDressing_med = 16;
acpl_elasticBandage_med = 18;
acpl_adenosine_med = 4;
acpl_atropine_med = 4;
acpl_epinephrine_med = 14;
acpl_morphine_med = 14;
acpl_packingBandage_med = 10;
acpl_personalAidKit_med = 2;
acpl_plasmaIV_med = 0;
acpl_plasmaIV_250_med = 6;
acpl_plasmaIV_500_med = 1;
acpl_salineIV_med = 0;
acpl_salineIV_250_med = 6;
acpl_salineIV_500_med = 2;
acpl_tourniquet_med = 10;
acpl_surgicalKit_med = 0;
acpl_bloodIV_250_med = 0;
acpl_quicklot_med = 6;

//Dla zwyk³ego ¿o³daka, AI
acpl_fieldDressing_AI = 4;
acpl_elasticBandage_AI = 2;
acpl_adenosine_AI = 0;
acpl_atropine_AI = 0;
acpl_epinephrine_AI = 0;
acpl_morphine_AI = 0;
acpl_packingBandage_AI = 2;
acpl_personalAidKit_AI = 0;
acpl_tourniquet_AI = 2;
acpl_quicklot_AI = 0;

//Dla medyka, AI
acpl_fieldDressing_med_AI = 14;
acpl_elasticBandage_med_AI = 15;
acpl_adenosine_med_AI = 2;
acpl_atropine_med_AI = 3;
acpl_epinephrine_med_AI = 11;
acpl_morphine_med_AI = 14;
acpl_packingBandage_med_AI = 7;
acpl_personalAidKit_med_AI = 1;
acpl_plasmaIV_med_AI = 0;
acpl_plasmaIV_250_med_AI = 3;
acpl_plasmaIV_500_med_AI = 0;
acpl_salineIV_med_AI = 0;
acpl_salineIV_250_med_AI = 7;
acpl_salineIV_500_med_AI = 0;
acpl_tourniquet_med_AI = 4;
acpl_surgicalKit_med_AI = 1;
acpl_bloodIV_250_med_AI = 0;
acpl_quicklot_med_AI = 0;

//Dla centrum medycznego
acpl_fieldDressing_veh = 40;
acpl_elasticBandage_veh = 50;
acpl_adenosine_veh = 12;
acpl_atropine_veh = 12;
acpl_bloodIV_veh = 10;
acpl_bodyBag_veh = 10;
acpl_epinephrine_veh = 30;
acpl_morphine_veh = 30;
acpl_packingBandage_veh = 25;
acpl_plasmaIV_veh = 14;
acpl_salineIV_veh = 10;
acpl_surgicalKit_veh = 2;
acpl_tourniquet_veh = 10;
acpl_quicklot_veh = 20;
acpl_PAK_veh = 18;
acpl_medicbag_veh = 1;
acpl_stretcher_veh = 2;

//Dla Lekarza
acpl_fieldDressing_doc = 18;
acpl_elasticBandage_doc = 22;
acpl_adenosine_doc = 6;
acpl_atropine_doc = 6;
acpl_epinephrine_doc = 18;
acpl_morphine_doc = 18;
acpl_packingBandage_doc = 12;
acpl_personalAidKit_doc = 4;
acpl_plasmaIV_doc = 0;
acpl_plasmaIV_250_doc = 8;
acpl_plasmaIV_500_doc = 3;
acpl_salineIV_doc = 0;
acpl_salineIV_250_doc = 8;
acpl_salineIV_500_doc = 2;
acpl_tourniquet_doc = 6;
acpl_surgicalKit_doc = 1;
acpl_bloodIV_250_doc = 0;
acpl_quicklot_doc = 6;
acpl_medicbag_doc = 0;

//Dla G³ównego Lekarza
acpl_fieldDressing_doc_main = 18;
acpl_elasticBandage_doc_main = 22;
acpl_adenosine_doc_main = 6;
acpl_atropine_doc_main = 6;
acpl_epinephrine_doc_main = 18;
acpl_morphine_doc_main = 18;
acpl_packingBandage_doc_main = 12;
acpl_personalAidKit_doc_main = 4;
acpl_plasmaIV_doc_main = 0;
acpl_plasmaIV_250_doc_main = 8;
acpl_plasmaIV_500_doc_main = 3;
acpl_salineIV_doc_main = 0;
acpl_salineIV_250_doc_main = 8;
acpl_salineIV_500_doc_main = 2;
acpl_tourniquet_doc_main = 8;
acpl_surgicalKit_doc_main = 1;
acpl_bloodIV_250_doc_main = 0;
acpl_quicklot_doc_main = 6;
acpl_medicbag_doc_main = 1;

if (_type == 1) then {
	acpl_WZ28_Enabled = false; //w³¹cza mo¿liwoœæ prze³adowania dla polskiej wersji BAR'a (na 7,92), tylko WW2
	
	acpl_ww2_change_m1garand = true;				//Czy zamieniaæ M1 garand z IF44 na M1 Garand z FoW?
	acpl_ww2_change_leeenfield = true;				//Czy wymieniæ lee enfieldy z FoW na lepsze?
	
	{publicvariable _x;} foreach ["acpl_ww2_change_m1garand", "acpl_ww2_change_leeenfield"];
} else {
	acpl_ww2_change_m1garand = false;
	acpl_ww2_change_leeenfield = false;
	
	{publicvariable _x;} foreach ["acpl_ww2_change_m1garand", "acpl_ww2_change_leeenfield"];
};

{publicvariable _x;} foreach ["acpl_salineIV_500_sol","acpl_plasmaIV_500_sol","acpl_fieldDressing_sol","acpl_elasticBandage_sol","acpl_adenosine_sol","acpl_atropine_sol","acpl_epinephrine_sol","acpl_morphine_sol","acpl_packingBandage_sol","acpl_personalAidKit_sol","acpl_tourniquet_sol"];
{publicvariable _x;} foreach ["acpl_fieldDressing_AI","acpl_elasticBandage_AI","acpl_adenosine_AI","acpl_atropine_AI","acpl_epinephrine_AI","acpl_morphine_AI","acpl_packingBandage_AI","acpl_personalAidKit_AI","acpl_tourniquet_AI"];
{publicvariable _x;} foreach ["acpl_bloodIV_250_med_AI","acpl_surgicalKit_med_AI","acpl_tourniquet_med_AI","acpl_salineIV_500_med_AI","acpl_salineIV_250_med_AI","acpl_salineIV_med_AI","acpl_plasmaIV_500_med_AI","acpl_plasmaIV_250_med_AI","acpl_plasmaIV_med_AI","acpl_fieldDressing_med_AI","acpl_elasticBandage_med_AI","acpl_adenosine_med_AI","acpl_atropine_med_AI","acpl_epinephrine_med_AI","acpl_morphine_med_AI","acpl_packingBandage_med_AI","acpl_personalAidKit_med_AI"];
{publicvariable _x;} foreach ["acpl_bloodIV_250_med","acpl_surgicalKit_med","acpl_tourniquet_med","acpl_salineIV_500_med","acpl_salineIV_250_med","acpl_salineIV_med","acpl_plasmaIV_500_med","acpl_plasmaIV_250_med","acpl_plasmaIV_med","acpl_fieldDressing_med","acpl_elasticBandage_med","acpl_adenosine_med","acpl_atropine_med","acpl_epinephrine_med","acpl_morphine_med","acpl_packingBandage_med","acpl_personalAidKit_med"];
{publicvariable _x;} foreach ["acpl_tourniquet_veh","acpl_surgicalKit_veh","acpl_salineIV_veh","acpl_plasmaIV_veh","acpl_packingBandage_veh","acpl_morphine_veh","acpl_epinephrine_veh","acpl_bodyBag_veh","acpl_bloodIV_veh","acpl_atropine_veh","acpl_adenosine_veh","acpl_elasticBandage_veh","acpl_fieldDressing_veh"];
{publicvariable str(_x);} foreach [acpl_medical,acpl_medical_AI,acpl_medical_mc,acpl_medical_exep];

if (_type == 0) then {
};

if (_type == 1) then {
	_nul = execVM "acpl_fncs\IF44\acpl_repack_init.sqf";
};

RydFFE_ArtyShells = 2;
RydFFE_Interval = 300;
RydFFE_Safe = 400;
RydFFE_Add_SPMortar = [];
RydFFE_Add_Mortar = [];
RydFFE_Add_Rocket = [];
RydFFE_Add_Other = [];
RydFFE_Acc = 6;

if (_vcom) then {
	if (acpl_AI_mod == 0) then {
		if (isNil "Vcm_ActivateAI") then {Vcm_ActivateAI = true};
		
		//USTAWIENIA VCOMAI ZNAJDUJ¥ SIÊ W "Vcom\Functions\VCM_CBASettings.sqf"
	};
	if (acpl_AI_mod == 1) then {
		TCL_Path = "TCL_System\";
		[] spawn {
			sleep 2;
			call compile preprocessFileLineNumbers (TCL_Path+"TCL_Preprocess.sqf");
			[] execVM "acpl_configs\TCL\TCL_AI.sqf";
			[] execVM "acpl_configs\TCL\TCL_Debug.sqf";
			[] execVM "acpl_configs\TCL\TCL_Feature.sqf";
			[] execVM "acpl_configs\TCL\TCL_FX.sqf";
			[] execVM "acpl_configs\TCL\TCL_System.sqf";
			[] execVM "acpl_configs\TCL\TCL_Tweak.sqf";
			[] execVM "acpl_configs\TCL\TCL_IQ.sqf";
			[] execVM "acpl_configs\TCL\TCL_Radio.sqf";
			sleep 2;
			Vcm_ActivateAI = false;
			publicvariable "Vcm_ActivateAI";
			sleep 10;
			Vcm_ActivateAI = false;
			publicvariable "Vcm_ActivateAI";
		};
	};
} else {
	[] spawn {
		Vcm_ActivateAI = false;
		publicvariable "Vcm_ActivateAI";
	};
};

{
	(group _x) setVariable ["VCM_DisableForm",true,true];
	(group _x) setVariable ["VCM_TOUGHSQUAD",true,true];
	(group _x) setVariable ["VCM_NORESCUE",true,true];
	(group _x) setVariable ["VCM_NOFLANK",true,true];
	(group _x) setVariable ["VCOM_NOAI",true,true];
	(group _x) setVariable ["Vcm_Disable",true,true];
	(group _x) setvariable ["TCL_Disabled",true];
} foreach _playable;

if (_hetman) then {
	//LEADERS SECTION
	RydHQ_Debug = false;
	RydHQB_Debug = false;
	RydHQC_Debug = false;
	RydHQD_Debug = false;

	RydHQ_ChatDebug = true;

	RydHQ_SubAll = false;
	RydHQB_SubAll = false;
	RydHQC_SubAll = false;
	RydHQD_SubAll = false;

	RydHQ_SubSynchro = true;
	RydHQB_SubSynchro = true;
	RydHQC_SubSynchro = true;
	RydHQD_SubSynchro = true;

	RydHQ_Rush = true;
	RydHQB_Rush = true;
	RydHQC_Rush = true;
	RydHQD_Rush = true;

	RydHQ_CargoFind = 1;   
	RydHQB_CargoFind = 1;
	RydHQC_CargoFind = 1;   
	RydHQD_CargoFind = 1;

	RydHQ_LZ = false;

	RydxHQ_AIChatDensity = 0;
	RydHQ_HQChat = false;

	RydHQ_Front = false;
	RydHQB_Front = false;
	RydHQC_Front = false;
	RydHQD_Front = false;

	RydHQ_MAtt = true;  
	RydHQB_MAtt = true;
	RydHQC_MAtt = true;  
	RydHQD_MAtt = true;

	RydHQ_Personality = "GENIUS";
	RydHQB_Personality = "GENIUS";
	RydHQC_Personality = "BRUTE";
	RydHQD_Personality = "BRUTE"; 

	RydHQ_Wait = 15; 

	RydHQ_ObjHoldTime = 1;
	RydHQB_ObjHoldTime = 1;  
	RydHQD_ObjHoldTime = 1;   
	RydHQC_ObjHoldTime = 1;  

	RydHQ_AirDist = 400000;   
	RydHQB_AirDist = 400000; 
	RydHQC_AirDist = 400000;   
	RydHQD_AirDist = 400000; 

	RydART_Safe = 200;

	RydHQ_IdleOrd = true;
	RydHQB_IdleOrd = true;
	RydHQC_IdleOrd = true;
	RydHQD_IdleOrd = true;

	RydHQ_ResetTime = 150; 
	RydHQB_ResetTime = 150;
	RydHQC_ResetTime = 150; 
	RydHQD_ResetTime = 150;

	RydHQ_KnowTL = false;

	RydHQ_PathFinding = 0;


	RydxHQ_MARatio = [0.40,0.30,0.25,-1];

	RydHQ_AttackReserve = 0.2;
	RydHQ_ReconReserve = 0.2;

	RydHQ_ExInfo = true;
	RydHQB_ExInfo = true;
	RydHQC_ExInfo = true;
	RydHQD_ExInfo = true;

	RydHQ_Berserk = false;
	RydHQB_Berserk = false;
	RydHQC_Berserk = false;
	RydHQD_Berserk = false;

	RydHQ_Actions = false;
	RydHQ_ActionsAceOnly = false;

	RydHQ_InfoMarkers = true;
	RydxHQ_InfoMarkersID = false;

	RydHQ_BBAOObj = 2;
	RydHQC_BBAOObj = 2;

	RydHQ_CRDefRes = 0.5;
	RydHQB_CRDefRes = 0.5;
	RydHQC_CRDefRes = 0.5;
	RydHQD_CRDefRes = 0.5;


	RydHQ_NoRec = 10000;
	RydHQB_NoRec = 10000;
	RydHQC_NoRec = 10000;
	RydHQD_NoRec = 10000;

	RydHQ_RapidCapt = 0;
	RydHQB_RapidCapt = 0;
	RydHQC_RapidCapt = 0;
	RydHQD_RapidCapt = 0;

	RydHQ_ArtyShells = 0;
	RydHQB_ArtyShells = 0;
	RydHQC_ArtyShells = 0;
	RydHQD_ArtyShells = 0;

	RydxHQ_ReconCargo = true;

	//BIG BOSS SECTION

	RydxHQ_GarrisonV2 = true;

	RydxHQ_NoRestPlayers = true;
	RydxHQ_NoCargoPlayers = true;

	//RHQ SECTION

	RHQ_Art = ["cup_b_m119_us","cup_b_m270_he_usa","lop_tka_static_d30","rhs_m119_d","rhs_m119_wd","rhs_2b14_82mm_vmf","rhs_2b14_82mm_msv","rhs_2b14_82mm_vdv","rhs_d30_vmf","rhs_d30_msv","rhs_d30_vdv","rhs_2s3_tv","rhsusf_m109d_usarmy","rhsusf_m109_usarmy","rhs_m252_d","rhs_m252_wd","rhs_bm21_msv_01","rhs_bm21_chdkz","rhs_bm21_vdv_01","rhs_bm21_vv_01","rhs_bm21_vmf_01","rhsusf_m142_usarmy_wd","rhsusf_m142_usarmy_d"];

	RydHQ_Add_OtherArty = [
		[["cup_b_m270_he_usa","cup_b_m119_us"],["CUP_12Rnd_MLRS_HE","CUP_12Rnd_MLRS_HE","CUP_12Rnd_MLRS_HE","",""]],
		[["rhs_m119_d","rhs_m119_wd"],["RHS_mag_m1_he_12","RHS_mag_m1_he_12","RHS_mag_m1_he_12","rhs_mag_m60a2_smoke_4","rhs_mag_m314_ilum_4"]],
		[["lop_tka_static_d30"],["rhs_mag_of462_10","rhs_mag_of462_10","rhs_mag_of462_10","",""]],
		[["rhs_2b14_82mm_vmf","rhs_2b14_82mm_msv","rhs_2b14_82mm_vdv"],["rhs_mag_3vo18_10","rhs_mag_3vo18_10","rhs_mag_3vo18_10","rhs_mag_d832du_10","rhs_mag_3vs25m_10"]],
		[["rhs_d30_vmf","rhs_d30_msv","rhs_d30_vdv"],["rhs_mag_3of56_10","rhs_mag_3of69m_2","rhs_mag_3of56_10","rhs_mag_d462_2","rhs_mag_s463_2"]],
		[["rhs_2s3_tv"],["rhs_mag_HE_2a33","rhs_mag_LASER_2a33","rhs_mag_WP_2a33","rhs_mag_SMOKE_2a33","rhs_mag_ILLUM_2a33"]],
		[["rhsusf_m109d_usarmy","rhsusf_m109_usarmy"],["rhs_mag_155mm_m795_28","rhs_mag_155mm_m712_2","rhs_mag_155mm_m864_3","rhs_mag_155mm_m825a1_2","rhs_mag_155mm_485_2"]],
		[["rhs_m252_d","rhs_m252_wd"],["rhs_12Rnd_m821_HE","rhs_12Rnd_m821_HE","rhs_12Rnd_m821_HE","",""]],
		[["rhs_bm21_msv_01","rhs_bm21_chdkz","rhs_bm21_vdv_01","rhs_bm21_vv_01","rhs_bm21_vmf_01"],["RHS_mag_40Rnd_122mm_rockets","RHS_mag_40Rnd_122mm_rockets","RHS_mag_40Rnd_122mm_rockets","",""]],
		[["rhsusf_m142_usarmy_wd","rhsusf_m142_usarmy_d"],["rhs_ammo_m26a1_rocket","rhs_ammo_m26a1_rocket","rhs_ammo_m26a1_rocket","",""]]
		];

	nul = [] execVM "RydHQInit.sqf"; 

};

if (acpl_custommarkers) then {
	private ["_acpl_config_buildings"];
	
	acpl_add_buildingmarker = {
		private ["_object", "_pos", "_bound", "_rot", "_bmin", "_markerName", "_marker"];

		_object = _this select 0;

		_pos = getPosATL _object;
		_bound = boundingBoxReal _object;
		_rot = getDir _object;

		_bmin = _bound select 0;
				
		_markerName = format[ "bound_%1", (_object call BIS_fnc_objectVar)];

		_marker = createMarker [_markerName, _pos];
		_marker setMarkerShape "RECTANGLE";
		_marker setMarkerSize [_bmin select 0, _bmin select 1];
		_marker setMarkerDir _rot;
	};
	publicvariable "acpl_add_buildingmarker";
		
	acpl_add_treemarker = {
		private ["_object", "_pos", "_bound", "_rot", "_bmin", "_markerName", "_marker"];

		_object = _this select 0;

		_pos = getPosATL _object;
		_rot = getDir _object;
				
		_markerName = format[ "bound_%1", (_object call BIS_fnc_objectVar)];

		_marker = createMarker [_markerName, _pos];
		_marker setMarkerShape "ICON";
		_marker setMarkerSize [1, 1];
		_marker setMarkerDir _rot;
		_marker setMarkerType "loc_tree";
	};
	publicvariable "acpl_add_treemarker";
		
	acpl_add_bushmarker = {
		private ["_object", "_pos", "_bound", "_rot", "_bmin", "_markerName", "_marker"];

		_object = _this select 0;

		_pos = getPosATL _object;
		_bound = boundingBoxReal _object;
		_rot = getDir _object;
		
		_bmin = _bound select 0;
			
		_markerName = format[ "bound_%1", (_object call BIS_fnc_objectVar)];
		
		_marker = createMarker [_markerName, _pos];
		_marker setMarkerShape "RECTANGLE";
		_marker setMarkerSize [_bmin select 0, _bmin select 1];
		_marker setMarkerDir _rot;
		_marker setMarkerColor "Colorgreen";
	};
	publicvariable "acpl_add_bushmarker";
	
	acpl_config_buildings_inited = false;
	publicvariable "acpl_config_buildings_inited";
	_acpl_config_buildings = compile preprocessFileLineNumbers "acpl_configs\buildings.sqf";
	[] call _acpl_config_buildings;
	
	[] spawn {
		waitUntil {acpl_config_buildings_inited};
		
		{
			if (!(typeof _x in acpl_config_notabuilding)) then {
				_nul = [_x] spawn acpl_add_buildingmarker;
			};
		} foreach allMissionObjects "building";
		{
			if ((typeof _x in acpl_config_bush)) then {
				_nul = [_x] spawn acpl_add_bushmarker;
			};
			if ((typeof _x in acpl_config_tree)) then {
				_nul = [_x] spawn acpl_add_treemarker;
			};
		} foreach allMissionObjects "all";
		{
			if ((typeof _x in acpl_config_bush)) then {
				_nul = [_x] spawn acpl_add_bushmarker;
			};
			if ((typeof _x in acpl_config_tree)) then {
				_nul = [_x] spawn acpl_add_treemarker;
			};
		} foreach allSimpleObjects [];
		
		if (acpl_fnc_debug) then {["ACPL FNCS CUSTOM MARKERS ADDED"] remoteExec ["systemchat",0];};
	};
};

if (_safe_start) then {
	private ["_acpl_safestart_functions"];
	
	acpl_safestart = true;
	publicvariable "acpl_safestart";
	
	if (acpl_fnc_debug) then {["ACPL FNCS: SAFESTART IS ENABLED"] remoteExec ["systemchat",0];};
	
	{
		[_x,"MOVE"] remoteExec ["disableAI",0];
		[_x,"TARGET"] remoteExec ["disableAI",0];
		[_x,"AUTOTARGET"] remoteExec ["disableAI",0];
	} foreach allunits;
	
	acpl_safestart_units = [];
	publicvariable "acpl_safestart_units";
	
	_acpl_safestart_functions = compile preprocessFileLineNumbers "acpl_fncs_toload\safestart.sqf";
	[] call _acpl_safestart_functions;
	
	acpl_safestart_inited = true;
	publicvariable "acpl_safestart_inited";
};

private ["_acpl_hit_react", "_acpl_events", "_acpl_animations_functions", "_acpl_checking_functions", "_acpl_spawning_functions", "_acpl_medical_functions", "_acpl_arty_functions", "_acpl_AI_funcs", "_acpl_medicalAI_funcs"];

_acpl_medicalAI_funcs = compile preprocessFileLineNumbers "acpl_fncs_toload\medical_AI.sqf";
[] call _acpl_medicalAI_funcs;

_acpl_animations_functions = compile preprocessFileLineNumbers "acpl_fncs_toload\animations.sqf";
[] call _acpl_animations_functions;

_acpl_checking_functions = compile preprocessFileLineNumbers "acpl_fncs_toload\AI_checking_funcs.sqf";
[] call _acpl_checking_functions;

_acpl_AI_funcs = compile preprocessFileLineNumbers "acpl_fncs_toload\AI_funcs.sqf";
[] call _acpl_AI_funcs;

_acpl_spawning_functions = compile preprocessFileLineNumbers "acpl_fncs_toload\spawning.sqf";
[] call _acpl_spawning_functions;

_acpl_medical_functions = compile preprocessFileLineNumbers "acpl_fncs_toload\medical.sqf";
[] call _acpl_medical_functions;

_acpl_arty_functions = compile preprocessFileLineNumbers "acpl_fncs_toload\arty.sqf";
[] call _acpl_arty_functions;

_acpl_events = compile preprocessFileLineNumbers "acpl_fncs_toload\events.sqf";
[] call _acpl_events;

_acpl_hit_react = compile preprocessFileLineNumbers "acpl_fncs_toload\hit_reaction.sqf";
[] call _acpl_hit_react;

if (_ied_init) then {
	private ["_acpl_ied_functions"];

	_acpl_ied_functions = compile preprocessFileLineNumbers "acpl_fncs_toload\ied.sqf";
	_null = [] call _acpl_ied_functions;
	
	acpl_ied_trigger_phone = ["ACE_Cellphone"];
	acpl_ied_trigger_clacker = ["ACE_M26_Clacker","ACE_Clacker"];
	publicvariable "acpl_ied_trigger_clacker";
	publicvariable "acpl_ied_trigger_phone";
	
	acpl_ied_jammers = [];
	publicvariable "acpl_ied_jammers";
	
	[[{
		params ["_unit", "_range", "_explosive", "_fuzeTime", "_triggerItem"];
		if (_triggerItem == "ace_cellphone") exitwith {if ([_explosive,"ACE_Cellphone"] call acpl_ied_jammed) then {systemChat "Your Cell Phone signal was blocked";false};};
		if (_triggerItem == "ACE_M26_Clacker") exitwith {if ([_explosive,"ACE_M26_Clacker"] call acpl_ied_jammed) then {systemChat "Your Cell Phone signal was blocked";false};};
		if (_triggerItem == "ACE_Clacker") exitwith {if ([_explosive,"ACE_Clacker"] call acpl_ied_jammed) then {systemChat "Your Cell Phone signal was blocked";false};};
		true;
	}],ace_explosives_fnc_addDetonateHandler] remoteExec ["call",0,true];
	
	acpl_ied_fncs_initied = true;
	publicvariable "acpl_ied_fncs_initied";
};

private ["_acpl_tfr_functions", "_acpl_loop_functions", "_acpl_load_actions"];

_acpl_tfr_functions = compile preprocessFileLineNumbers "acpl_fncs_toload\tfr.sqf";
[] call _acpl_tfr_functions;

_acpl_loop_functions = compile preprocessFileLineNumbers "acpl_fncs_toload\loop.sqf";
[] call _acpl_loop_functions;

_acpl_load_actions = compile preprocessFileLineNumbers "acpl_fncs_toload\actions.sqf";
[] call _acpl_load_actions;
[[],acpl_load_actions] remoteExec ["call",0,true];

if (acpl_medical) then {
	{
		_x additemCargoGlobal ["ACE_fieldDressing",acpl_fieldDressing_veh];
		_x additemCargoGlobal ["ACE_elasticBandage",acpl_elasticBandage_veh];
		_x additemCargoGlobal ["ACE_adenosine",acpl_adenosine_veh];
		_x additemCargoGlobal ["ACE_atropine",acpl_atropine_veh];
		_x additemCargoGlobal ["ACE_bloodIV",acpl_bloodIV_veh];
		_x additemCargoGlobal ["ACE_bodyBag",acpl_bodyBag_veh];
		_x additemCargoGlobal ["ACE_epinephrine",acpl_epinephrine_veh];
		_x additemCargoGlobal ["ACE_morphine",acpl_morphine_veh];
		_x additemCargoGlobal ["ACE_packingBandage",acpl_packingBandage_veh];
		_x additemCargoGlobal ["ACE_plasmaIV",acpl_plasmaIV_veh];
		_x additemCargoGlobal ["ACE_salineIV",acpl_salineIV_veh];
		_x additemCargoGlobal ["ACE_surgicalKit",acpl_surgicalKit_veh];
		_x additemCargoGlobal ["ace_tourniquet",acpl_tourniquet_veh];
		_x additemCargoGlobal ["ACE_quikclot",acpl_quicklot_veh];
		_x additemCargoGlobal ["FSGm_ItemMedicBagMil",acpl_medicbag_veh];
		_x additemCargoGlobal ["ACE_personalAidKit",acpl_PAK_veh];
		_x addBackpackCargoGlobal ["vurtual_stretcher_bag",acpl_stretcher_veh];
		
		_x setVariable ["ace_medical_isMedicalFacility",true,true];
		_x setVariable ["ace_medical_medicClass",2,true];
	} foreach acpl_medical_mc
};

[[_static], acpl_loop] remoteExec ["spawn",2];
[[], acpl_weather_loop] remoteExec ["spawn",2];

acpl_enemy_artillery = [];
publicvariable "acpl_enemy_artillery";

_acpl_config_buildings_pos = compile preprocessFileLineNumbers "acpl_configs\buildings_positions.sqf";
[] call _acpl_config_buildings_pos;

acpl_fncs_initied = true;
publicvariable "acpl_fncs_initied";

if (isNil "acpl_mainloop_done") then {acpl_mainloop_done = false};

waitUntil {acpl_mainloop_done};

[[], acpl_heal_loop] remoteExec ["spawn",2];

_nul = execVM "ASF\asf_governor.sqf";

acpl_buildings_takenpos = [];
publicvariable "acpl_buildings_takenpos";

if (acpl_fnc_debug) then {["ACPL FNCS INITED"] remoteExec ["systemchat",0];};