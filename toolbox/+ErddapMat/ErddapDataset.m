classdef ErddapDataset
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        datasetid
        protocol
        url

        dimensions
        info
        variables
    end
    
    methods
        function obj = ErddapDataset(url, datasetid, protocol)
            if nargin == 2
                protocol = "Tabledap";
            end
            obj.url = url;
            obj.datasetid = datasetid;
            obj.protocol = protocol;

            obj.info = webread(url + "info/" + datasetid + "/index.json");


            for row = 1:1:length(obj.info.table.rows)
                row_data = obj.info.table.rows(row);
                if row_data{1}{1} == "variable"
                    obj.variables{length(obj.variables) + 1} = row_data{1}{2};
                elseif row_data{1}{1} == "dimension"
                    obj.dimensions{length(obj.variables) + 1} = row_data{1}{2};
                end
            end

            obj.variables = obj.variables';
            obj.dimensions = obj.dimensions';
        end
    end
end

