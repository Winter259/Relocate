#include "REL_Macros.h"

REL_EH_AssignServerLoggingEH =
{
  // (_this select 0) is the variable name
  // (_this select 1) is the variable value, arrives already formatted from REL_Server_Log
  "REL_LogToServer" addPublicVariableEventHandler
	{
		diag_log (_this select 1);
	};
};

REL_EH_BouncePreSafetyDeployActivation = 
{
  // Required due to host not being able to deploy since EH will not fire on host's PC
  "REL_Presafety_Activation_Server" addPublicVariableEventHandler
	{
		REL_Presafety_Activation = true;
    publicVariable "REL_Presafety_Activation";
    [["Server is bouncing the Pre-Safety-Off value to all clients."]] call REL_Debug_RPT;
    [["Pre-Safety-Off deploy is now active."]] call REL_Server_Log;
	};
};

REL_PlayerIsValid =
{
	FUN_ARGS_1(_player);
	DECLARE(_valid) = true;
	if (!(isPlayer _player)) then
	{
		_valid = false;
		[["Player: %1 is an AI!",_player]] call REL_Debug_RPT;
	};
	if (!(alive _player)) then
	{
		_valid = false;
		[["Player: %1 is dead!",_player]] call REL_Debug_RPT;
	};
	_valid;
};

REL_IsLeader =
{
	FUN_ARGS_1(_player);
	DECLARE(_gear_class) = [_player] call REL_ReturnGearClass;
	DECLARE(_leader) = false;
  if (!isNil "_gear_class") then
  {
    if (_gear_class in HULL_LEADER_ARRAY) then
    {
      _leader = true;
      [["LEADERSHIP CHECK: %1 has gear class %2. Leader: %3",_player,_gear_class,_leader]] call REL_Debug_RPT;
      [["LEADERSHIP CHECK: %1 has gear class %2. Leader: %3",_player,_gear_class,_leader]] call REL_Debug_Hint;
      
    };
  };
  _leader;
};

// if not leader, break
// if leader, check if valid.
// if leader is valid, add
// if leader is not valid, pass on
// pass on: if next guy is not valid, try next guy
// keep going till no guys left.

REL_AssignDeployToLeader =
{
  FUN_ARGS_1(_player);
  DECLARE(_gear_class) = [_player] call REL_ReturnGearClass;
  if ([_player] call REL_IsLeader) then
  {
    if (([_player] call REL_PlayerIsValid) && !([_player] call REL_CheckEngineerGroupForDuplicates)) then
    {
      //[_player] call REL_GiveDeployAction; // Has to be run semi-/globally
      [_player,_gear_class] call REL_AssignEngineerDuplicateFix; // required for engineers
			[-1, {[_this] call REL_GiveDeployAction;}, _player] call CBA_fnc_globalExecute;
    }
    else
    {
      [["The leader %1 of group %2 was not valid, passing on the action!",_player,(group _player)]] call REL_Server_Log;
      [["The leader %1 of group %2 was not valid, passing on the action!",_player,(group _player)]] call REL_Debug_RPT;
      [["The leader %1 of group %2 was not valid, passing on the action!",_player,(group _player)]] call REL_Debug_Hint;
      [_player] call REL_PassOnDeployAction;
    };
  }
  else
  {
    [["Initial Leader check failed for: %1",_player]] call REL_Debug_RPT;
    [["Initial Leader check failed for: %1",_player]] call REL_Debug_Hint;
  };
};

REL_PassOnDeployAction =
{
  FUN_ARGS_1(_leader);
  DECLARE(_units) = units (group _leader);
  DECLARE(_valid_unit_found) = false;
  PVT_1(_i);
  _units = _units - [_leader];// Remove the leader from the array, can be replaced with find & deleteAt.
  {
    if (([_x] call REL_PlayerIsValid) && !([_x] call REL_CheckEngineerGroupForDuplicates)) exitWith
    {
      _valid_unit_found = true;
      [["Alternate valid unit found: %1 for group: %2",_x,(group _x)]] call REL_Server_Log;
      [["Alternate valid unit found: %1 for group: %2",_x,(group _x)]] call REL_Debug_RPT;
      [["Alternate valid unit found: %1 for group: %2",_x,(group _x)]] call REL_Debug_Hint;
      //[_x] call REL_GiveDeployAction; // Has to be run semi-/globally
      [_player,([_player] call REL_ReturnGearClass)] call REL_AssignEngineerDuplicateFix; // required for engineers
			[-1, {[_this] call REL_GiveDeployAction;}, _x] call CBA_fnc_globalExecute;
    };
  } forEach _units;
  if (!_valid_unit_found) then
  {
    [["Alternate valid unit NOT found for group: %1",(group _leader)]] call REL_Server_Log;
    [["Alternate valid unit NOT found for group: %1",(group _leader)]] call REL_Debug_RPT;
    [["Alternate valid unit NOT found for group: %1",(group _leader)]] call REL_Debug_Hint;
  };
};

REL_GroupHasDeploy =
{
  FUN_ARGS_1(_group);
  DECLARE(_assigned) = false;
  {
    if ([_x] call REL_GetDeployAssigned) exitWith
    {
      _assigned = true;
    };
  } forEach units _group;
  _assigned;
};

REL_WaitForRelocateActive =
{
  if (!REL_AllowPreSafetyDeploy) then
  {
    REL_Presafety_Activation = true;
    publicVariable "REL_Presafety_Activation";
    [["Relocate has been activated (PRE SAFETY OFF!)"]] call REL_Debug_RPT;
    [["Relocate has been activated (PRE SAFETY OFF!)"]] call REL_Debug_Hint;
  };
  if (IS_ARMA2 && REL_HullPresent) then
	{
		waitUntil
		{
			sleep 1;
			[] call hull_mission_fnc_hasSafetyTimerEnded;
		};
	};
	if (IS_ARMA3 && REL_HullPresent) then
	{
		waitUntil
		{
			sleep 1;
			[] call hull3_mission_fnc_hasSafetyTimerEnded;
		};
	};
	if (!REL_HullPresent) then
	{
		// Add enable addaction to host, for a future version
	};
	REL_DeployAllowed = true; // 
	publicVariable "REL_DeployAllowed";
  [["Relocate has been activated (POST SAFETY OFF!)"]] call REL_Debug_RPT;
	[["Relocate has been activated (POST SAFETY OFF!)"]] call REL_Debug_Hint;
};