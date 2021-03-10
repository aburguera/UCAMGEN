% Name        : rob_plot(theRobot)
% Description : Plots the robot
% Input       : theRobot - Robot data structure
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function rob_plot(theRobot)
    theShape=compose_point(theRobot.thePose,[[-0.3;-0.3],[0.6;0],[-0.3;0.3],[-0.3;-0.3]]*theRobot.plotSize);
    plot(theShape(1,:),theShape(2,:),'r','LineWidth',2);
    hold on;
    text(theRobot.thePose(1),theRobot.thePose(2),sprintf('h=%.1f',theRobot.theAltitude));
return;