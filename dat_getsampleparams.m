% Name        : theParams=dat_getsampleparams()
% Description : Defines the dataset creation parameters. Use it as a
%               template to create your own configurations.
% Output      : theParams : Parameters as used in main.m
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function theParams=dat_getsampleparams()
    theParams.worldImageFileName        = 'SAMPLE_WORLD.jpg'; % Large world image
    theParams.cameraOpening             = 90*pi/180;          % Horizontal camera opening
    theParams.cameraResolution          = [240;320];          % Camera output resolution
    theParams.robotToCameraTransform    = [0;0;pi/2];         % Camera -> Robot transform
    theParams.cameraSamplingRate        = 60;                 % Steps per sample

    theParams.missionMargin             = 600;                % Margin in goal creation
    theParams.missionType               = 0;                  % 0=Grid, 1=Random
    theParams.missionGridNumHor         = 5;                  % Num of hor. divisions (GRID)
    theParams.missionGridNumVert        = 5;                  % Num of vert. divisions (GRID)
    theParams.missionRandomNumPoints    = 50;                 % Number of mission points (RANDOM)
    theParams.missionBaseAltitude       = 300;                % Average altitude
    theParams.missionAltitudeVariation  = 0;                  % Altitude variation (0-1)
    theParams.missionTolerance          = 100;                % Goal point tolerance

    theParams.robotMotionSpeed          = 1;                  % Horizontal speed
    theParams.robotRotationSpeed        = pi/512;             % Rotation speed
    theParams.robotLiftSpeed            = 0.05;               % Vertical speed
    theParams.robotSize                 = 30;                 % Robot size (just to plot)

    theParams.displayMissionExecution   = false;              % If true -> very slow
    theParams.folderName                = 'SAMPLE_RANDOM';    % Where to store the dataset
return;