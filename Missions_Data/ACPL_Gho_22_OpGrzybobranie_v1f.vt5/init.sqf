[[
  ["tsk1","Wyeliminować partyzantów w lesie","Wyprzeć partyzantów z lasu.",true]
],[
  ["Sytuacja","Operacja Grzybobranie - 06.06.2015<br/>
<br/>
Celem dzisiejszej operacji będzie wyparcie sił partyzanckich z <marker name='ao'>lasu</marker>. Zadanie to spada na <marker name='start'>nasz pluton</marker>.<br/>
<br/>
Od <marker name='WEST'>zachodu</marker>, <marker name='EAST'>wschodu</marker> i <marker name='NORTH'>północy</marker> nasze siły utrzymują kordon mający zatrzymać uciekającego nieprzyjaciela, więc uważajcie, żeby nie wejść im pod lufy.
<br/>
<br/>
CEL PODSTAWOWY: Wyparcie sił partyzantów z lasu.<br/>
CELE DRUGORZEDNE:<br/>
- Minimalizacja strat własnych.<br/>
- Zniszczenie sprzętu wroga.<br/>
<br/>",true],
  ["Wykonanie","Zadania poszczególnych plutonów:<br/>
- Grupy ALFA-1 odetną drogę na zachód.<br/>
- Grupy ALFA-2 odetnie drogę na północ.<br/>
- Grupy ALFA-3 odetnie drogę na wschód.<br/>
- Grupy ALFA-6 rozpocznie uderzenie od południa.<br/>
<br/>
Nasz pluton ma nacierać linią z południa w kierunku północnym uważnie sprawdzając teren w poszukiwaniu przeciwnika oraz jego sprzętu.",true],
  ["Wywiad","Przeciwnik:<br/>
- Naszym przeciwnikiem są niewielkie siły partyzantów dręczące lokalne władze.<br/>
- W AO należy spodziewać się wroga w sile około plutonu.<br/>
- Wróg uzbrojony głównie z lekką broń ręczną (broń myśliwska oraz radziecka), możliwe że posiadają niewielką ilość broni p-panc.<br/>
- Wróg słabo wyszkolony, głównie ochotnicy z okolicznych wsi.<br/>
- Wróg posiada dobrą motywacje, uważają że walczą o wolność swojego państwa.<br/>
- Przeciwnik bardzo dobrze zna okoliczne tereny, istnieje duże prawdopobieństwo wystąpienia zasadzek i pułapek, wróg prawdopodobnie posiada dobze ukryte, umocnione pozycje.<br/>
- Minimalne ryzyko wystąpienia min oraz innych pułapek.<br/>
<br/>
Pogoda:<br/>
- Minimalne zachmurzenie, w najbliższym czasie pogoda będzie się poprawiać.<br/>
- Bardzo dobra widoczność mocno ograniczona przez teren.<br/>
<br/>
Ludność Cywilna:<br/>
- Brak informacji o cywilach w AO.<br/>
- Należy założyć że cywile znajdujący się w terenie działań są powiązani z partyzantką.<br/>
- W razie napotkania cywili należy ich zabezpieczyć i przekazać lokalnym władzą w celu przesłuchania.<br/>
<br/>
Teren:<br/>
- Teren działań mocno zalesiony z niewielką ilością polan i przecinek.<br/>
- Niewielkie różnice w wysokościach terenu, dużo dołów i rowów.<br/>
- Przez las prowadzi ścieżka, prowadząca do jednej z polnych dróg.<br/>
- W terenie działań znajduje się jedynie niewielkie cywilne gospodarstwo.<br/>
- Nie znamy rozmieszczenia przeciwnika.<br/>
<br/>
Siły sojusznicze:<br/>
- 4 plutony biorące udział w Operacji Grzybobranie.<br/>
- 2 uzbrojone drony UGV Stromper.<br/>
- 2 nieuzbrojone drony UGV Stromper.<br/>
- Dron zwiadowczy MQ-4A Greyhawk.<br/>
",true],
  ["Przydzial",
  "Przydzial:<br/>
- Nasz pluton (ALFA 6) ma za zadanie przeczesać wyznaczony teren.<br/>
- Zostały nam przydzielone drony:<br/>
* 2 uzbrojone drony UGV Stromper.<br/>
* 2 nieuzbrojone drony UGV Stromper.<br/>
* Dron zwiadowczy MQ-4A Greyhawk.<br/>
- Komunikacja między plutonami na kanale 50.<br/>
- Komunikacja między drużynami ALFA 6 na kanale 133.<br/>
- Częstotliwość awaryjna - 150.<br/>
<br/>
Wsparcie:<br/>
- Dysponujemy wsparciem ogniowym dwóch uzbrojnonych dronów UGV Stromper.<br/>
- Dysponujemy wsparciem logistycznym dwóch nieuzbrojnonych dronów UGV Stromper które zostały wypełnione amunicją.<br/>
- Dysponujemy wsparciem drona zwiadowczego MQ-4A Greyhawk.<br/>
<br/>
Łaczność:<br/>
- standard lacznosci wewnatrz ALFA 6-1: komunikacja za pomoca Squad Radio czestotliwosc 130.<br/>
- standard lacznosci wewnatrz ALFA 6-2: komunikacja za pomoca Squad Radio czestotliwosc 131.<br/>
- standard lacznosci wewnatrz ALFA 6-3: komunikacja za pomoca Squad Radio czestotliwosc 132.<br/>
- standard lacznosci wewnetrz Kompanii ALFA i z TOC: komunikacja radiostacją, standardowy kanal 50.<br/>
<br/>
Zasady Użycia Siły:<br/>
- Wyeliminować przeciwnika stawiającego opór.<br/>
- Aresztować i dostarczyć lokalnym władzą partyzantów którzy się poddali.<br/>
- Zapewnić opieke medyczną rannym przeciwnikom.<br/>
  ",true]
]] execvm "shk_taskmaster.sqf";
[0,[],true,true] execVM "acpl_fncs_init.sqf";

titleCut ["","BLACK IN", 7];

["Op. Grzybobranie", str(date select 2) + "." + str(date select 1) + "." + str(date select 0), str(name player)] spawn BIS_fnc_infoText;

