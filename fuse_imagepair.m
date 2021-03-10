% Name        : outImage=fuse_imagepair(firstImage,secondImage,theMotion)
% Description : Overlays two images using the provided motion.
% Input       : firstImage  - Image to fuse (image, not file name)
%               secondImage - Image to fuse (image, not file name)
%               theMotion   - Motion [x;y;theta] from firstImage to
%                             secondImage
% Output      : fusedImage  - The resulting image, ready to be displayed.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function outImage=fuse_imagepair(firstImage,secondImage,theMotion)
    % Get the reference frames stating the scaling factor
    firstReference=imref2d(size(firstImage));
    secondReference=imref2d(size(secondImage));

    % Center both reference frames (origin of coordinates is suposed to be
    % at the center of the image)
    firstReference.XWorldLimits=firstReference.XWorldLimits-mean(firstReference.XWorldLimits);
    firstReference.YWorldLimits=firstReference.YWorldLimits-mean(firstReference.YWorldLimits);
    secondReference.XWorldLimits=secondReference.XWorldLimits-mean(secondReference.XWorldLimits);
    secondReference.YWorldLimits=secondReference.YWorldLimits-mean(secondReference.YWorldLimits);

    % Build the transform
    theAngle=theMotion(3);
    c=cos(theAngle);
    s=sin(theAngle);
    theTransform=rigid2d([c,s;-s,c],theMotion(1:2)');

    % Apply the transform
    [secondImageTransformed,secondReferenceTransformed]=imwarp(secondImage,secondReference,theTransform);

    % Plot both images
    [outImage,~]=imfuse(firstImage,firstReference,secondImageTransformed,secondReferenceTransformed);
return;