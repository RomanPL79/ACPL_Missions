/*
Wrzucasz do folderu misji, uruchamiać na triggerze/waypoincie przez wpisanie w uruchamianiu:

[] execVM "Nauk.sqf";
*/

if (!isserver) exitwith {};
[Naukowcy,"Zespół Badawczy wita bohaterów."] remoteExecCall ["sidechat",0];
sleep 10;
[Naukowcy,"Zostaw pojazd z dronem i próbką na oznaczonym miejscu my zajmiemy się resztą."] remoteExecCall ["sidechat",0];
sleep 10;
[Naukowcy,"HQ kazało wam przekazać że jesteście potrzebni na lotnisku Lukow, ale macie rozkaz jechać przez wieś Wrzeszcz. Drogi na północ nie są już bezpieczne.
Straciliśmy kontakt ze Strażnikiem 2 i trzeba ustalić dalszy plan działania. Powodzenia Panowie."] remoteExecCall ["sidechat",0];
sleep 15;
exp4 setdamage 1;
sleep 2;
[Naukowcy,"Co to do cholery było ?!."] remoteExecCall ["sidechat",0];
sleep 4;
[Naukowcy,"Dąb, Tu posterunek naukowy jesteśmy atakowani przyślijcie wsparcie?!."] remoteExecCall ["sidechat",0];