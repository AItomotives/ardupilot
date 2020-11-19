#include "NavAndReward.h"

NavAndReward::NavAndReward(AP_Mission::Mission_Command navCmd, AP_Mission::Mission_Command rwdCmd) {
    navCommand = navCmd;
    rewardCommand = rwdCmd;
}