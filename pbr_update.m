% Name        : pbr_update(curValue,maxValue)
% Description : Updates a progress bar
% Input       : curValue - Current progress value
%               maxValue - Maximum progress value
% Note        : barLen must be consistent between pbr_init, pbr_update and
%               pbr_end.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function pbr_update(curValue,maxValue)
    barLen=50;
    nSquares=round(curValue*barLen/maxValue);
    fprintf([char(8*ones(1,barLen)),char('#'*ones(1,nSquares)),char('.'*ones(1,barLen-nSquares))]);
return;