classdef Data < handle
    %Data represents a simple object as a data container with only one property
    properties (SetAccess = private, Hidden = true)
        peaks %precomputed peaks data
        membrane %precomputed mebrane data
        sinc %precomputed sinc data
    end
    methods
        obj = Data(varargin) %initialize the object
        obj.peaks = peaks(35);
    end
end