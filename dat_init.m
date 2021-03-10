% Name        : dataSet=dat_init(theParams)
% Description : Initializes the dataset structure.
% Input       : theParams : Parameters as created by dat_getsampleparams or
%                           other equivalent functions.
% Output      : dataSet : Initialized dataset structure.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function dataSet=dat_init(theParams)
    % Check if the dataset already exists
    if exist(theParams.folderName,'dir')
        error('[ ERROR ] FOLDER %s ALREADY EXISTS. ABORTING.\n',theParams.folderName);
    end
    dataSet.folderName=theParams.folderName;

    % Initialize the camera
    dataSet.theCamera=cam_init(theParams.worldImageFileName,theParams.cameraOpening,theParams.cameraResolution);
    worldSize=size(dataSet.theCamera.worldImage);

    % Initialize the mission
    xMin=theParams.missionMargin;
    xMax=worldSize(2)-theParams.missionMargin;
    yMin=theParams.missionMargin;
    yMax=worldSize(1)-theParams.missionMargin;
    if theParams.missionType==0
        goalPoints=mis_create_grid(xMin,xMax,yMin,yMax,theParams.missionGridNumHor,theParams.missionGridNumVert,theParams.missionBaseAltitude,theParams.missionAltitudeVariation);
    else
        goalPoints=mis_create_random(xMin,xMax,yMin,yMax,theParams.missionBaseAltitude,theParams.missionAltitudeVariation,theParams.missionRandomNumPoints);
    end
    dataSet.theMission=mis_init(goalPoints,theParams.missionTolerance);

    % Initialize the robot
    dataSet.theRobot=rob_init([goalPoints(1);goalPoints(2);0],theParams.missionBaseAltitude,theParams.robotMotionSpeed,theParams.robotRotationSpeed,theParams.robotLiftSpeed,theParams.robotSize);

    % Initialize other fields
    dataSet.robToCam=theParams.robotToCameraTransform;
    dataSet.camSamplingRate=theParams.cameraSamplingRate;
    dataSet.displayMissionExecution=theParams.displayMissionExecution;
    dataSet.viewPortList=[];
    dataSet.overlapMatrix=[];
    dataSet.motionMatrix=[];
    dataSet.theOdometry=[];
    dataSet.thePoses=[];
    dataSet.stepCounter=0;
return;

