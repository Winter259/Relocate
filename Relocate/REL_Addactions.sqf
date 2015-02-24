#include "REL_Macros.h"

REL_GiveDeployAction = 
{
	FUN_ARGS_1(_player);
	if (REL_UseAGMInteract) then
	{
		[_player] call REL_AddDeployAGMInteract;
	}
	else
	{
		[_player] call REL_AddDeployAddaction;
	};
};

REL_AddDeployAddaction =
{
	FUN_ARGS_1(_player);
	_player addaction ["<t color ='#00BFFF'>Deploy Group</t>","REL_Deploy.sqf",nil,10,true,true,"","(_target == _this) && REL_DeployAllowed"];
};

REL_AddDeployAGMInteract =
{
	FUN_ARGS_1(_player);
	
};

/*
// FOR REFERENCE FOR THE AGM INTERACTION
class AGM_SelfActions {
      class AGM_Medical {
        displayName = "$STR_AGM_Medical_Treat_Self";
        condition = "_player getVariable ['AGM_isTreatable', true]";
        statement = "";
        showDisabled = 1;
        enableInside = 1;
        priority = 6;
        icon = "AGM_Medical\UI\Medical_Icon_ca.paa";
        subMenu[] = {"AGM_Medical", 1};
        hotkey = "T";
		
		*/