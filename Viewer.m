function varargout = Viewer(varargin)
% VIEWER MATLAB code for Viewer.fig
%      VIEWER, by itself, creates a new VIEWER or raises the existing
%      singleton*.
%
%      H = VIEWER returns the handle to a new VIEWER or the handle to
%      the existing singleton*.
%
%      VIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIEWER.M with the given input arguments.
%
%      VIEWER('Property','Value',...) creates a new VIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Viewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Viewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Viewer

% Last Modified by GUIDE v2.5 06-Jul-2018 11:11:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Viewer_OpeningFcn, ...
                   'gui_OutputFcn',  @Viewer_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Viewer is made visible.
function Viewer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Viewer (see VARARGIN)

%Decipher the varargin (Expect model and tag)
handles.data = varargin{1};
handles.buttontag = varargin{2};

%Listen for change event
handles.listen = event.listener(handles.data, 'dataChanged', @(o,e) onChangedData(handles,handles.data));

% Choose default command line output for Viewer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
%Run onChangedData to initalise the new figure.
onChangedData(handles,handles.data);
% UIWAIT makes Viewer wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function onChangedData(handles)
%Depending on tag fed to GUI, select how to plot
switch handles.buttontag;
    case 'surf'
        surf(handles.data.current_data,'parent',handles.axes1);%'parent',handles.axes1 prevent window from stealing focus.
    case 'mesh'
        mesh(handles.data.current_data,'parent',handles.axes1);
    case 'contour'
        contour(handles.data.current_data,'parent',handles.axes1);
end

% --- Outputs from this function are returned to the command line.
function varargout = Viewer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
