params ["_text"];

[["","BLACK IN", 7]] remoteExec ["titleCut",0];

if (isDedicated) then {
	{[[_text, str(date select 2) + "." + str(date select 1) + "." + str(date select 0), str(name _x)],BIS_fnc_infoText] remoteExec ["spawn",_x,true];} foreach allPlayers;
} else {
	[[_text, str(date select 2) + "." + str(date select 1) + "." + str(date select 0), str(name player)],BIS_fnc_infoText] remoteExec ["spawn",0,true];
};

[[[
  ["task1","Zlikwidować generałów","Mamy za zadanie zlikwidować generałów.",true],
  ["task2","Zabezpieczyć miejsce wymiany","Po opanowaniu sytuacji, wysadzić sprzęt wroga.",true]
],[
  ["Sytuacja","Operacja Świt - 18.04.2020<br/>
<br/>
Sytuacja w Nigerii staję się coraz bardziej napięta ze względu na rosnącą siłe islamskiej bojówki Boko Haram. Otrzymaliśmy informacje o zakupie broni przez bojówkę na jednej z wysp nigeryjskich. Wymiana ta ma szczególny charakter, ponieważ bojówka szykuje się do przejęcia władzy w kraju a jest to ich jeden z największyć zakupów broni dotychczas. Z tego powodu rząd nigeryjski poprosił nas o wsparcie oraz ewentualną możliwość udaremnienia tej wymiany.
",true],
  ["Zadanie","Udać się na miejsce kupna broni, pozbyć się handlarzy, przejąć jak najwięcej broni.<br/>
<br/>
CEL PODSTAWOWY: Likwidacja generałów oraz wysadzenie sprzętu<br/>
CELE DRUGORZEDNE:<br/>
- Minimalizacja strat własnych.<br/>",true],
  ["Wykonanie","Zaleca się transport na południową część wyspy reszte ustala dowódca<br/>
;<br/>",true],
  ["Wywiad","Informacje o wrogu, pogodzie:<br/>
Przeciwnik:<br/>

- Przeciwnikiem to bojówka Boko Haram oraz komunistyczne siły czarnoruskie;
- Około 80 ludzi w pobliżu;<br/>
- Wróg posiada nowoczesny sprzęt;<br/>
- Obrona P-Lot w obrębie miasta oraz na lostnisku; <br/>
- Poziom wyszkolenia dobry;<br/>
- Morale wysokie;<br/>
- odniesienie do terenu i ewentualnej przewagi środowiskowej bądź liczebnej - brak;<br/>
- określenie poziomu zagrożenia minami \ IED i zamachami samobójczymi - brak;<br/>
- ewentualne inne przydatne informacje - brak.<br/>
<br/>
Pogoda:<br/>
- Pogoda dobra, w większości bezchmurnie;<br/>
- określenie przewidywanej \ znanej widoczności - około 1000 metrów;<br/>
- 20 stopni Celcjusza na plusie;<br/>
<br/>
Ludność Cywilna:<br/>
- Brak info o cywilach;<br/>
- informacje o afilacji i ewentualne ostrzeżenia o kolaboracji - brak;<br/>
- wytyczne dot. zagrożenia i postępowania z ludnością cywilną - brak;<br/>
- ewentualne informacje o lokacjach informatorów \ informacjach od nich - brak;<br/>
- ewentualne inne wytyczne \ informacje dot. 'hearts and minds' - brak.<br/>
<br/>
Teren:<br/>
- 'zalesienie' duże;<br/>
- mało zabudowań, słaba widoczność z nich;<br/>
- informacje o ewentualnych umocnieniach i pochodzeniu owych (czy aktualne czy 'stare') - brak;<br/>
- ewentualne informacje o strefach wyłączonych z walki \ niedopuszczalnym collateral damage (np. meczet) - brak;<br/>
- ewentualne informacje o sugerowanej drodze podejścia (z uzasadnieniem dlaczego). - w 'WYKONANIE'<br/>
<br/>
Siły sojusznicze:
- poza dzialajacymi w tym rejonie silami 3 plutonu, brak sil wlasnych oraz sprzymierzonych w obrebie 2 kilometrow od terenu operacji; mozliwy ruch sil wlasnych droga powietrzna.<br/>
",true],
  ["Przydzial",
  "Przydzial:<br/>
- Callsigny, Alpha, Bravo, Eagle;
- Bezposrednio pod rozkazami Sztabu Polowego 3 Plutonu;
- Komunikacja w obrebie druzyny i plutonu.<br/>
<br/>
Sprzet<br/>
- Wsparciem piechoty będzie Eagle;<br/>
- informacje o możliwościach wykorzystania sprzętu - korzystac bez ograniczen i wedle uznania.<br/>
<br/>
Wsparcie<br/>
- informacje o dostępnych jednostkach wsparcia lub jego braku - brak;<br/>
<br/>
Lacznosc<br/>
- standard lacznosci wewnatrz Alpha 1: komunikacja za pomoca Squad Radio czestotliwosc 51;<br/>
- standard lacznosci wewnatrz Alpha 2: komunikacja za pomoca Squad Radio czestotliwosc 52;<br/>
- standard lacznosci wewnatrz Alpha 3: komunikacja za pomoca Squad Radio czestotliwosc 53;<br/>
- standard lacznosci wewnetrz Alpha i HQ: 50 ;<br/>
- ewentualne informacje o priorytecie nadawania \ dodatkowych ograniczeniach komunikacji.<br/>
<br/>
Zasady Użycia Siły<br/>
- standardowe ZUS czasu wojny \ misji stabilizacyjnej.<br/>
  ",true],
  ["Technikalia","Odczekać chwilę po starcie misji - ładują się skrypty.",true]
]],ACPL_MM_Core_fnc_shk_taskmaster] remoteExec ["spawn",0,true];

//Komendy do briefingu:
//
// - <br/> - przechodzi do nowej lini
// - <marker name='marker_name'>Tekst do kliknięcia</marker> - tworzy tekst po kliknięciu na który pokazuje miejsce na mapie oznaczone markerem,
//marker_name <- nazwa markeru który ma pokazać
//<img image='jack.jpg' width='200' height='200'/>
//
