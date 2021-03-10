% Name        : mis_plot(theMission)
% Description : Plots the mission: mission points, current point, current
%               tolerance. Altitude is printed as text.
% Input       : theMission - The mission data structure.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function mis_plot(theMission)
    plot(theMission.goalPoints(1,:),theMission.goalPoints(2,:),'r*','MarkerSize',5);
    hold on;
    if ~mis_completed(theMission)
        curPoint=theMission.goalPoints(:,theMission.curPoint);
    else
        curPoint=theMission.goalPoints(:,end);
    end
    text(curPoint(1),curPoint(2),sprintf('h=%.1f',curPoint(3)));
    plot_circle(curPoint(1),curPoint(2),theMission.theTolerance,'r');
return;
