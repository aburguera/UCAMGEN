% Name        : rob_test
% Description : Basic test of rob_* functions. See comments in code.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es

% Create goal points
goalPoints=mis_create_grid(200,400,100,500,5,4,160,.2);

% Create the mission
theMission=mis_init(goalPoints,10);

% Create the robot
theRobot=rob_init([300;300;0],160,1,pi/64,.05,30);

figure;

% While the mission is not completed
while ~mis_completed(theMission)

    % Get the current goal
    [theMission,theGoal]=mis_getgoal(theMission,theRobot.thePose,theRobot.theAltitude);

    % Update the robot accordingly
    theRobot=rob_update(theRobot,theGoal);

    cla;
    % Plot the mission
    mis_plot(theMission);
    hold on;

    % Plot the robot
    rob_plot(theRobot);
    axis equal;
    drawnow;
end