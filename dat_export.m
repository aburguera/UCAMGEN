% Name        : dat_export(dataSet)
% Description : Creates the image files and CSV files
% Input       : dataSet - dataset data structure. Must be already built
%                         using dat_build()
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function dat_export(dataSet)
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
    outFile=fopen(fullfile(dataSet.folderName,'IMGRPOS.csv'),'wt');
    nRows=size(dataSet.motionMatrix,1);
    nCols=size(dataSet.motionMatrix,2);
    for r=1:nRows
        rowTxt='';
        for c=1:nCols
            curMotion=dataSet.motionMatrix(r,c,:);
            % Motion is x#y#o#h
            rowTxt=[rowTxt,sprintf('%.4f#%.4f#%.4f#%.4f,',curMotion(1),curMotion(2),curMotion(3),curMotion(4))];
        end
        rowTxt=sprintf('%s\n',rowTxt(1:end-1));
        fprintf(outFile,rowTxt);
        if mod(r,10)==0
            pbr_update(r,nRows);
        end
    end
    fclose(outFile);
    writematrix(dataSet.motionMatrix(:,:,1),fullfile(dataSet.folderName,'IMGRPOSX.csv'));
    writematrix(dataSet.motionMatrix(:,:,2),fullfile(dataSet.folderName,'IMGRPOSY.csv'));
    writematrix(dataSet.motionMatrix(:,:,3),fullfile(dataSet.folderName,'IMGRPOSO.csv'));
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

    % Export the readme
    pbr_init('EXPORTING README');
    img2World=2*dataSet.theCamera.tanHalfOpening/dataSet.theCamera.outSize(2);
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
    
    % Save the mat file
    pbr_init('SAVING MAT FILE');
    save(fullfile(dataSet.folderName,'dataSet.mat'),'dataSet');
    pbr_end('');
return;