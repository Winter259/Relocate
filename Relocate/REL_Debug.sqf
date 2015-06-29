#include "REL_Macros.h"

REL_Debug_Log = {
    DEBUG
    {
        FUN_ARGS_5(_message,_rpt,_hint,_hint_silent,_sidechat);
        if (_rpt) then
        {
            diag_log format ["%1%2",DEBUG_HEADER,(format _message)];
        };
        if (_hint) then
        {
            hint format ["%1%2",DEBUG_HEADER,(format _message)];
        };
        if (_hint_silent) then
        {
            hintSilent format ["%1%2",DEBUG_HEADER,(format _message)];
        };
        if (_sidechat) then
        {
            player sideChat format ["%1%2",DEBUG_HEADER,(format _message)];
        };
    };
};

REL_Debug_RPT = {
    FUN_ARGS_1(_message);
    [_message,true,false,false,false] call REL_Debug_Log;
};

REL_Debug_Hint = {
    FUN_ARGS_1(_message);
    [_message,false,true,false,false] call REL_Debug_Log;
};

REL_Debug_HintSilent = {
    FUN_ARGS_1(_message);
    [_message,false,false,true,false] call REL_Debug_Log;
};

REL_Debug_Sidechat = {
    FUN_ARGS_1(_message);
    [_message,false,false,false,true] call REL_Debug_Log;
};