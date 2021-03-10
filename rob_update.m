% Name        : theRobot=rob_update(theRobot,theGoal)
% Description : Updates the robot pose to go to the goal point.
% Input       : theRobot - Robot data structure
%               theGoal - Goal point [x;y;h]

% Output      : theRobot - Robot data structure updated
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function theRobot=rob_update(theRobot,theGoal)
    goalPoint=theGoal(1:2,1);
    goalAltitude=theGoal(3,1);

    if theRobot.theAltitude>goalAltitude+theRobot.verticalSpeed
        theRobot.theAltitude=theRobot.theAltitude-theRobot.verticalSpeed;
    elseif theRobot.theAltitude<goalAltitude-theRobot.verticalSpeed
        theRobot.theAltitude=theRobot.theAltitude+theRobot.verticalSpeed;
    end

    localGoalPoint=compose_point(invert_reference(theRobot.thePose),goalPoint);
    localGoalAngle=normalize_angles(atan2(localGoalPoint(2),localGoalPoint(1)));

    curMotion=zeros(3,1);

    if localGoalAngle>theRobot.turnSpeed
        curMotion(3)=theRobot.turnSpeed;
    elseif localGoalAngle<-theRobot.turnSpeed
        curMotion(3)=-theRobot.turnSpeed;
    end

    if abs(localGoalAngle)<pi/4
        curMotion(1)=0.5*theRobot.motionSpeed+((1-(abs(localGoalAngle)*4/pi))*0.5*theRobot.motionSpeed);
    else
        curMotion(1)=0.5*theRobot.motionSpeed;
    end

    theRobot.thePose=compose_references(theRobot.thePose,curMotion);
return;