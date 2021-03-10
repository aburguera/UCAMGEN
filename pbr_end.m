% Name        : pbr_end(finalString)
% Description : Finalizes a progress bar
% Input       : finalString - Text to plot after ending
% Note        : barLen must be consistent between pbr_init, pbr_update and
%               pbr_end.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function pbr_end(finalString)
    pbr_update(50,50);
    fprintf('%s\n',finalString);
return;