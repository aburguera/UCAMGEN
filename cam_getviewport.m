% Name        : viewPort=cam_getviewport(theCamera,thePose,theAltitude)
% Description : Computes the viewport corresponding to the specified pose
%               and altitude.
% Input       : theCamera   - Camera parameters provided by cam_init
%               thePose     - Camera pose [x;y;heading]. Units=pixels, rad
%               theAltitude - Camera altitude. Scalar. Units=pixels
% Output      : viewPort    - Structure with the following fields:
%                 .thePose     : Copy of thePose
%                 .theAltitude : Copy of theAltitude
%                 .theSize     : Viewport size [height;width] pixels
%                 .theRect     : Viewport rectangle (rotated and
%                                translated)
%                 .boundingBox : Viewport rectangle bounding box.
%                 .isCorrect   : True if the viewport fully lies inside
%                                the world image, false otherwise. If
%                                isCorrect is false, further use of the
%                                viewPort is not recommended.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function viewPort=cam_getviewport(theCamera,thePose,theAltitude)
    % Store pose and altitude
    viewPort.thePose=thePose;
    viewPort.theAltitude=theAltitude;

    % Viewport size
    hSize=2*theAltitude*theCamera.tanHalfOpening;
    vSize=hSize/theCamera.aspectRatio;
    viewPort.theSize=[vSize;hSize];

    % Viewport shape. Points are [x;y]
    viewPort.theRect=compose_point(thePose,[-0.5,0.5,0.5,-0.5;-0.5,-0.5,0.5,0.5].*[hSize;vSize]);

    % Viewport bounding box
    yMin=round(min(viewPort.theRect(2,:)));
    yMax=round(max(viewPort.theRect(2,:)));
    xMin=round(min(viewPort.theRect(1,:)));
    xMax=round(max(viewPort.theRect(1,:)));
    viewPort.boundingBox=[yMin,yMax,xMin,xMax];

    % Check if viewport is correct
    viewPort.isCorrect=(xMin>=1 && yMin>=1 && xMax<=size(theCamera.worldImage,2) && yMax<=size(theCamera.worldImage,1));
return;