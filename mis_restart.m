% Name        : theMission=mis_restart(theMission)
% Description : Restarts the mission by making the first goal point to be
%               the current one.
% Input       : theMission - The mission data structure.
% Output      : The mission data structure restarted.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function theMission=mis_restart(theMission)
    theMission.curPoint=1;
return;