/*
Wrzucasz do folderu misji, uruchamiać na triggerze/waypoincie przez wpisanie w uruchamianiu:

[] execVM "Wiad2.sqf";
*/

if (!isserver) exitwith {};
exp1 setdamage 1;

sleep 5;

[Straznik2,"Cholera Andrzej mówił że to jebnie..., Dobra Panowie dajecie gaz do dechy i uciekajcie my zajmiemy się nieproszonymi goścmi którzy już napewno są blisko."] remoteExecCall ["sidechat",0];

sleep 2;

exp3 setdamage 1;

[Straznik2,"<odgłosy walki>Kurwa...<wydawanie rozkazów>"] remoteExecCall ["sidechat",0];

sleep 3;

exp2 setdamage 1;

[Straznik2,"Gazu Cholera ! Strażnik 1 to JEST ROZKAZ ! <ktoś wbiega do namiotu i słychać z daleka - Oni mają czołg !> Jak to kurwa czołg skąd... <wybiega z namiotu>"] remoteExecCall ["sidechat",0];