// _this select 1 is the person activating the action, _this select 2 is the ID of the action
(_this select 1) removeAction (_this select 2);
REL_Presafety_Activation_Server = true;
sleep 1; // possibly not needed
publicVariableServer "REL_Presafety_Activation_Server";
hint "Pre-Safety-Off Deploy has been activated.";
