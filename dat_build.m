% Name        : dat_build(dataSet)
% Description : Builds the dataset
% Input       : dataSet - dataset data structure (as initialized by
%                         dat_init)
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function dataSet=dat_build(dataSet)
    % Compute the viewports
    pbr_init('COMPUTING VIEWPORTS');
    dataSet.viewPortList=[];
    if dataSet.displayMissionExecution
        figure;
    end
    while ~mis_completed(dataSet.theMission)
        [dataSet.theMission,theGoal]=mis_getgoal(dataSet.theMission,dataSet.theRobot.thePose,dataSet.theRobot.theAltitude);
        dataSet.theRobot=rob_update(dataSet.theRobot,theGoal);
        camPose=compose_references(dataSet.theRobot.thePose,dataSet.robToCam);
        viewPort=cam_getviewport(dataSet.theCamera,camPose,dataSet.theRobot.theAltitude);
        if ~viewPort.isCorrect
            error('[ERROR] VIEWPORT OUTSIDE THE WORLD. ABORTING.');
        end
        if mod(dataSet.stepCounter,dataSet.camSamplingRate)==0
            dataSet.viewPortList=[dataSet.viewPortList,viewPort];
            if dataSet.displayMissionExecution
                cla;
                cam_plotviewport(dataSet.theCamera,viewPort,true);
                hold on;
                mis_plot(dataSet.theMission);
                hold on;
                rob_plot(dataSet.theRobot);
                axis equal;
                drawnow;
            else
                pbr_update(dataSet.theMission.curPoint,size(dataSet.theMission.goalPoints,2));
            end
        end
        dataSet.stepCounter=dataSet.stepCounter+1;
    end
    pbr_end(sprintf(' N. IMAGES : %d',size(dataSet.viewPortList,2)));

    % Compute overlap matrix
    pbr_init('COMPUTING OVERLAP MATRIX');
    numViewPorts=size(dataSet.viewPortList,2);
    dataSet.overlapMatrix=eye(numViewPorts);
    for i=1:numViewPorts-1
        bboxi=dataSet.viewPortList(i).boundingBox;
        poli=dataSet.viewPortList(i).theRect;
        poli(:,end+1)=poli(:,1);
        shapei=polyshape(poli(1,:),poli(2,:));
        areai=area(shapei);
        for j=i+1:numViewPorts
            bboxj=dataSet.viewPortList(j).boundingBox;
            if (bboxi(4)<bboxj(3))||(bboxi(3)>bboxj(4))||(bboxi(2)<bboxj(1))||(bboxi(1)>bboxj(2))
                theOverlap=0;
            else
                polj=dataSet.viewPortList(j).theRect;
                polj(:,end+1)=polj(:,1);
                shapej=polyshape(polj(1,:),polj(2,:));
                shapeint=intersect(shapei,shapej);
                areaj=area(shapej);
                areaint=area(shapeint);
                theOverlap=areaint/(areai+areaj-areaint);
            end
            dataSet.overlapMatrix(i,j)=theOverlap;
            dataSet.overlapMatrix(j,i)=theOverlap;
        end
        if mod(i,10)==0
            pbr_update(i,numViewPorts-1);
        end
    end
    pbr_end('');

    % Compute motion matrix
    pbr_init('COMPUTING MOTION MATRIX');
    dataSet.motionMatrix=zeros(numViewPorts,numViewPorts,4);
    for i=1:numViewPorts-1
        iPose=dataSet.viewPortList(i).thePose;
        iPoseInv=invert_reference(iPose);
        iAltitude=dataSet.viewPortList(i).theAltitude;
        for j=i+1:numViewPorts
            jPose=dataSet.viewPortList(j).thePose;
            jAltitude=dataSet.viewPortList(j).theAltitude;
            ijMotion=compose_references(iPoseInv,jPose);
            jiMotion=invert_reference(ijMotion);
            ijMotion=[ijMotion;jAltitude-iAltitude];
            jiMotion=[jiMotion;iAltitude-jAltitude];
            dataSet.motionMatrix(i,j,:)=ijMotion;
            dataSet.motionMatrix(j,i,:)=jiMotion;
        end
        if mod(i,10)==0
            pbr_update(i,numViewPorts-1);
        end
    end
    dataSet.motionMatrix(:,:,3)=normalize_angles(dataSet.motionMatrix(:,:,3));
    pbr_end('');

    % Compute odometry
    pbr_init('COMPUTING ODOMETRY');
    prePose=dataSet.viewPortList(1).thePose;
    preAltitude=dataSet.viewPortList(1).theAltitude;
    dataSet.thePoses=[prePose;preAltitude];
    dataSet.theOdometry=[prePose;preAltitude];
    for i=2:numViewPorts
        curPose=dataSet.viewPortList(i).thePose;
        curAltitude=dataSet.viewPortList(i).theAltitude;

        curMotion=[compose_references(invert_reference(prePose),curPose);curAltitude-preAltitude];
        curPose=[curPose;curAltitude];


        dataSet.thePoses=[dataSet.thePoses,curPose];
        dataSet.theOdometry=[dataSet.theOdometry,curMotion];

        prePose=curPose;
        preAltitude=curAltitude;

        if mod(i,10)==0
            pbr_update(i,numViewPorts);
        end
    end
    pbr_end('');
    dataSet.theOdometry(3,:)=normalize_angles(dataSet.theOdometry(3,:));
    dataSet.thePoses(3,:)=normalize_angles(dataSet.thePoses(3,:));
return;