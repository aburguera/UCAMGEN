% Name        : isCompleted=mis_completed(theMission)
% Description : Checks if the mission is completed
% Input       : theMission - The mission data structure.
% Output      : isCompleted - True or false
% Note        : Please note that the completion has to be checked.
%               Otherwise, other functions may fail. Also, getting the
%               current goal point after mission completion will result in
%               an execution error.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function isCompleted=mis_completed(theMission)
    isCompleted=theMission.curPoint>size(theMission.goalPoints,2);
return;