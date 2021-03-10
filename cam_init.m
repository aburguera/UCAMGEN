% Name        : theCamera=cam_init(worldImageFileName,xOpening,outSize)
% Description : Initializes the virtual camera parameters
% Input       : worldImageFileName - Name of the image file observed by the
%                                    camera.
%               xOpening - Horizontal field of view (Angle in radiants).
%               outSize - [height;width] in pixels of the output images.
% Output      : theCamera - Struct containing the initialized fields as
%                           well as some pre-computed parameters.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function theCamera=cam_init(worldImageFileName,xOpening,outSize)
    % Store the input
    theCamera.worldImageFileName=worldImageFileName;
    theCamera.xOpening=xOpening;
    theCamera.outSize=outSize;

    % Load the image
    theCamera.worldImage=imread(worldImageFileName);

    % Precompute some parameters
    theCamera.aspectRatio=theCamera.outSize(2)/theCamera.outSize(1);
    theCamera.tanHalfOpening=tan(theCamera.xOpening/2);
return;