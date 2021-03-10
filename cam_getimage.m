% Name        : theImage=cam_getimage(theCamera,viewPort)
% Description : Outputs the image according to the specified camera and
%               viewport.
% Input       : theCamera - Camera parameters provided by cam_init
%               viewPort  - The viewport as provided by cam_getviewport
% Output      : theImage  - View of theCamera.worldImage from the
%                           specified viewport.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function theImage=cam_getimage(theCamera,viewPort)
    % Get the image
    % Get the part of the world image inside the bounding box
    theImage=theCamera.worldImage(viewPort.boundingBox(1):viewPort.boundingBox(2),viewPort.boundingBox(3):viewPort.boundingBox(4),:);

    % Rotate the subimage according to the viewport orientation
    theImage=imrotate(theImage,viewPort.thePose(3,1)*180/pi);

    % Get the central subimage with the size of the viewport
    subH=size(theImage,1);
    subW=size(theImage,2);
    yMin=max(1,round((subH-viewPort.theSize(1))/2));
    yMax=min(subH,round((subH+viewPort.theSize(1))/2));
    xMin=max(1,round((subW-viewPort.theSize(2))/2));
    xMax=min(subW,round((subW+viewPort.theSize(2))/2));

    theImage=theImage(yMin:yMax,xMin:xMax,:);

    % Resize it to the camera resolution
    theImage=imresize(theImage,[theCamera.outSize(1,1),theCamera.outSize(2,1)]);
return;