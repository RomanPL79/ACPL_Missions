[[[
  ["tsk1","Czołg","Naprawić lub zniszczyć uszkodzony czołg.",true],
  ["tsk2","Wycofać się","Wycofać się do <marker name='retreat'>Kabanino</marker>",true]
],[
  ["Sytuacja","Ranienyj Zwier<br/>
<br/>
Nasz oddział, wsparty przez czołg T-80, został wysłany do wsi <marker name='start'>Rogovo</marker> w celu jej sprawdzenia.<br/>
Po dotarciu do wsi natknęliśmy się na czedacki konwój, który szybko wyeliminowaliśmy. Niestety wtrakcie walki jeden z czedaków zdołał trafić nasz czołg i uszkodzić silnik oraz bak paliwa.<br/>
T-80 jest aktualnie unieruchomione. Załoga czołgu twierdzi, że są wstanie naprawić swoją maszynę, lecz potrzebują uzupełnić paliwo. Niestety z powodu ciężkich walk w okolicy jesteśmy zdani wyłącznie na siebie - sztab nie jest wstanie wysłać dodatkowych sił do Rogova.<br/>
Gdzieś we wsi musi znajdować się jakieś paliwo.<br/>
<br/>
Rebelianci wiedzą o naszej obecności we wsi. Wygląda na to, że przegrupowywują się we wsi <marker name='enemy'>Pogorevka</marker>. Zapewne będą próbowali zdobyć uszkodzony czołg.",true],
  ["Zadanie","CEL PODSTAWOWY: Ewakuować się. Czołg nie może wpaść w ręce wroga!<br/>
CELE DRUGORZEDNE:<br/>
- Brak strat.<br/>
- Naprawienie czołgu.<br/>",true],
  ["Wykonanie"," - Aktualnie znajdujemy się przy budynku <marker name='start'>poszty</marker> w Rogovie.<br/>
- W czasie gdy czołgiści będą naprawiać czołg musimy przeszukać wieś i zdobyć paliwo.<br/>
- Po uruchomieniu czołgu musimy wycofać się do <marker name='retreat'>Kabanina</marker><br/>",true],
  ["Wywiad","Przeciwnik:<br/>
- Naszym przeciwnikiem są komunistyczni rebelianci.<br/>
- Wróg korzysta z przestarzałego radzieckiego sprzętu.<br/>
- Nie znamy liczebności przeciwnika w AO.<br/>
- Wróg posiada broń AT.<br/>
- Wróg posiada sprzęt pancerny.<br/>
<br/>
Pogoda:<br/>
- Aktualnie słonecznie, dobra widoczność.<br/>
- Spodziewane znaczące pogorszenie pogody w nadchodzących godzinach.<br/>
<br/>
Ludność Cywilna:<br/>
- Brak ludności cywilnej w okolicy - zostali ewakuowani, zabici lub uciekli.<br/>
<br/>
Siły sojusznicze:
- <marker name='retreat'>Kabanino</marker> jest strzeżone przez niewielki oddział CDF.<br/>
",true],
  ["Przydzial",
  "Sprzet<br/>
- Posiadacie 1 UAZ uzbrojony w DSzKM oraz 1 cięzarówkę ZiL.<br/>
- Brak dodatkowej amunicji oraz sprzętu.<br/>
<br/>
Wsparcie<br/>
- Brak.<br/>
<br/>
Lacznosc<br/>
- standard lacznosci wewnatrz druzyny STRIEŁA-1: komunikacja za pomoca Squad Radio czestotliwosc 121;<br/>
- standard lacznosci wewnetrz plutonu i z TOC: komunikacja radiostacją, standardowy kanal 50;<br/>
<br/>
Zasady Użycia Siły<br/>
- standardowe ZUS czasu wojny.<br/>
  ",true],
  ["Technikalia","Karnistry oraz beczki z benzyną są możliwe do przenoszenia. Da się je również załadować do pojazdu.",true]
]],"shk_taskmaster.sqf"] remoteExec ["execvm",0,true];

//Komendy do briefingu:
// 
// - <br/> - przechodzi do nowej lini
// - <marker name='marker_name'>Tekst do kliknięcia</marker> - tworzy tekst po kliknięciu na który pokazuje miejsce na mapie oznaczone markerem, 
//marker_name <- nazwa markeru który ma pokazać
//<img image='jack.jpg' width='200' height='200'/>
//