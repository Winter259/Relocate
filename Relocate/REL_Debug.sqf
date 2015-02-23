REL_Debug_Log =
{
	FUN_ARGS_4(_message,_rpt,_hint,_hint_silent,_sidechat);
	if (_rpt) then
	{
		diag_log format _message;
	};
	if (_hint) then
	{
		hint format _message;
	};
	if (_hint_silent) then
	{
		hintSilent format _message;
	};
	if (_sidechat) then
	{
		player sideChat format _message;
	};
};