classdef Data < handle
    %Data represents a simple object as a data container with only one property
    
    properties (SetObservable = true)
        current_data
        selected_data = 'peaks'
    end
    
    properties (SetAccess = private, Hidden = true)
        peaks %precomputed peaks data
        membrane %precomputed mebrane data
        sinc %precomputed sinc data
    end
    
    events
        dataChanged % the exposed data has changed
        selecterror % an error occurred
    end
    
    methods
        function obj = Data(varargin) %initialize the object
        obj.peaks = peaks(35);
        obj.membrane = membrane;
        [x,y] = meshgrid(-8:.5:8);
        r = sqrt(x.^2+y.^2) + eps;
        sinc = sin(r)./r;
        obj.sinc = sinc;
        end
        function data = get.current_data(obj)
            %this code runs upon access of current_data
            switch obj.selected_data
                case 'peaks'
                    data = obj.peaks;
                case 'membrane'
                    data = obj.membrane;
                case 'sinc'
                    data = obj.sinc;
            end
        end
        function set.selected_data(obj, selection)
            if ismember(selection, ['peaks' 'membrane' 'sinc'])
                obj.selected_data = selection;
                notify(obj, 'dataChanged'); %notify event that the selected data has changed
            else
                notify(obj, 'selecterror')  %notify that an error has occured
                display('Selected data must be ''peaks'', ''membrane'' ir ''sinc''');
            end
        end
    end %methods
    
end %object















