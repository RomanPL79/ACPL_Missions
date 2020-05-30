// by ALIAS
// _camera_shot= [position_1_name, position_2_name, target_name, duration, zoom_level1, zoom_level_2, attached, x_rel_coord, y_rel_coord, z_rel_coord,last_shot] execVM "camera_work.sqf";

params ["_campos1", "_campos2", "_targetcam", "_camera_duration", "_zoom_level1", "_zoom_level2", "_cam_attached", "_x_coord", "_y_coord", "_z_coord", "_last_shot", ["_nvg", false], ["_ti", false], ["_ti_mode", 1]];

// ----------------------

if (_cam_attached) then {
	_camera = "camera" camCreate (getpos _campos1);
			showCinemaBorder true;
			camUseNVG _nvg;
			_ti setCamUseTI _ti_mode;
	_camera attachTo [_campos2, [_x_coord,_y_coord,_z_coord]];		
	_camera cameraEffect ["internal", "BACK"];
	_camera camCommand "inertia on";
	_camera camPrepareTarget _targetcam;
	_camera camPrepareFOV _zoom_level1;
	_camera camCommitPrepared _camera_duration;
	sleep _camera_duration;
	
} else {
	// initial/start position where camera is created
	_camera = "camera" camCreate (getpos _campos1);
			showCinemaBorder true;
			camUseNVG _nvg;
			_ti setCamUseTI _ti_mode;
	_camera cameraEffect ["internal", "BACK"];
	_camera camCommand "inertia on";
	_camera camPrepareTarget _targetcam;
	_camera camPrepareFOV _zoom_level1;
	_camera camCommitPrepared 0;
	
	// poz 2 - where camera is moving next - target2
	_pos2 = (getpos _campos2);
	
	_camera camPreparePos _pos2;
	_camera camPrepareTarget _targetcam;
	_camera camPrepareFOV _zoom_level2;
	_camera camCommitPrepared _camera_duration;
		
	sleep _camera_duration;
};