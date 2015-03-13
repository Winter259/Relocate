class CfgVehicles {
  class Man;
  class CAManBase: Man {
    class AGM_Actions {};
    class AGM_SelfActions {
		class REL_AGM_Deploy {
        displayName = "Deploy Group";
        condition = "(_target == _this) && REL_DeployAllowed";
        statement = "";
        showDisabled = 1;
        priority = 5;
        icon = "\AGM_Interaction\UI\team\team_management_ca.paa"; // to change later on
        subMenu[] = {"Group Deploy", 1};
        enableInside = 0;
        hotkey = "D";
	};
  };
  };
};