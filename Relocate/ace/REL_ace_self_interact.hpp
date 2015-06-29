class ACE_SelfActions {
    class ACE_Relocate {
        class ACE_REL_Deploy {
            //displayName = CSTRING(AttachDetach);
            //condition = QUOTE(_this call FUNC(canAttach));
            //insertChildren = QUOTE(_this call FUNC(getChildrenAttachActions));
            exceptions[] = {"isNotDragging","isNotSitting","notOnMap"};
            showDisabled = 0;
            priority = 5;
            //icon = ""; // TODO
            // hotkey = "D"; 
        };
    };
};