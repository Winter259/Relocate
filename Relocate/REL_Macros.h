#include "Kami_Macros.h"

#ifndef REL_MACROS_H
#define REL_MACROS_H

#define REL_VERSION			0.1
#define REL_VERSION_STR		"0.1.0"
#define REL_VERSION_ARRAY	{0,1,0}

#define PRECOMPILE(SCRIPT) 		call compile preProcessFileLineNumbers SCRIPT 
#define WAIT(CODE) 				waitUntil {CODE}
#define WAIT_DELAY(DELAY,CODE) 	waitUntil {sleep DELAY;CODE}
#define DEBUG					if (REL_Debug) then
#define ALTITUDE(OBJECT)		((getposATL OBJECT) select 2)
#define HC_NAMES				["HC","HeadlessClient"]
#define isHC(VAR)				((name VAR) in HC_NAMES)

#define IS_ARMA2				(REL_ArmaVersion == 2)
#define IS_ARMA3				(REL_ArmaVersion == 3)

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

#define HULL_LEADER_ARRAY	["CO","SL","FTL","MMGG","HMGG","MATG","HATG","SN","MRTG","ENG","VC"]

#define DEBUG_HEADER	format ["%1-[REL]: ",time]

#endif //REL_MACROS_H