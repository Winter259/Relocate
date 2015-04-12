class CfgVehicles {
  class Man;
  class CAManBase: Man {
    class AGM_Actions {};
    class AGM_SelfActions {
		class REL_AGM_Deploy {
        displayName = "Deploy Group";
        condition = "REL_DeployAllowed && !([_player] call REL_GetPlayerDeployedStatus)";
        statement = "[_player] call REL_AssignAGMDeployClick;";
        showDisabled = 1;
        priority = 5;
        icon = "\AGM_Interaction\UI\team\team_management_ca.paa"; // Will probably keep this
        //subMenu[] = {"ARK Inhouse", 1}; // for future consideration
        enableInside = 0;
        hotkey = "D";
	};
  };
  };
};