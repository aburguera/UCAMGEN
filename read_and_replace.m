% Name        : read_and_replace(inFileName,theReplacements,outFileName)
% Description : Reads one text file, replaces strings and saves the results
%               in another file.
% Input       : inFileName      - File to read
%               theReplacements - Cell array of cell arrays. Each inner
%                                 cell array contains 2 strings: the string
%                                 to replace and the replacement.
%               outFileName     - File to save
% Author      : Antoni Burguera (2021) - antoni dot burguera at uib dot es
function read_and_replace(inFileName,theReplacements,outFileName)
    inFile=fopen(inFileName,'rt');
    theText=char(fread(inFile).');
    fclose(inFile);

    for i=1:size(theReplacements,1)
        curReplacement=theReplacements{i};
        curSource=curReplacement{1};
        curDest=curReplacement{2};
        theText=strrep(theText,curSource,curDest);
    end

    outFile=fopen(outFileName,'wt');
    fwrite(outFile,theText);
    fclose(outFile);
return;