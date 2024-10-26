classdef ErddapServer

 properties (Access=private)
    url     % The web address of the Erddap Server
 end

 properties
     status_page_url
     tabledap_all_datasets
     version
     version_numeric
     version_string
 end

  methods
    function obj = ErddapServer(url)

      % TODO: Handle non-trailing slashes
      % TODO: Ensure the /erddap/ suffix is on the end of the server name

        obj.url = url;

        % Get version information from the Erddap Server
        obj.version = strtrim(webread(strcat(obj.url,"version")));
        obj.version_string = strsplit(obj.version, "=");
        obj.version_string = obj.version_string{2};
        obj.version_numeric = str2double(obj.version_string);
        obj.status_page_url = strcat(obj.url, "status.html");

        obj.tabledap_all_datasets = ErddapDataset(...
            obj.url, "allDatasets", "tabledap");
    end
  end

end
