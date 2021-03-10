% Name        : dat_plotimagepair(dataSet,idxImage1,idxImage2)
% Description : Plots an image pair using their relative motion
% Input       : dataSet - dataset data structure. Must be already built
%                         using dat_build()
%               idxImage1, idxImage2 - Indexes of the images to plot
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function dat_plotimagepair(dataSet,idxImage1,idxImage2)
    % Check if they overlap
    theOverlap=dataSet.overlapMatrix(idxImage1,idxImage2);
    if theOverlap<.2
        fprintf('[WARNING] THE OVERLAP BETWEEN IMAGE%05d AND IMAGE%05d IS %.1f%%\n',idxImage1,idxImage2,theOverlap*100);
    end

    % Get the altitudes
    h1=dataSet.thePoses(4,idxImage1);
    h2=dataSet.thePoses(4,idxImage2);

    % Get the image to world conversion factors
    im1ToWorld=h1*2*dataSet.theCamera.tanHalfOpening/dataSet.theCamera.outSize(2);
    im2ToWorld=h2*2*dataSet.theCamera.tanHalfOpening/dataSet.theCamera.outSize(2);

    % Get the motion
    theMotion=reshape(dataSet.motionMatrix(idxImage1,idxImage2,:),4,1);
    theMotion=theMotion(1:3,1);

    % Read the images
    firstImage=imresize(imread(fullfile(dataSet.folderName,'IMAGES',sprintf('IMAGE%05d.png',idxImage1))),im1ToWorld);
    secondImage=imresize(imread(fullfile(dataSet.folderName,'IMAGES',sprintf('IMAGE%05d.png',idxImage2))),im2ToWorld);

    % Fuse the images
    fusedImage=fuse_imagepair(firstImage,secondImage,theMotion);

    figure;
    image(fusedImage);
    axis equal;
return;