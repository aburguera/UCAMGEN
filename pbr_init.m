% Name        : pbr_init(theTitle)
% Description : Initializes a progress bar
% Input       : theTitle - Title of the progress bar
% Note        : barLen must be consistent between pbr_init, pbr_update and
%               pbr_end.
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function pbr_init(theTitle)
    barLen=50;
    fprintf([pad(theTitle,25),' : ',char('.'*ones(1,barLen))]);
return;