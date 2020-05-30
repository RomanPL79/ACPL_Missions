// ////////////////////////////////////////////////////////////////////////////
// Tactical Combat Link - Radio Settings
// ////////////////////////////////////////////////////////////////////////////
// The T.C.L. Radio settings are stored in the global array TCL_Radio.
// You can change T.C.L. Radio settings by editing the TCL_Radio array.
// For each custom T.C.L. Radio setting remove the "//" in front of the respective line and modify the value.
// Example: TCL_Radio set [Index, Value];
// In multiplayer all T.C.L. Radio settings are used by the server only.
// ////////////////////////////////////////////////////////////////////////////
  
waitUntil {!(isNil "TCL_Radio")};
  
  // ==============================================================
  // T.C.L. A.I. Radio:
  // ==============================================================
  // Choose ( False ) to disable A.I. group(s) which have radio available to request and get requested as reinforcement(s) only.
  // True / False, default True
    TCL_Radio set [0, True];
	
  // ==============================================================
  // T.C.L. A.I. Radio: ( Time )
  // ==============================================================
  // Choose how much time A.I. group(s) should need to request reinforcement(s).
  // Note: This value will be recalculated with the skill of the requesting A.I. group leader.
  // 0 - 100, default is 50 seconds
    TCL_Radio set [1, 75];
	
  // ==============================================================
  // T.C.L. A.I. Radio: ( Distance )
  // ==============================================================
  // Choose distance within specific A.I. group(s) are able to request reinforcement(s).
  // 0 - 50000, default is [3000, 5000, 7000, 10000, 13000] - [Man, Car, Tank, Air, Ship]
    TCL_Radio set [2, [3000, 5000, 7000, 10000, 13000] ];