% Name        : goalPoints=mis_create_random(xStart,xEnd,yStart,yEnd,nPoints,hBase,hChange)
% Description : Auxiliary function to create a randomized set of goal
%               points.
% Input       : xStart,xEnd,yStart,yEnd - Rectangle where the random goal
%               points are confined.
%               nPoints - Number of random goal points
%               hBase - Base altitude for mission points.
%               hChange - Allowed altitude variability between points
%               (0 means no changes allowed- and 1 means values can range
%               from 0 to 2*hBase, though hChange can have values outside
%               [0,1]).
% Output      : goalPoints - The goal points ready to be fed to mis_init.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function goalPoints=mis_create_random(xStart,xEnd,yStart,yEnd,hBase,hChange,nPoints)
    % Compute min and max altitude
    hMin=hBase*(1-hChange);
    hMax=hBase*(1+hChange);
    % Build the points
    goalPoints=[xStart;yStart;hMin]+rand(3,nPoints).*[xEnd-xStart;yEnd-yStart;hMax-hMin];
return;