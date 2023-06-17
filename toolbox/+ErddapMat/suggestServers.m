function serverList = suggestServers()
  %suggestServers returns a list of known Erddap instances
    %
    % suggestServers()
    %
    % Returns a list of Errdap servers as curated on the awesome-erddap 
    % list.
    %
    % See https://github.com/IrishMarineInstitute/awesome-erddap for more
    % details.
    %
    %----------------------------------------------------------------------
    % Adam Leadbetter - 2023-June-17
    %
    serverList = webread(...
            "https://raw.githubusercontent.com/IrishMarineInstitute/" + ...
            "awesome-erddap/master/erddaps.json");
end
