#include "Kami_Macros.h"

#ifndef REL_MACROS_H
#define REL_MACROS_H

#define REL_Version			0.1
#define REL_Version_STR		"0.1.0"
#define REL_Version_ARRAY	{0,1,0}

#define PRECOMPILE(SCRIPT) 		call compile preProcessFileLineNumbers SCRIPT 
#define WAIT(CODE) 				waitUntil {CODE}
#define DEBUG					if (REL_Debug) then
#define ALTITUDE(OBJECT)		((getposATL OBJECT) select 2)
#define HC_NAMES				["HC","HeadlessClient"]
#define isHC(VAR)				((name VAR) in HC_NAMES)

#define BLU			west
#define OPF			east
#define IND			resistance
#define CIV			civilian

#define BLU_STR		"WEST"
#define OPF_STR		"EAST"
#define IND_STR		"GUER"
#define CIV_STR		"CIV"

#define SIDE_ARRAY			[BLU,OPF,IND,CIV]
#define SIDE_ARRAY_STR		[BLU_STR,OPF_STR,IND_STR,CIV_STR]

#define DEBUG_HEADER	format ["%1-[REL]",time]

#endif //REL_MACROS_H