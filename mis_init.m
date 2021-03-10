% Name        : theMission=mis_init(goalPoints,theTolerance)
% Description : Initializes the mission data structure
% Input       : goalPoints - List of goal points. Each column is a 3D point
%                            with [x;y;h]
%               theTolerance - A goal point is reached when the robot is at
%                              a distance below that tolerance.
% Output      : The mission data structure initialized.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function theMission=mis_init(goalPoints,theTolerance)
    theMission.goalPoints=goalPoints;
    theMission.theTolerance=theTolerance;
    theMission=mis_restart(theMission);
return;