#pragma once

#include "Copter.h"

class NavAndReward {

    public:
        AP_Mission::Mission_Command navCommand;
        AP_Mission::Mission_Command rewardCommand;

        NavAndReward(AP_Mission::Mission_Command navCmd, AP_Mission::Mission_Command rwdCmd);

};