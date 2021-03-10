% Name        : cam_test
% Description : Basic test of cam_* functions. See comments in code.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es

% Init the camera. Use SAMPLE_WORLD.jpg as world image, let the camera
% have 90 degrees of horizontal opening and produce images of 320x240
% pixels.
theCamera=cam_init('SAMPLE_WORLD.jpg',90*pi/180,[240;320]);

% Initial camera position and altitude
xCam=size(theCamera.worldImage,2)/2;
yCam=size(theCamera.worldImage,1)/2;
camAltitude=160;

figure;

% Just perform a 360 degree rotation
for oCam=0:pi/32:2*pi
    % Get the current viewport
    viewPort=cam_getviewport(theCamera,[xCam;yCam;oCam],camAltitude);

    % If viewport is correct...
    if viewPort.isCorrect
        % Get the image observed by the cmera
        theImage=cam_getimage(theCamera,viewPort);

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
    % If viewport is not correct, warn about it.
    else
        disp('[WARNING] THE VIEWPORT IS NOT FULLY INSIDE THE WORLD.');
    end
end