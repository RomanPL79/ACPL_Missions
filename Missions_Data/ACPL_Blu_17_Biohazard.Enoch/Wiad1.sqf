/*
Wrzucasz do folderu misji, uruchamiać na triggerze/waypoincie przez wpisanie w uruchamianiu:

[] execVM "Wiad1.sqf";
*/

if (!isserver) exitwith {};

[Straznik2,"Panowie dobrze że już jesteście. Pobierzcie tę próbkę i zmywajcie się z nią do bazy na południu."] remoteExecCall ["sidechat",0];

sleep 10;

[Straznik2,"Wywiad dostarcza nam jakieś dziwne informacje odkąd to gówno uderzyło w wentylator."] remoteExecCall ["sidechat",0];

sleep 10;

[Straznik2,"Najszybciej dotrzecie tam jadąc główną drogą na południe w kierunku miejscowości Polana jest to też najbezpieczniejsza droga Powodzenia."] remoteExecCall ["sidechat",0];