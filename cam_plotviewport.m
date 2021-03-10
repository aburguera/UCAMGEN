% Name        : function cam_plotviewport(theCamera,viewPort,plotWorld)
% Description : Plots the viewport overlayed (if plotWorld=true) to the
%               world image.
% Input       : theCamera - Camera parameters provided by cam_init
%               viewPort  - The viewport as provided by cam_getviewport
%               plotWorld - Plot also the world image (true/false)
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function cam_plotviewport(theCamera,viewPort,plotWorld)
    if plotWorld
        image(theCamera.worldImage);
        hold on;
    end
    theRectangle=viewPort.theRect;
    theRectangle=[theRectangle,theRectangle(:,1)];
    theAxes=compose_point(viewPort.thePose,[[0;1],[0;0],[1;0]]*viewPort.theSize(1)*3/8);
    plot(theRectangle(1,:),theRectangle(2,:),'r','LineWidth',3);
    hold on;
    plot(theAxes(1,:),theAxes(2,:),'b','LineWidth',2);
return;