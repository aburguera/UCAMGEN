% Name        : goalPoints=mis_create_grid(xStart,xEnd,yStart,yEnd,nHor,nVer,hBase,hChange)
% Description : Auxiliary function to create sweeping-like mission goal
%               points.
% Input       : xStart,xEnd,yStart,yEnd - Rectangle to explore with the
%               mission.
%               nHor,nVer - Number of horizontal and vertical grid
%               divisions.
%               hBase - Base altitude for mission points.
%               hChange - Allowed altitude variability between points
%               (0 means no changes allowed- and 1 means values can range
%               from 0 to 2*hBase, though hChange can have values outside
%               [0,1]).
% Output      : goalPoints - The goal points ready to be fed to mis_init.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function goalPoints=mis_create_grid(xStart,xEnd,yStart,yEnd,nHor,nVer,hBase,hChange)
    hMin=hBase*(1-hChange);
    hMax=hBase*(1+hChange);
    theY=linspace(yStart,yEnd,nVer);
    theSelector=0;
    goalPoints=[];
    for curY=theY
        h1=hMin+rand()*(hMax-hMin);
        h2=hMin+rand()*(hMax-hMin);
        if theSelector==0
            curPoints=[[xStart;curY;h1],[xEnd;curY;h2]];
        else
            curPoints=[[xEnd;curY;h1],[xStart;curY;h2]];
        end
        goalPoints=[goalPoints curPoints];
        theSelector=1-theSelector;
    end

    if theSelector==0
        theX=linspace(xStart,xEnd,nHor);
    else
        theX=linspace(xEnd,xStart,nHor);
    end

    theSelector=0;

    for curX=theX
       h1=hMin+rand()*(hMax-hMin);
       h2=hMin+rand()*(hMax-hMin);
       if theSelector==0
           curPoints=[[curX;yEnd;h1],[curX;yStart;h2]];
       else
           curPoints=[[curX;yStart;h1],[curX;yEnd;h2]];
       end
        goalPoints=[goalPoints curPoints];
        theSelector=1-theSelector;
    end
return;