/////////////ACPL MASS SKILL CHANGER////////////////////
/////////////////by KameX 1.0_2///////////////////////////
/////////////////edited by Roman79///////////////////////////

////////////////USTAWIENIA G£ÓWNE///////////////////////

msc_switch				= 1				   ;//G³ówny w³¹cznik skryptu. 1 = w³¹czony 0 = wy³¹czony	
msc_exception				= []  		   ;//Jednostki wykluczone z dzia³ania skryptu. 
									    //Przyk³ad: rêczne ustawienie skilla strzelca w pojeŸdzie albo ustawienie jakiejœ elitarnej grupy.



////////////////USTAWIENIA SKILLA///////////////////////
//Wartoœæ dla ka¿dej jednostki jest losowana miêdzy parametrem min i max
//Domyœlne wartoœci s¹ ok jeœli nie walczymy z dobrze wyszkolon¹ armi¹ i wróg ma przewagê liczebn¹

//WEST

_rando_w				= 	2;		;//Im bli¿ej jedynki tym skill bêdzie losowany bli¿ej górnej granicy. 
							//Im bli¿ej trójki - skill bêdzie losowany bli¿ej dolnego zakresu. 
							//2 to ustawienie zbalansowane, w którym bardzo dobrze i bardzo Ÿle wyszkolony wróg wystêpuje najrzadziej. 

msc_skill_accuracy_min_w		=	0.3		;//Celnoœæ
msc_skill_accuracy_max_w		=	0.4		;

msc_skill_shake_min_w		=	0.3		;//Stabilnoœæ rêki w czasie strzelania
msc_skill_shake_max_w		=	0.4		;

msc_skill_speed_min_w		=	0.5		;//Prêdkoœæ celowania
msc_skill_speed_max_w		=	0.6		;

msc_skill_spot_min_w		=	0.5		;//Dystans wykrywania
msc_skill_spot_max_w		=	0.8		;

msc_skill_time_min_w		=	0.5		;//Czas wykrywania
msc_skill_time_max_w		=	0.8		;

msc_skill_general_min_w		=	0.6		;//Skill generalny - u¿ywanie os³on, flankowanie, generalny brain-factor
msc_skill_general_max_w		=	0.8		;

msc_skill_courage_min_w		=	0.6		;//Odwaga - im wiêcej tej wartoœci tym trudniej przycisn¹æ wroga
msc_skill_courage_max_w		=	0.8		;

msc_skill_reload_min_w		=	0.3		;//Prêdkoœæ prze³adowania
msc_skill_reload_max_w		=	0.4		;

//EAST

_rando_e				= 	2.1;		;//Im bli¿ej jedynki tym skill bêdzie losowany bli¿ej górnej granicy. 
							//Im bli¿ej trójki - skill bêdzie losowany bli¿ej dolnego zakresu. 
							//2 to ustawienie zbalansowane, w którym bardzo dobrze i bardzo Ÿle wyszkolony wróg wystêpuje najrzadziej. 

msc_skill_accuracy_min_e		=	0.15		;//Celnoœæ
msc_skill_accuracy_max_e		=	0.25		;

msc_skill_shake_min_e		=	0.1		;//Stabilnoœæ rêki w czasie strzelania
msc_skill_shake_max_e		=	0.2		;

msc_skill_speed_min_e		=	0.1		;//Prêdkoœæ celowania
msc_skill_speed_max_e		=	0.2		;

msc_skill_spot_min_e		=	0.3		;//Dystans wykrywania
msc_skill_spot_max_e		=	0.5		;

msc_skill_time_min_e		=	0.4		;//Czas wykrywania
msc_skill_time_max_e		=	0.6		;

msc_skill_general_min_e		=	0.8		;//Skill generalny - u¿ywanie os³on, flankowanie, generalny brain-factor
msc_skill_general_max_e		=	0.9		;

msc_skill_courage_min_e		=	0.2		;//Odwaga - im wiêcej tej wartoœci tym trudniej przycisn¹æ wroga
msc_skill_courage_max_e		=	0.4		;

msc_skill_reload_min_e		=	0.1		;//Prêdkoœæ prze³adowania
msc_skill_reload_max_e		=	0.3		;

//RESISTANCE

_rando_r				= 	2.1;		;//Im bli¿ej jedynki tym skill bêdzie losowany bli¿ej górnej granicy. 
							//Im bli¿ej trójki - skill bêdzie losowany bli¿ej dolnego zakresu. 
							//2 to ustawienie zbalansowane, w którym bardzo dobrze i bardzo Ÿle wyszkolony wróg wystêpuje najrzadziej. 

msc_skill_accuracy_min_r		=	0.15		;//Celnoœæ
msc_skill_accuracy_max_r		=	0.25		;

msc_skill_shake_min_r		=	0.1		;//Stabilnoœæ rêki w czasie strzelania
msc_skill_shake_max_r		=	0.2		;

msc_skill_speed_min_r		=	0.1		;//Prêdkoœæ celowania
msc_skill_speed_max_r		=	0.2		;

msc_skill_spot_min_r		=	0.2		;//Dystans wykrywania
msc_skill_spot_max_r		=	0.4		;

msc_skill_time_min_r		=	0.4		;//Czas wykrywania
msc_skill_time_max_r		=	0.6		;

msc_skill_general_min_r		=	0.8		;//Skill generalny - u¿ywanie os³on, flankowanie, generalny brain-factor
msc_skill_general_max_r		=	0.9		;

msc_skill_courage_min_r		=	0.5		;//Odwaga - im wiêcej tej wartoœci tym trudniej przycisn¹æ wroga
msc_skill_courage_max_r		=	0.9		;

msc_skill_reload_min_r		=	0.1		;//Prêdkoœæ prze³adowania
msc_skill_reload_max_r		=	0.3		;

////////////////DEBUG///////////////////////
msc_debug			= 0;	