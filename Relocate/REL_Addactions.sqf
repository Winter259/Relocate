#include "REL_Macros.h"

REL_GiveDeploy_Addaction =
{
	FUN_ARGS_1(_player);
	_player addaction ["<t color ='#00BFFF'>Deploy Group</t>","Relocate\REL_Deploy.sqf",nil,10,true,true,"","(_target == _this) && REL_DeployAllowed && !([_target] call REL_GetPlayerDeployedStatus)"];
};

REL_CompileLeaderArray =
{
	REL_LeaderArray = [];
	{
		
	} forEach allUnits;
};

REL_IsLeader =
{
	FUN_ARGS_1(_player);
	PVT_1(_gearClass);
	DECLARE(_leader) = false;
	if (IS_ARMA2) then
	{
		_gearClass = _player getVariable "hull_gear_class";
	}
	else
	{
		_gearClass = _player getVariable "hull3_gear_class";
	};
	if (!isNil "_gearClass") then
	{
		{
			if (_gearClass == _x) then
			{
				_leader = true;
			};
		} forEach HULL_LEADER_ARRAY;
		[["LEADERSHIP CHECK: %1 has gear class %2. Leader: %3",_player,_gearClass,_leader]] call REL_Debug_RPT;
		[["LEADERSHIP CHECK: %1 has gear class %2. Leader: %3",_player,_gearClass,_leader]] call REL_Debug_Hint;
	}
	else
	{
		[["No valid gear class defined for: %1",_player]] call REL_Debug_RPT;
		[["No valid gear class defined for: %1",_player]] call REL_Debug_Hint;
	};
	_leader;
};

REL_AssignToLeader =
{
	FUN_ARGS_1(_player);
	if ([_player] call REL_IsLeader) then
	{
		if ([_player] call REL_PlayerIsValid) then
		{
			//[_player] call REL_GiveDeployAction;
			// Has to be run semi-/globally
			[-1, {[_this] call REL_GiveDeployAction;}, _player] call CBA_fnc_globalExecute;
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
	{
		[_x] call REL_AssignToLeader;
		sleep 0.1;
	} forEach allUnits;
};