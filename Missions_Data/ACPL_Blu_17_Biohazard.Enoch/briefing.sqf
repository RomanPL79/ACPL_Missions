params ["_text"];

[["","BLACK IN", 7]] remoteExec ["titleCut",0];

if (isDedicated) then {
	{[[_text, str(date select 2) + "." + str(date select 1) + "." + str(date select 0), str(name _x)],BIS_fnc_infoText] remoteExec ["spawn",_x,true];} foreach allPlayers;
} else {
	[[_text, str(date select 2) + "." + str(date select 1) + "." + str(date select 0), str(name player)],BIS_fnc_infoText] remoteExec ["spawn",0,true];
};

[[[
  ["tsk1","Zebrać próbkę.","Pobrać próbkę materiału biologicznego za pomocą drona i dostarczenie go bezpiecznie do bazy wyposarzonej w przenośne laboratorium biologiczne.",true],
  ["tsk2","RTB.","Wycofać się do miejsca garnizonowania.",true]
],[
  ["Sytuacja","Operacja Biohazard - 03.05.2035<br/>
<br/>
W pobliskiej miejscowości Topolin miejscowy stróż podczas obchodu obiektu znalazł podejrzany pojemnik opisany w nieznanym mu języku. 
Zbiornik miał jednak symbol zagrożenia biologicznego cywil po rozpoznaniu go niezwłocznie skontaktował się z lokalnymi władzami którę poprosiły wojsko o pomoc.
Stróż twierdzi że nie miał kontaktu z innymi osobami i został poddany kwarantannie. Obecnie znajduje się w szpitalu wojskowym. 
Waszym zadaniem będzie przybycie na miejsce zabezpieczone już przez nasze wojska pobranie próbki za pomocą drona oraz bezpieczne dostarczenie jej do Laboratorium znajdującego się w bazie w miejscowości Nadbór. <br/><br/>",true],
  ["Zadanie","Wyruszacie z lotniska Lukow udajecie się do Topolina gdzie pobieracie próbkę i odstawiacie ją do bazy w Nadbór .<br/>
<br/>
CEL PODSTAWOWY: Pobierz i dostarcz próbkę.<br/>
CELE DRUGORZEDNE:<br/>
- Unikaj kontaktu z próbką na ile to możliwe.;<br/>
- Nie pozwól cywilom zbliżyć się do strefy zagrożenia.<br/>",true],
  ["Wykonanie","Obieracie najkrótszą trase z możliwych i unikacie kontaktu z personelem wojskowym oraz cywilami. Po powrocie do bazy cały oddział i sprzęt zostanie poddany dekontaminacji oraz kwarantannie.:<br/>
- Drużyna zabezpieczenia obstawia teren, jest czujką, zwiadem oraz tarczą waszego zespołu.;<br/>
- Drużyna biologiczna Pobiera próbkę dronem pakuje go do pojazdu, zabezpiecza i transportuje ją do celu.;<br/>",true],
   ["Wywiad","Informacje o wrogu, pogodie, itd, np.:<br/>
Przeciwnik:<br/>
-Brak.;<br/>
Pogoda:<br/>
- Pogoda słoneczna.;<br/>
- Widoczność dobra.;<br/>
<br/>
Ludność Cywilna:<br/>
- Cywile na terenie działań poza skażoną miejscowością która została ewakuowana.;<br/>
- Ludność lokalna oraz mniejszość rosyjska.;<br/>
<br/>
Teren:<br/>
- Pola, łąki, lasy, tereny miejskie i wiejskie;<br/>
<br/
Siły sojusznicze:
- Wojska zabezpieczenia skażeń bio-chem z 3 brygady OPBMR. Strażnik 2 zabezpiecza strefe zagrożenia.<br/>
",true],
  ["Przydzial",
  "Przydzial:<br/>
- 1 pluton wsparcia logistycznego;<br/>
- Nasz kryptonim to Strażnik 1;
- Jesteśmy jenostką pod rozkazami 3 brygady OPBMR.;
<br/>
Sprzet<br/>
- Wszystko z przydziału;<br/>
- Busy cargo oraz transport + jeden z offroad;<br/>
- Brak dostępnego sprzętu lotniczego oraz ciężkiego;<br/>
<br/>
Wsparcie<br/>
- Brak;<br/>
<br/>
Lacznosc<br/>
- Do ustalenia przez dowódcę zespołu.
- Kontakt z HQ oraz Strażnikiem 2 = LR 50
<br/>
Zasady Użycia Siły<br/>
- Czas pokoju.<br/>
  ",true],
  ["Technikalia","Każdy kto wszedł w kontakt z bio material musi przejść przez śluzę przy budynku ze skażoną skrzynką. Skrzynia zostaje na miejscu. Dron z materiałem musi być przewieziony osobno od oddziału w cargo. Po wejściu do budynku otwieramy tylko drzwi wejściowe i do pomieszczenia ze skrzynką. 
  Na misje trzeba zabrać operatora drona naziemnego. Ważne żeby czytać co mówią NPC od tego zależy wasze życie i przebieg misji. ",true]
]],ACPL_MM_Core_fnc_shk_taskmaster] remoteExec ["spawn",0,true];

//Komendy do briefingu:
// 
// - <br/> - przechodzi do nowej lini
// - <marker name='marker_name'>Tekst do kliknięcia</marker> - tworzy tekst po kliknięciu na który pokazuje miejsce na mapie oznaczone markerem, 
//marker_name <- nazwa markeru który ma pokazać
//<img image='jack.jpg' width='200' height='200'/>
//