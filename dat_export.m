% Name        : dat_export(dataSet)
% Description : Creates the image files and CSV files
% Input       : dataSet - dataset data structure. Must be already built
%                         using dat_build()
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function dataSet=dat_export(dataSet)
    if exist(dataSet.folderName,'dir')
        error('[ ERROR ] FOLDER %s ALREADY EXISTS. ABORTING\n',folderName);
    end

    mkdir(dataSet.folderName);
    imagesPath=fullfile(dataSet.folderName,'IMAGES');
    mkdir(imagesPath);

    % Export images
    pbr_init('EXPORTING IMAGES');
    numViewPorts=size(dataSet.viewPortList,2);
    for i=1:numViewPorts
        theImage=cam_getimage(dataSet.theCamera,dataSet.viewPortList(i));
         fileName=fullfile(imagesPath,sprintf('IMAGE%05d.png',i));
         imwrite(theImage,fileName);
         if (mod(i,10)==0)
            pbr_update(i,numViewPorts);
         end
    end
    pbr_end('');

    % Export overlap matrix
    pbr_init('EXPORTING OVERLAP MATRIX');
    writematrix(round(100*dataSet.overlapMatrix),fullfile(dataSet.folderName,'OVERLAP.csv'));
    pbr_end('');

    % Export motion matrix
    pbr_init('EXPORTING MOTION MATRIX');
    writematrix(dataSet.motionMatrix(:,:,1),fullfile(dataSet.folderName,'IMGRPOSX.csv'));
    pbr_update(1,4);
    writematrix(dataSet.motionMatrix(:,:,2),fullfile(dataSet.folderName,'IMGRPOSY.csv'));
    pbr_update(2,4);
    writematrix(dataSet.motionMatrix(:,:,3),fullfile(dataSet.folderName,'IMGRPOSO.csv'));
    pbr_update(3,4);
    writematrix(dataSet.motionMatrix(:,:,4),fullfile(dataSet.folderName,'IMGRPOSH.csv'));
    pbr_end('');

    % Export odometry
    pbr_init('EXPORTING ODOMETRY');
    writematrix(round(dataSet.theOdometry,4),fullfile(dataSet.folderName,'ODOM.csv'));
    pbr_end('');

    % Export poses
    pbr_init('EXPORTING POSES');
    writematrix(round(dataSet.thePoses,4),fullfile(dataSet.folderName,'POSES.csv'));
    pbr_end('');

    % Export extra parameters
    pbr_init('EXPORTING PARAMETERS')
    img2World=2*dataSet.theCamera.tanHalfOpening/dataSet.theCamera.outSize(2);
    extraParameters=[dataSet.theCamera.xOpening,img2World];
    writematrix(extraParameters,fullfile(dataSet.folderName,'PARAMS.csv'));
    pbr_end('')
    
    % Export the readme
    pbr_init('EXPORTING README');
    world2Img=1/img2World;
    theReplacements={{'##DATASETNAME##',dataSet.folderName},
                     {'##NIMAGES##',string(numViewPorts)},
                     {'##ZNIMAGES##',sprintf('%05d',numViewPorts)},
                     {'##WORLDFNAME##',dataSet.theCamera.worldImageFileName},
                     {'##WORLDRESOLUTION##',sprintf('%d x %d',size(dataSet.theCamera.worldImage,1),size(dataSet.theCamera.worldImage,2))},
                     {'##OUTPUTRESOLUTION##',sprintf('%d x %d',dataSet.theCamera.outSize(1),dataSet.theCamera.outSize(2))},
                     {'##HOPENING##',sprintf('%.6f rad',dataSet.theCamera.xOpening)},
                     {'##IMG2WORLD##',sprintf('%.6f x altitude',img2World)},
                     {'##WORLD2IMG##',sprintf('%.6f / altitude',world2Img)}};

    read_and_replace('base_readme.txt',theReplacements,fullfile(dataSet.folderName,'README.TXT'));
    pbr_end('');
return;