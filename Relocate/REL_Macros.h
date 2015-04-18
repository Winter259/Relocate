#include "Kami_Macros.h"

#ifndef REL_MACROS_H
#define REL_MACROS_H

#define REL_VERSION		    	0.5
#define REL_VERSION_STR		  "0.5.0"
#define REL_VERSION_ARRAY	  {0,5,0}

#define PRECOMPILE(SCRIPT) 	  	call compile preProcessFileLineNumbers SCRIPT 
#define WAIT(CODE) 				      waitUntil {CODE}
#define WAIT_DELAY(DELAY,CODE) 	waitUntil {sleep DELAY;CODE}
#define DEBUG				          	if (REL_Debug) then
#define ALTITUDE(OBJECT)	    	((getposATL OBJECT) select 2)
#define HC_NAMES			         	["HC","HeadlessClient"]
#define isHC(VAR)			         	((name VAR) in HC_NAMES)

#define IS_ARMA2				(REL_ArmaVersion == 2)
#define IS_ARMA3				(REL_ArmaVersion == 3)

#define REL_ACTION_COLOUR_HTML "#F7FE2E"
#define BLUFOR_COLOUR_HTML     "#0040FF"
#define OPFOR_COLOUR_HTML      "#FE2E2E"
#define INDFOR_COLOUR_HTML     "#40FF00"
#define CIV_COLOUR_HTML        "#D358F7"

#define HALO_DROP_DELAY               2
#define HALO_DROP_RADIUS              150
#define HALO_DROP_HEIGHT              2000
#define HALO_PARACHUTE_OPEN_ALTITUDE  400

#define HULL_LEADER_ARRAY	["CO","SL","FTL","MMGG","HMGG","MATG","HATG","SN","MRTG","ENG","VC"]

#define DEBUG_HEADER	format ["%1-[REL]: ",time]

#endif //REL_MACROS_H