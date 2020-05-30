/////////////ACPL MASS SKILL CHANGER////////////////////
/////////////////by KameX 1.0_2///////////////////////////
/////////////////edited by Roman79///////////////////////////

////////////////USTAWIENIA G��WNE///////////////////////

msc_switch				= 1				   ;//G��wny w��cznik skryptu. 1 = w��czony 0 = wy��czony	
msc_exception				= []  		   ;//Jednostki wykluczone z dzia�ania skryptu. 
									    //Przyk�ad: r�czne ustawienie skilla strzelca w poje�dzie albo ustawienie jakiej� elitarnej grupy.



////////////////USTAWIENIA SKILLA///////////////////////
//Warto�� dla ka�dej jednostki jest losowana mi�dzy parametrem min i max
//Domy�lne warto�ci s� ok je�li nie walczymy z dobrze wyszkolon� armi� i wr�g ma przewag� liczebn�

//WEST

_rando_w				= 	2;		;//Im bli�ej jedynki tym skill b�dzie losowany bli�ej g�rnej granicy. 
							//Im bli�ej tr�jki - skill b�dzie losowany bli�ej dolnego zakresu. 
							//2 to ustawienie zbalansowane, w kt�rym bardzo dobrze i bardzo �le wyszkolony wr�g wyst�puje najrzadziej. 

msc_skill_accuracy_min_w		=	0.3		;//Celno��
msc_skill_accuracy_max_w		=	0.4		;

msc_skill_shake_min_w		=	0.3		;//Stabilno�� r�ki w czasie strzelania
msc_skill_shake_max_w		=	0.4		;

msc_skill_speed_min_w		=	0.5		;//Pr�dko�� celowania
msc_skill_speed_max_w		=	0.6		;

msc_skill_spot_min_w		=	0.5		;//Dystans wykrywania
msc_skill_spot_max_w		=	0.8		;

msc_skill_time_min_w		=	0.5		;//Czas wykrywania
msc_skill_time_max_w		=	0.8		;

msc_skill_general_min_w		=	0.6		;//Skill generalny - u�ywanie os�on, flankowanie, generalny brain-factor
msc_skill_general_max_w		=	0.8		;

msc_skill_courage_min_w		=	0.6		;//Odwaga - im wi�cej tej warto�ci tym trudniej przycisn�� wroga
msc_skill_courage_max_w		=	0.8		;

msc_skill_reload_min_w		=	0.3		;//Pr�dko�� prze�adowania
msc_skill_reload_max_w		=	0.4		;

//EAST

_rando_e				= 	2.1;		;//Im bli�ej jedynki tym skill b�dzie losowany bli�ej g�rnej granicy. 
							//Im bli�ej tr�jki - skill b�dzie losowany bli�ej dolnego zakresu. 
							//2 to ustawienie zbalansowane, w kt�rym bardzo dobrze i bardzo �le wyszkolony wr�g wyst�puje najrzadziej. 

msc_skill_accuracy_min_e		=	0.15		;//Celno��
msc_skill_accuracy_max_e		=	0.25		;

msc_skill_shake_min_e		=	0.1		;//Stabilno�� r�ki w czasie strzelania
msc_skill_shake_max_e		=	0.2		;

msc_skill_speed_min_e		=	0.1		;//Pr�dko�� celowania
msc_skill_speed_max_e		=	0.2		;

msc_skill_spot_min_e		=	0.3		;//Dystans wykrywania
msc_skill_spot_max_e		=	0.5		;

msc_skill_time_min_e		=	0.4		;//Czas wykrywania
msc_skill_time_max_e		=	0.6		;

msc_skill_general_min_e		=	0.8		;//Skill generalny - u�ywanie os�on, flankowanie, generalny brain-factor
msc_skill_general_max_e		=	0.9		;

msc_skill_courage_min_e		=	0.2		;//Odwaga - im wi�cej tej warto�ci tym trudniej przycisn�� wroga
msc_skill_courage_max_e		=	0.4		;

msc_skill_reload_min_e		=	0.1		;//Pr�dko�� prze�adowania
msc_skill_reload_max_e		=	0.3		;

//RESISTANCE

_rando_r				= 	2.1;		;//Im bli�ej jedynki tym skill b�dzie losowany bli�ej g�rnej granicy. 
							//Im bli�ej tr�jki - skill b�dzie losowany bli�ej dolnego zakresu. 
							//2 to ustawienie zbalansowane, w kt�rym bardzo dobrze i bardzo �le wyszkolony wr�g wyst�puje najrzadziej. 

msc_skill_accuracy_min_r		=	0.15		;//Celno��
msc_skill_accuracy_max_r		=	0.25		;

msc_skill_shake_min_r		=	0.1		;//Stabilno�� r�ki w czasie strzelania
msc_skill_shake_max_r		=	0.2		;

msc_skill_speed_min_r		=	0.1		;//Pr�dko�� celowania
msc_skill_speed_max_r		=	0.2		;

msc_skill_spot_min_r		=	0.2		;//Dystans wykrywania
msc_skill_spot_max_r		=	0.4		;

msc_skill_time_min_r		=	0.4		;//Czas wykrywania
msc_skill_time_max_r		=	0.6		;

msc_skill_general_min_r		=	0.8		;//Skill generalny - u�ywanie os�on, flankowanie, generalny brain-factor
msc_skill_general_max_r		=	0.9		;

msc_skill_courage_min_r		=	0.5		;//Odwaga - im wi�cej tej warto�ci tym trudniej przycisn�� wroga
msc_skill_courage_max_r		=	0.9		;

msc_skill_reload_min_r		=	0.1		;//Pr�dko�� prze�adowania
msc_skill_reload_max_r		=	0.3		;

////////////////DEBUG///////////////////////
msc_debug			= 0;	