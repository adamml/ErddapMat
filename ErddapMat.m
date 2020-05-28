classdef ErddapMat
%ErddapMat is a Matlab/Octave class providing a client to NOAA's Erddap server

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
    % serverList = suggestServers()
    %
    % Returns a list of Errdap servers as curated on the awesome-erddap list.
    % See https://github.com/IrishMarineInstitute/awesome-erddap for more
    % details.
    %
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
      if(nargin < 2 || nargin > 3)
        error(cat(2,"\n\tErddapMat -> ERROR -> method @getDatasetsOnServer", ...
                  " requires one input argument - supplied = %i \n"),nargin-1);
      end
      if(serverBaseUrl(end) == '/')
        serverBaseUrl(end) = [];
      end
      display(obj.processCSV(urlread(cat(2,serverBaseUrl,...
                                    "/erddap/info/index.mat"))));
      datasetsOnServer = urlread(cat(2,serverBaseUrl,...
                                    "/erddap/info/index.mat"));
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
      csvParsed = "";
    end
  
  end
%
% End private methods
%-------------------------------------------------------------------------------  
end
