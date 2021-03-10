% Name        : theRobot=rob_init(thePose,theAltitude,motionSpeed,turnSpeed,verticalSpeed,plotSize)
% Description : Initializes the robot data structure.
% Input       : thePose - Initial robot pose [x;y;o]
%               theAltitude - Initial robot altitude (scalar)
%               motionSpeed - Robot motion speed (units per step)
%               turnSpeed - Robot turn speed (radiants per step)
%               verticalSpeed - Robot lift speed (units per step)
%               plotSize - Robot size (just for plotting purposes)
% Output      : theRobot - Robot data structure initialized
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function theRobot=rob_init(thePose,theAltitude,motionSpeed,turnSpeed,verticalSpeed,plotSize)
    theRobot.thePose=thePose;
    theRobot.theAltitude=theAltitude;
    theRobot.motionSpeed=motionSpeed;
    theRobot.turnSpeed=turnSpeed;
    theRobot.verticalSpeed=verticalSpeed;
    theRobot.plotSize=plotSize;
return;