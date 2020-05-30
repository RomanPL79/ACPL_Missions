ArmA 3 UnitCaptur/UnitPlay for Infantry Units
===========================================

I was frustrated with the fact that the BIS unitCapture/unitPlay functions do not work well with infantry units. They would simply slide across the ground without any animation. I decided to make an improved version that also records and plays back infantry animations along with movements and weapon firing.

HLF_fnc_infUnitCapture and HLF_fnc_infUnitPlay allows infantry movement, firing and animation data to be captured and replayed on a player or AI infantry unit.


===========================================
Instructions
===========================================
1. Capture data
To capture player movement, call function "HLF_fnc_infUnitCapture". (If you are using it in your own mission, make sure to define the function in your "description.ext").

	Function parameters:
		Unit			- Unit to capture movement data from
		Duration		- Duration to capture for
		OPT:FPS			- OPTIONAL: Frames recorded Per Second (default 20). Limit is 1 - 100
		OPT:Firing		- OPTIONAL: If true, will record the input unit's weapon fire data as well
		OPT:StartTime	- OPTIONAL: Starting time offset for the frame time
	Example:
		[vehicle player, 600, 30, true, 0] spawn HLF_fnc_infUnitCapture;

Once recording starts, you can move, change stances, fire weapons, etc... When done, hit "ESC".
Now hit "F1/F2/F3" to copy infantry unit movement, firing and animation data to clipboard.

2. Save data
Save the movement/firing/anim data to three separate variables in an .sqf file.
For an example, refer to "captureData.sqf" in the example mission.

3. Playback
To preload the captured data, add the following line to your mission "init.sqf" (assuming you stored your captured data in "captureData.sqf"):
	call compile preprocessFile "captureData.sqf";
To make a unit called "joe" play back your recorded movements/firing/animations, run the following code.
	{joe disableAI _x;} forEach ["ANIM","MOVE","FSM","TARGET","AUTOTARGET"];
	[joe, HLF_moveData] spawn BIS_fnc_UnitPlay;
	[joe, HLF_fireData, true] spawn HLF_fnc_infUnitPlayFiring;
	[joe, HLF_animData, true] spawn HLF_fnc_infUnitPlayAnim;


===========================================
Example mission
===========================================
To see an example of the playback effects, run the example mission in mission editor and execute:
	[joe] execVM "play.sqf"; 
The AI named joe should repeat what I did and recorded in "captureData.sqf".

===========================================
Known Issues
===========================================
1. Due to issues with the A3 engine, when playback is forced on an AI instead of a player, animations can appear laggy when BIS_fnc_UnitPlay and HLF_fnc_infUnitPlayAnim are run simultaneously.

2. Infantry actions that do not trigger an animation state change (e.g. Weapon switching, reloading, leaning, head movements...) do not get recorded. (Will fix these in the future).

3. Initial animation not recorded. Will fix in the future.

If you find more issues/glitches or features you wish to be included in future versions, feel free to leave a comment

===========================================
Update Log
===========================================
v0.1 - Initial release.
	Allows for infantry unit movement/animation/firing events to be recorded and replayed.