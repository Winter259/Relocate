class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_REL_Deploy {
                displayName = "Deploy Group";
                condition = "true";
                exceptions[] = {"isNotDragging","isNotSitting","notOnMap"};
                statement = "";
                showDisabled = 0;
                priority = 5;
                icon = "Relocate/ace/deploy.paa";
                hotkey = "D";
            };
        };
    };
};