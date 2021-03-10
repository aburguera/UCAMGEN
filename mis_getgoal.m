% Name        : [theMission,theGoal]=mis_getgoal(theMission,thePose,theAltitude)
% Description : Provides the current goal point and updates it according to
%               the provided robot pose and altitude.
% Input       : theMission - The mission data structure.
%               thePose - Pose of the robot executing the mission [x;y;o]
%               theAltitude - Altitude (scalar) of the robot.
% Output      : theMission - The mission data structure updated.
%               theGoal - The goal point [x;y;h].
% Note        : Please note that robot pose vectors are [x;y;o] and the
%               altitude is provided separatedly whilst mission points are
%               [x;y;h] (without orientation and with the altitude h in the
%               point itself).
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function [theMission,theGoal]=mis_getgoal(theMission,thePose,theAltitude)
    theGoal=theMission.goalPoints(:,theMission.curPoint);
    theDistance=thePose(1:2,:)-theGoal(1:2,1);
    theDistance=sqrt(theDistance'*theDistance);
    if theDistance<theMission.theTolerance
        theMission.curPoint=theMission.curPoint+1;
    end
return;