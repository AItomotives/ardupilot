#pragma once

#include "Copter.h"
#include "NavAndReward.h"
#include <vector>

class CommandList {

    public:
        
        std::vector<NavAndReward> NavRewardPairs;
        int size;

        CommandList();
        void addCommand(AP_Mission::Mission_Command cmd);
        void getCommand(int idx);
};