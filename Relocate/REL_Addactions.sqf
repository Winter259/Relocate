#include "REL_Macros.h"

REL_GiveDeploy_Addaction =
{
	FUN_ARGS_1(_player);
  PVT_1(_actionID);
  DECLARE(_addaction_string) = ["Deploy Group",REL_ACTION_COLOUR_HTML] call REL_ReturnHTMLColouredText;
	_actionID = _player addaction [_addaction_string,"Relocate\REL_Deploy.sqf",nil,10,true,true,"","(_target == _this) && REL_DeployAllowed && !([_target] call REL_GetPlayerDeployedStatus)"];
  [_player,_actionID] call REL_SetDeployActionID;
};

REL_GiveDeployAction = 
{
	FUN_ARGS_1(_player);
	if (local _player) then
	{
		[["Deploy successfully assigned to: %1",_player]] call REL_Server_Log;
    [["Deploy successfully assigned to: %1",_player]] call REL_Debug_RPT;
    [["Deploy successfully assigned to: %1",_player]] call REL_Debug_Hint;
    [_player,true] call REL_SetDeployAssigned;
    [_player,false] call REL_SetPlayerDeployedStatus; // activates AGM action
		if (!REL_UseAGMInteract) then
		{
			[_player] call REL_GiveDeploy_Addaction;
		};
	};
};

REL_RemoveDeployAction =
{
	FUN_ARGS_2(_player,_actionID);
	if (!isNil "_actionID") then
	{
		_player removeAction _actionID;
	};
	onMapSingleClick "";
};

REL_GlobalAssignDeploy =
{
	[["Assigning group deploy to all leaders now"]] call REL_Debug_Hint;
	[["Assigning group deploy to all leaders now"]] call REL_Debug_RPT;
  [["Hull Safety has been turned off, assigning group deploy to all leaders now."]] call REL_Server_Log;
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