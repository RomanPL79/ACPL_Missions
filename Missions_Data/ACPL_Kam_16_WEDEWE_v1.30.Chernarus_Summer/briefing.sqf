[[[
  ["tsk1","Zadanie","Unieszkodliwić wrogi zagłuszacz",true]
],[

  ["Sytuacja","
Operacja Psia Karma - 12.05.2015<br/>
<br/>
Mimo dostarczenia separatystom ogromnych ilości broni i przerzuceniu prawie całej dywizji spadochroniarzy nadal nie jesteśmy w stanie wywalczyć bezpiecznego miejsca dla życia naszych braci.
Za dnia odpieramy kolejne ataki czołgów, a w nocy kryjemy się przed nawałnicą artylerii. Im dłużej to wszystko trwa tym
bardziej rysuje się przewaga ukrów. Po ich stronie widzimy coraz więcej amerykańskiego sprzętu a ostatnio pojawił się dodatkowy problem:<br/>
<br/>
Po drugiej stronie frontu zaczął pracować zagłuszacz sygnału. Najprawdopodobnie jest to nasz R-934B pamiętający jeszcze lata 80.
Jednak to wystarczy aby sparaliżować komunikację po naszej stronie. Ukraińcy usiedli na falach wykorzystywanych przez lotnictwo i baterie artyleryjskie. 
<br/>W skróconej wersji: jesteśmy w dupie!
",true],


  ["Zadanie","
CEL PODSTAWOWY: Elimacja wrogiego zagłuszacza<br/>
CELE DRUGORZEDNE:<br/>
- Minimalizacja strat własnych<br/>
- Zniszczenie jak największej ilości sprzętu wojskowego znalezionego w okolicy celu 
(jeśli nie będzie to opóźniać waszych działań)
",true],


  ["Wykonanie","
Za linię frontu zostaniecie przerzuceni przy pomocy amerykańskiego samolotu C-130. Został on przejęty po naszym ataku na lotnisko w Ługańsku.
Mamy nadzieję, że ukraińcy uznają ten samolot za sojuszniczy zrzut wsparcia i zyskacie element zaskoczenia.
<br/><br/>
To była ta łatwa część planu. Po lądowaniu macie PO CICHU zbliżyć się do celu tak blisko jak się da i wziąć wioskę z zaskoczenia.
Im dłużej wasza akcja będzie się przeciągać tym więcej wsparcia zdoła przyjechać z okolicznych baz. Przylot śmigłowca ewakuacyjnego potrwa około minuty
więc odpowiednio się z nim zgrajcie.<br/><br/>
Jest jeszcze jedna ważna rzecz, o której warto wspomnieć. Póki zagłuszacz pracuje to nie będziemy w stanie się z wami skontaktować czy wysłać pomocy więc jesteście zdani sami na siebie.
Co prawda blokuje on łączność na radiach długofalowych jednak jego sygnał jest tak mocny, że w otoczeniu około kilometra od niego zaczną się też problemy z krótkim radiem.
O ile w strefie lądowania łączność będzie jeszcze w miarę to w okolicy wioski najprawdopodobniej stracicie kontakt między drużynami. <br/>
PLAN MUSI BYĆ ROZPISANY TAK ABY DAŁO SIĘ GO WYKONAĆ BEZ ŁĄCZNOŚCI RADIOWEJ
",true],


  ["Wywiad","
Operujecie za linią frontu więc atak będzie dla wroga dużym zaskoczeniem jeżeli nie dacie się wykryć. 
Zwiad satelitarny wykrył obecność wrogiego parku maszynowego jednak prawdopodobnie nie ma się czego obawiać gdyż pojazdy
przechodzą tam poważne naprawy. Szacujemy, że prawdopodobnie jeden BTR jest zdolny do walki. Piechota to jednostki tyłowe i
technicy walki elektronicznej, na pewno będą dużo szczekać ale krzywdy wam nie zrobią. Liczebność oceniamy na 20 do 40 piechociarzy. 
Wioska posiada kilka symbolicznie umocnionych punktów przy północnym i południowym wjeździe.
",true],


  
  ["Technikalia","
Przebieg misji (sygnał do startu c-130, wezwanie ewakuacji, odlot ewakuacji) kontrolowane są z panelu radia. TYCH OPCJI NIE DOTYKA NIKT POZA DOWÓDCĄ LUB OSOBĄ WYZNACZONĄ, inaczej misja będzie do restartu.
Skok odbędzię się automatycznie od samego wyskoczenia z samolotu po otwarcie spadochronu. W skrócie, macie tylko wylądować i nic wcześniej nie naciskać. Ai skacze razem z wami jeśli wsadzicie je do samolotu z taką różnicą, że nie muszą mieć oni spadochronów.
Gracze MUSZĄ posiadać spadochrony.
",true]
]],"shk_taskmaster.sqf"] remoteExec ["execvm",0,true];

//Komendy do briefingu:
// 
// - <br/> - przechodzi do nowej lini
// - <marker name='marker_name'>Tekst do kliknięcia</marker> - tworzy tekst po kliknięciu na który pokazuje miejsce na mapie oznaczone markerem, 
//marker_name <- nazwa markeru który ma pokazać
//<img image='jack.jpg' width='200' height='200'/>
//