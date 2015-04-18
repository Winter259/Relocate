#include "REL_Macros.h"

REL_GiveDeploy_Addaction =
{
	FUN_ARGS_1(_player);
  PVT_1(_actionID);
  DECLARE(_addaction_string) = ["Deploy Group",REL_ACTION_COLOUR_HTML] call REL_ReturnHTMLColouredText;
	_actionID = _player addaction [_addaction_string,"Relocate\REL_Deploy.sqf",nil,10,true,true,"","(_target == _this) && REL_DeployAllowed && !([_target] call REL_GetPlayerDeployedStatus)"];
  [_player,_actionID] call REL_SetDeployActionID;
};

REL_IsLeader =
{
	FUN_ARGS_1(_player);
	PVT_1(_gearClass);
	DECLARE(_leader) = false;
	_gearClass = [_player] call REL_ReturnGearClass;
	if (!isNil "_gearClass") then
	{
		{
			if (_gearClass == _x) then
			{
				_leader = true;
			};
		} forEach HULL_LEADER_ARRAY;
    if ((_gearClass == "ENG") && !([group _player] call REL_EngineerAssignCheck)) then
    {
      // Hacky workaround for ENG teams all taking gear from ENG template
      [["WARNING: ENGINEER DUPLICATE FIX DEPLOYED FOR: %1",_player]] call REL_Debug_RPT;
      [_player] call REL_EngineerDuplicateFix;
    };
		[["LEADERSHIP CHECK: %1 has gear class %2. Leader: %3",_player,_gearClass,_leader]] call REL_Debug_RPT;
		[["LEADERSHIP CHECK: %1 has gear class %2. Leader: %3",_player,_gearClass,_leader]] call REL_Debug_Hint;
	}
	else
	{
		[["GEAR CHECK: No valid gear class defined for: %1",_player]] call REL_Debug_RPT;
		[["GEAR CHECK: No valid gear class defined for: %1",_player]] call REL_Debug_Hint;
	};
	_leader;
};

REL_EngineerDuplicateFix =
{
  FUN_ARGS_1(_player);
  // Hacky workaround for ENG teams all taking gear from ENG template
  _player setVariable ["REL_EngineerDuplicateCheck",true,true];
};

REL_EngineerAssignCheck =
{
  FUN_ARGS_1(_group);
  DECLARE(_already_has_deploy) = false;
  PVT_1(_deploy_check);
  // Hacky workaround for ENG teams all taking gear from ENG template
  {
    _deploy_check = _x getVariable ["REL_EngineerDuplicateCheck",false];
    if (_deploy_check) then
    {
      _already_has_deploy = true;
      [["WARNING: PLAYER %1 IN GROUP %2 ALREADY HAS DEPLOY!",_x,_group]] call REL_Debug_RPT;
    };
  } forEach units _group;
  _already_has_deploy;
};

REL_AssignToLeader =
{
	FUN_ARGS_1(_player);
  PVT_1(_gearClass);
	if ([_player] call REL_PlayerIsValid) then
	{
		if ([_player] call REL_IsLeader) then
		{
        [-1, {[_this] call REL_GiveDeployAction;}, _player] call CBA_fnc_globalExecute;
        [["Deploy successfully assigned to: %1!",_player]] call REL_Debug_RPT;
        if ((([_player] call REL_ReturnGearClass) == "ENG") && !([group _player] call REL_EngineerAssignCheck)) then // This is required since all units in Engineer groups are ENG!
        {
          [_player,([_player] call REL_GetDeployActionID)] call REL_RemoveDeploy;
          [["WARNING: DEPLOY REMOVED FROM %1 SINCE ENGINEER GROUP ALREADY HAS DEPLOY ASSIGNED!",_player]] call REL_Debug_RPT;
        };
		}
		else
		{
			[_player] call REL_PassOnAction;
		};
	};
};

REL_GiveDeployAction = 
{
	FUN_ARGS_1(_player);
	if (local _player) then
	{
		[_player,false] call REL_SetPlayerDeployedStatus; // activates AGM action
		if (!REL_UseAGMInteract) then
		{
			[_player] call REL_GiveDeploy_Addaction;
		};
	};
};

REL_AssignDeploy =
{
	[["Assigning group deploy to all leaders now"]] call REL_Debug_Hint;
	[["Assigning group deploy to all leaders now"]] call REL_Debug_RPT;
	{
		if ([_x] call REL_IsSideAllowedDeploy) then
    {
      [_x] call REL_AssignToLeader;
      sleep 0.1;
    };
	} forEach allUnits;
};

REL_IsSideAllowedDeploy =
{
  FUN_ARGS_1(_player);
  DECLARE(_allowed) = false;
  switch (side _player) do
  {
    case blufor:      {if (REL_AllowDeploy_BLU) then {_allowed = true;}};
    case opfor:       {if (REL_AllowDeploy_OPF) then {_allowed = true;}};
    case resistance:  {if (REL_AllowDeploy_IND) then {_allowed = true;}};
    case civilian:    {if (REL_AllowDeploy_CIV) then {_allowed = true;}};
  };
  [["FACTION CHECK: Player: %1 Side: %2 Allowed: %3",_player,side _player,_allowed]] call REL_Debug_RPT;
  [["FACTION CHECK: Player: %1 Side: %2 Allowed: %3",_player,side _player,_allowed]] call REL_Debug_Hint;
  _allowed;
};