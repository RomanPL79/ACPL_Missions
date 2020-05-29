/*
Wrzucasz do folderu misji, uruchamiać na triggerze/waypoincie przez wpisanie w uruchamianiu:

[] execVM "Dab.sqf";
*/

if (!isserver) exitwith {};

sleep 50;

[Dab,"Tu Dąb, Odmawiam. Macie silny Garnizon musicie dać radę z tym co macie. Mamy własne problemy. Strażnik 1 zrywajcie kontakt i ruszajcie do wsi Wrzeszcz a następnie na lotnisko."] remoteExecCall ["sidechat",0];

sleep 10;

