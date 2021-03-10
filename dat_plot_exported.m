% Name        : dat_plot_exported()
% Description : Plots part of the dataset (already exported)
% Input       : folderName - Folder where the dataset is
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function dat_plot_exported(dataSet)
    % Read the absolute poses
    thePoses=readmatrix(fullfile(dataSet.folderName,'POSES.csv'));

    % Plot the absolute poses
    figure;
    plot3(thePoses(1,:),thePoses(2,:),thePoses(4,:),'k');
    title('ABSOLUTE POSES (POSES.csv)');
    axis equal;

    % Read the odometry
    theOdom=readmatrix(fullfile(dataSet.folderName,'ODOM.csv'));

    % Process the odometry
    X=zeros(3,1);
    h=0;
    Xh=[];
    for i=1:size(theOdom,2)
       X=compose_references(X,theOdom(1:3,i));
       h=h+theOdom(4,i);
       Xh=[Xh,[X;h]];
    end

    % Plot the odometry
    figure;
    plot3(Xh(1,:),Xh(2,:),Xh(4,:),'r');
    title('ODOMETRY (PROCESSED FROM ODOM.csv)');
    axis equal;

    % Plot the overlap matrix
    figure;
    theMatrix=readmatrix(fullfile(dataSet.folderName,'OVERLAP.csv'));
    image(theMatrix*255/100);
    title('OVERLAP MATRIX (OVERLAP.csv)');
    axis equal;
return;