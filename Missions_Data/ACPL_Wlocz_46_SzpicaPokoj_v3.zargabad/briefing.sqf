params ["_text"];

[["","BLACK IN", 7]] remoteExec ["titleCut",0];

if (isDedicated) then {
	{[[_text, str(date select 2) + "." + str(date select 1) + "." + str(date select 0), str(name _x)],BIS_fnc_infoText] remoteExec ["spawn",_x,true];} foreach allPlayers;
} else {
	[[_text, str(date select 2) + "." + str(date select 1) + "." + str(date select 0), str(name player)],BIS_fnc_infoText] remoteExec ["spawn",0,true];
};

[[[
  ["task1","Zająć wioskę Jarum","Zająć wioskę Jarum na przedmieściach Al Sukhnal.",true],
  ["task2","Wyprzeć bojowników Państwa Islamskiego z al Sukhnal","Wyprzeć bojowników Państwa Islamskiego z al Sukhnal przechrzczonego przez bojowników na Zargabad. Zająć i nie uszkodzić meczet.",true],
  ["task3","Zająć lotnisko","Oczyścić lotnisko na zachodzie od Al Sukhnal.",true]
],[
  ["Sytuacja","Operacja Khuzam - 06.08.2017<br/>
<br/>
Wojna domowa w Syrii wciąż trwa od 2011 roku. ISIS znane też jako Państwo Islamskie od 2014 było w natarciu aż rok temu to my przejeliśmy inicjatywę  przy wsparciu Rosjan. Jako szpica natarcia i elitarna jednostka Tiger Force, mamy za zadanie zdobyć Al Sukhnal i otworzyć wojskom SAA (Syrian Arab Army) drogę na oblężone od lipca 2014 roku Deir Ez Zor. Dziś po miesiącu przygotowań mamy zająć Al Sukhnal i przełamać front. Jednym z ważniejszych celów w okolicy jest meczet w centrum miasta. Ma on zostać nienaruszony z powodu celów historyczno-kulturowych i propagandowych. Bojownicy Państwa Islamskiego okopali się w całym mieście, na pobliskim lotnisku oraz w wiosce przed miastem. Mamy dziś piękną pogodę i wsparcie z powietrza. Allah nam sprzyja!.",true],
  ["Zadanie","Jasne wytyczne dla CAŁEGO PLUTONU lub jednostki operacyjnej, z wyszczególnieniem daty, godzin i najlepiej oczekiwany przedział czasowy na wykonanie zadania.<br/>
<br/>
CEL PODSTAWOWY: Zająć Meczet w Al Suknal (Zagrabad).<br/>
CELE DRUGORZEDNE:<br/>
- Zajęcie Lotniska
- Zajecie wioski Jarum
- Minimalizacja strat własnych, cywilnych.<br/>",true],
  ["Wykonanie","Proponuje się zajęcie Jarum i oczyszczenie jej wschodniej części, następnie ruch w kierunku meczetu, a po jego zajeciu oczyszczenie wschodniej części miasta. Następnie natarcie na lotnisko. Istnieje również możliwość zniszczenia obrony przeciwlotniczej wroga kryjącej się na dachach budynków w Al Sukhnal po zajęciu Jarum, które góruje nad miastem. Umożliwiło by to desant z pomocą Mi-24 jednej drużyny na tyły nic nie spodziewającego się wroga:<br/>
- Pojazdy i lotnictwo wspierają piechotę;<br/>",true],
  ["Wywiad","Informacje o wrogu, pogodzie:<br/>
Przeciwnik:<br/>
- Przeciwnikiem są bojownicy z tzw. Państwa Islamskiego;
- Około 150 terrorystów w terenie działania;<br/>
- Wróg posiada stary sprzęt radziecki i część amerykańskiego uzbrojenia zdobytego w Iraku;<br/>
- Wróg posiada obronę przeciwlotniczą, w tym nieliczne pociski kierowane i niekierowane produkcji głównie radzieckiej;<br/>
- Poziom wyszkolenia dobry;<br/>
- Morale wysokie, ideowcy;<br/>
- Odniesienie do terenu i ewentualnej przewagi środowiskowej bądź liczebnej - brak;<br/>
- Określenie poziomu zagrożenia minami \ IED i zamachami samobójczymi - Pole minowe przy sztabie wroga, reszta brak informacji;<br/>
- Ewentualne inne przydatne informacje - Na wieży w Jarum znajduje się wrogi ATGM i snajper który zdjął naszego strzelca. Musicie go zdjąć gdy tylko dojedziecie do naszego posterunku.<br/>
- Możliwe posiłki i kontrataki wroga;<br/>
<br/>
Pogoda:<br/>
- Pogoda dobra, w większości bezchmurnie;<br/>
- określenie przewidywanej \ znanej widoczności - około 1000 metrów;<br/>
- 20 stopni Celcjusza na plusie;<br/>
<br/>
Ludność Cywilna:<br/>
- Brak info o cywilach, większość ewakuowana najpewniej przed bitwą;<br/>
- informacje o afilacji i ewentualne ostrzeżenia o kolaboracji - brak;<br/>
- wytyczne dot. zagrożenia i postępowania z ludnością cywilną, ewentualne ostrzeżenia - 'cywile' są wrogami;<br/>
- ewentualne informacje o lokacjach informatorów \ informacjach od nich - brak;<br/>
- ewentualne inne wytyczne \ informacje dot. 'hearts and minds' - brak.<br/>
<br/>
Teren:<br/>
- 'zalesienie' małe;<br/>
- mało zabudowań, słaba widoczność z nich;<br/>
- informacje o ewentualnych umocnieniach i pochodzeniu owych (czy aktualne czy 'stare') - pojedyńcze umocnione punkty oporu w mieście;<br/>
- ewentualne informacje o strefach wyłączonych z walki \ niedopuszczalnym collateral damage (np. meczet) - brak;<br/>
- ewentualne informacje o sugerowanej drodze podejścia (z uzasadnieniem dlaczego). - w 'WYKONANIE'<br/>
<br/>
Siły sojusznicze:
- poza dzialajacymi w tym rejonie silami 3 plutonu, brak sil wlasnych oraz sprzymierzonych w obrebie 2 kilometrow od terenu operacji; mozliwy ruch sil wlasnych droga powietrzna.<br/>
",true],
  ["Przydzial",
  "Przydzial:<br/>
- Callsigny, HQ, Rifat, Elias, Haya, Uri, Hasan;
- Bezposrednio pod rozkazami Sztabu Polowego 3 Plutonu;
- Komunikacja w obrebie druzyny i plutonu.<br/>
<br/>
Sprzet<br/>
- Posiadamy wyrzutnie typu RPG;<br/>
- Wsparciem piechoty będą Haya 1 i Haya 2, dodatkowo Uri 1 i Uri 2;<br/>
- informacje o możliwościach wykorzystania sprzętu - korzystac bez ograniczen i wedle uznania.<br/>
<br/>
Wsparcie<br/>
- informacje o dostępnych jednostkach wsparcia lub jego braku - brak;<br/>
<br/>
Lacznosc<br/>
- standard lacznosci wewnatrz Elias 1: komunikacja za pomoca Squad Radio czestotliwosc 151;<br/>
- standard lacznosci wewnatrz Elias 2: komunikacja za pomoca Squad Radio czestotliwosc 152;<br/>
- standard lacznosci wewnatrz Elias 3: komunikacja za pomoca Squad Radio czestotliwosc 153;<br/>
- standard lacznosci wewnetrz Elias i HQ: komunikacja radiostacją, standardowy kanal 40, Hasan - 41, Uri i Haya - 42;<br/>
- ewentualne informacje o priorytecie nadawania \ dodatkowych ograniczeniach komunikacji.<br/>
<br/>
Zasady Użycia Siły<br/>
- standardowe ZUS czasu wojny \ misji stabilizacyjnej.<br/>
  ",true],
  ["Technikalia","Odczekać chwilę po starcie misji - ładują się skrypty. Drużyna HQ ma zostać w bazie lub na tyłach i kierować atakiem poprzez wydawanie rozkazów na radiu długim, wyznaczyc jedną osobę, która będzie jeździła z rannymi na tyły w celu opatrzenia rannych przez lekarza z drużyny HQ. <img image='assad.jpg' width='200' height='200'/> <img image='assad1.jpg' width='350' height='350'/> <img image='assad2.jpg' width='200' height='200'/> <img image='assad3.jpg' width='200' height='200'/> misje i memy wybieral Matt ;/",true]
]],ACPL_MM_Core_fnc_shk_taskmaster] remoteExec ["spawn",0,true];

//Komendy do briefingu:
// 
// - <br/> - przechodzi do nowej lini
// - <marker name='marker_name'>Tekst do kliknięcia</marker> - tworzy tekst po kliknięciu na który pokazuje miejsce na mapie oznaczone markerem, 
//marker_name <- nazwa markeru który ma pokazać
//<img image='jack.jpg' width='200' height='200'/>
//