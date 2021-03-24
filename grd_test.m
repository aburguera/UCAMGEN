% Name        : grd_test
% Description : Use of the cam_* functions to create a set of images
%               corresponding to a grid scan of the world image.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es

% Define some parameters
outPath='IMAGES';           % Path to save images. Must exist.
numHor=10;
camRows=64;
camCols=64;
camAltitude=320;
worldMargin=700;
gridAngularStep=pi/16;
doPlot=false;

% Init the camera
theCamera=cam_init('SAMPLE_WORLD.jpg',90*pi/180,[camRows;camCols]);

% Create the grid points
numVert=round(size(theCamera.worldImage,1)*numHor/size(theCamera.worldImage,2));
xMin=worldMargin;
xMax=size(theCamera.worldImage,2)-worldMargin;
yMin=worldMargin;
yMax=size(theCamera.worldImage,1)-worldMargin;
xValues=linspace(xMin,xMax,numHor);
yValues=linspace(yMin,yMax,numVert);

% Create the viewports

% Create figure if required
if doPlot
    figure;
end
curImageNum=1;

% For each grid point
for yCam=yValues
    for xCam=xValues
        % Scan angularly starting at a random orientation
        theAngles=normalize_angles(((rand()*2*pi)-pi)+(0:gridAngularStep:2*pi));
        for oCam=theAngles
            % Get the viewport
            viewPort=cam_getviewport(theCamera,[xCam;yCam;oCam],camAltitude);
            % If viewport is correct...
            if viewPort.isCorrect
                % Get the image observed by the cmera
                theImage=cam_getimage(theCamera,viewPort);
                % Save the image
                imwrite(theImage,fullfile(outPath,sprintf('IMAGE%05d.png',curImageNum)));
                curImageNum=curImageNum+1;
                % If plot requested
                if doPlot
                    % Plot the viewport overlayed to the world image
                    subplot(2,1,1);
                    cla;
                    cam_plotviewport(theCamera,viewPort,true);
                    axis equal;
                    % Plot the image observed by the camera
                    subplot(2,1,2);
                    cla;
                    image(theImage);
                    axis equal;
                    drawnow;
                end
            % If viewport is not correct, warn about it.
            else
                disp('[WARNING] THE VIEWPORT IS NOT FULLY INSIDE THE WORLD.');
            end
        end
    end
end