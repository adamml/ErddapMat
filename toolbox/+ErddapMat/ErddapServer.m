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
        obj.url = url;
        obj.version = webread(obj.url + "version");
        obj.version_string = strsplit(obj.version, "=");
        obj.version_string = obj.version_string{2};
        obj.version_string = strtrim(obj.version_string);
        obj.version_numeric = str2double(obj.version_string);
        obj.status_page_url = obj.url + "status.html";
    end
  end

end
