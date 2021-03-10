% Name        : mis_test
% Description : Basic test of mis_* functions. See comments in code.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es


% Create goal points using the helper function. They can also be created
% manually.
goalPoints=mis_create_grid(200,400,100,500,5,4,160,.2);

% Init the mission with the previous goal points and a tolerance of 10
theMission=mis_init(goalPoints,10);

% Sort of simulate a robot. These are their initial pose and altitude.
thePose=[300;300;0];
theAltitude=150;

figure;

% Loop until the mission is completed
while ~mis_completed(theMission)

    % Get the current goal point
    [theMission,theGoal]=mis_getgoal(theMission,thePose,theAltitude);

    % Simulate the robot motion (yes, too simplistic)
    if thePose(1)>theGoal(1)
        thePose(1)=thePose(1)-1;
    else
        thePose(1)=thePose(1)+1;
    end
    if thePose(2)>theGoal(2)
        thePose(2)=thePose(2)-1;
    else
        thePose(2)=thePose(2)+1;
    end
    if theAltitude>theGoal(3)
        theAltitude=theAltitude-1;
    else
        theAltitude=theAltitude+1;
    end

    % Plot the mission
    cla;
    mis_plot(theMission);

    % Plot the simulated robot
    hold on;
    plot_circle(thePose(1),thePose(2),2,'b');
    hold on;
    text(thePose(1),thePose(2),sprintf('h=%.3d',theAltitude));
    axis equal;
    drawnow;
end










