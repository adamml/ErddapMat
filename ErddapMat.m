classdef ErddapMat
  %ErddapMat is a Matlab/Octave class providing a client to NOAA's Erddap server
  %
  % ErddapMat Methods:
  %     getDatasetsOnServer(serverBaseUrl) - List datasets on an Erddap server
  %     suggestServers() - Suggest a list of known Erddap servers

%-------------------------------------------------------------------------------
% Private attributes
%  
  properties (Access = private)
    _privateAwesomeErddapJSON = ...
       cat(2,"https://raw.githubusercontent.com/IrishMarineInstitute/",...
              "awesome-erddap/master/erddaps.json");
  end
%
% End private attributes
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
% Public methods
%  
  methods
    
    function serverList = suggestServers(obj)
      %suggestServers returns a list of known Erddap instances
      %
      % suggestServers()
      %
      % Returns a list of Errdap servers as curated on the awesome-erddap list.
      % See https://github.com/IrishMarineInstitute/awesome-erddap for more
      % details.
      %
      %-------------------------------------------------------------------------
      % Adam Leadbetter - 2020-May-15
      %
      
      kvp = urlread(obj._privateAwesomeErddapJSON);
      colonInKvp = strfind(kvp,":");
      %
      % This FOR loop removes the indicies of colons from htttp URLs from the
      % colon index
      %
      for(idxColonKvp = 1:length(colonInKvp))
        if(strcmp(kvp(colonInKvp(idxColonKvp)+1),"/"))
          colonInKvp(idxColonKvp) = -999;
        end
      end
      colonInKvp(colonInKvp == -999) = [];
      %
      % This FOR loop builds a cell array of strings based on the remaining 
      % colon indicies, building the KVP from the JSON array
      %
      idxOne = 1; kvpCell = {};
      for(idxColonKvp = 1:length(colonInKvp))
        kvpCell{end+1} =  kvp(idxOne:colonInKvp(idxColonKvp)-1);
        idxOne = colonInKvp(idxColonKvp) + 1;
      end
      display(kvpCell);
      serverList = 1;
    end
    
    function datasetsOnServer = getDatasetsOnServer(obj, serverBaseUrl)
    %getDatasetsOnServer lists the datasets on a given Erddap server instance
    %
    % getDatasetOnServer(serverBaseUrl)
    %
    % Returns a cell array of strings containing the output of the RESTful call 
    % to an Erddap server's base information page.
    %
    % Example
    % -------
    %     em = ErddapMat();
    %     datasets = em.getDatasetsOnServer("http://erddap.marine.ie");
    %
    %---------------------------------------------------------------------------
    % Adam Leadbetter - 28 May 2020
    %
    
      if(nargin < 2 || nargin > 3)
        error(cat(2,"\n\tErddapMat -> ERROR -> method @getDatasetsOnServer", ...
                  " requires one input argument - supplied = %i \n"),nargin-1);
      end
      if(serverBaseUrl(end) == '/')
        serverBaseUrl(end) = [];
      end
      datasetsOnServer = obj.processCSV(urlread(cat(2,serverBaseUrl,...
                                    "/erddap/info/index.csv")));
    end
    
  end
%
% End public methods
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
% Private methods
%  
  methods (Access = private)
    
    function csvParsed = processCSV(obj, csvString)
    %Parse a CSV string to a cell array
      splitter = regexp(csvString,...
                          '(?:,|\n|^)("(?:(?:"")*[^"]*)*"|[^",\n]*|(?:\n|$))');
      if(splitter(1) == 1)
        splitter(1)  == [];
      end
      %
      % Find the first new line to identify the number of columns we're
      % reading
      %
      newLines = strfind(csvString,"\n");
      while(newLines(1) == 1)
        newLines(1)  =  [];
      end
      numberOfColumns = length(strfind(csvString(1:newLines(1)),",")) + 1;
      csvParsed = {};
      for(idxCsvSplitter  = 2:1:length(splitter))
        csvParsed{idxCsvSplitter-1} = ...
              csvString(splitter(idxCsvSplitter - 1):splitter(idxCsvSplitter));
        if(csvParsed{idxCsvSplitter-1}(1)  ==  ",")
          csvParsed{idxCsvSplitter-1}(1) = [];
        end
        if(csvParsed{idxCsvSplitter-1}(end)  ==  ",")
          csvParsed{idxCsvSplitter-1}(end) = [];
        end
      end
      csvParsed = reshape(csvParsed,numberOfColumns,...
                                            length(csvParsed)/numberOfColumns)';
    end
  
  end
%
% End private methods
%-------------------------------------------------------------------------------  
end
