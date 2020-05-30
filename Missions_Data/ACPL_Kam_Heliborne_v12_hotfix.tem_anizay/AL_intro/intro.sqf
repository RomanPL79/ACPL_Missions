// by ALIAS
// nul = [JIP] execVM "AL_intro\intro.sqf";

waitUntil {time > 0};

_jip_enable	= _this select 0;

[[_jip_enable],"AL_intro\time_srv.sqf"] remoteExec ["execVM"];
waitUntil {!isNil "curr_time"};

if (!hasInterface) exitWith {};

if ((!curr_time) or (_jip_enable<0)) then {
playSound "intror";

/* ----- how to use camera script -----------------------------------------------------------------------

_camera_shot = [position_1_name, position_2_name, target_name, duration, zoom_level1, zoom_level_2, attached, x_rel_coord, y_rel_coord, z_rel_coord,last_shot] execVM "camera_work.sqf";

Where
_camera_shot	- string, is the name/number of the camera shot, you can have as many as you want see examples from down bellow
position_1_name - string, where camera is created, replace it with the name of the object you want camera to start from
position_2_name - string, the object where you want camera to move, if you don't want to move from initial position put the same name as for position_1_name
target_name   	- string, name of the object you want the camera to look at
duration 		- seconds, how long you want the camera to function on current shot
zoom_level_1 	- takes values from 0.01 to 2, FOV (field of view) value for initial position
zoom_level_2	- takes values from 0.01 to 2, FOV value for second position, if you don't to change you can give the same value as you did for zoom_level_1
attached		- boolean, if you want to attach camera to an moving object its value has to be true, otherwise must be false
					in this case position_1_name must have the same value as position_2_name
x_rel_coord		- meters, relative position to the attached object on x coordinate
y_rel_coord		- meters, relative position to the attached object on y coordinate
z_rel_coord		- meters, relative position to the attached object on z coordinate
last_shot		- boolean, true if is the last shot in your movie, false otherwise

-----------------------------------------------------------------------------------------------------------*/

// - do not edit or delete the lines downbelow, this line must be before first camera shot
loopdone = false;
while {!loopdone} do {
//^^^^^^^^^^^^^^^^^^^^^^ DO NOT EDIT OR DELETE ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


// EXAMPLES------ insert your lines for camera shots starting from here -----------------------------------------

cutText ["", "BLACK", 4];
sleep 5;
_firstshot = [cam1, cam2, target1, 20, 0.3, 0.1, false, 0, 0, 0,FALSE] execVM "AL_intro\camera_work.sqf";
cutText ["", "BLACK IN", 5,true,true];
sleep 5;
cutText ["<t size='3.0'>[ACPL] KameX prezentuje</t>", "PLAIN", 4,true,true];
sleep 10;
cutText ["", "BLACK", 5,true,true];
sleep 5;
waitUntil {scriptdone _firstshot};

_secondshot = [cam3, cam3_1, target2, 10, 1, 1, false, 0, 0, 0,FALSE] execVM "AL_intro\camera_work.sqf";
cutText ["", "BLACK IN", 2,true,true];
sleep 3;
cutText ["<t size='3.0'>HELIBORNE</t>", "PLAIN", 4,true,true];
sleep 6;
cutText ["", "BLACK", 2,true,true];
sleep 2;
waitUntil {scriptdone _secondshot};

_czeci = [cam6, cam7, target4, 9, 1, 1, false, 0, 0, 0,FALSE] execVM "AL_intro\camera_work.sqf";
cutText ["", "BLACK IN", 4,true,true];
sleep 4;
waitUntil {scriptdone _czeci};

_czwarty = [cam8, cam9, target5, 8, 1, 1, false, 0, 0, 0,FALSE] execVM "AL_intro\camera_work.sqf";
cutText ["", "BLACK IN", 4,true,true];
sleep 4;
waitUntil {scriptdone _czwarty};

_piaty = [cam10, cam10, target6, 8, 0.8, 0.5, false, 0, 0, 0,FALSE] execVM "AL_intro\camera_work.sqf";
cutText ["", "BLACK IN", 4,true,true];
sleep 4;
waitUntil {scriptdone _piaty};

_thirdshot = [cam4, cam4, target3, 10, 1, 1, true, 0, 0, 0,FALSE] execVM "AL_intro\camera_work.sqf";
waitUntil {scriptdone _thirdshot};

_forthshot = [cam5, cam5, uh2, 10, 1, 0.2, true, 0, 0, 0,TRUE] execVM "AL_intro\camera_work.sqf";
waitUntil {scriptdone _forthshot};



/*
if you want to add a forth or a fifth camera shot use a code like:
_forthshot = [cam5, cam6, target4, 7, 1, 1, false] execVM "camera_work.sqf";
waitUntil {scriptDone _forthshot};

** Note that last boolean parameter will tell the script if the camera shot is the last one or not,
make sure that last camera has that parameter true and the intermediar cameras has it false as in my examples above

>>!! don't forget to name the objects cam5, cam6, target4 in editor 

You can add as many camera shots as you want 
but you have to name the script differently 
and don't forget to add the wait line after each shot
waitUntil {scriptDone _xxxshot};
*/

// --------------->> end of camera shots <<---------------------------------------------------------
};

cutText [" ", "BLACK IN", 3];
_camera = "camera" camCreate (getpos player);
_camera cameraeffect ["terminate", "back"];
camDestroy _camera;
"dynamicBlur" ppEffectEnable true;   
"dynamicBlur" ppEffectAdjust [100];   
"dynamicBlur" ppEffectCommit 0;     
"dynamicBlur" ppEffectAdjust [0.0];  
"dynamicBlur" ppEffectCommit 4;
};