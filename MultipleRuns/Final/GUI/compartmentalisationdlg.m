function varargout = compartmentalisationdlg(varargin)
% COMPARTMENTALISATIONDLG MATLAB code for compartmentalisationdlg.fig
%      COMPARTMENTALISATIONDLG, by itself, creates a new COMPARTMENTALISATIONDLG or raises the existing
%      singleton*.
%
%      H = COMPARTMENTALISATIONDLG returns the handle to a new COMPARTMENTALISATIONDLG or the handle to
%      the existing singleton*.
%
%      COMPARTMENTALISATIONDLG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPARTMENTALISATIONDLG.M with the given input arguments.
%
%      COMPARTMENTALISATIONDLG('Property','Value',...) creates a new COMPARTMENTALISATIONDLG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before compartmentalisationdlg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to compartmentalisationdlg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help compartmentalisationdlg

% Last Modified by GUIDE v2.5 08-Apr-2014 10:05:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @compartmentalisationdlg_OpeningFcn, ...
                   'gui_OutputFcn',  @compartmentalisationdlg_OutputFcn, ...
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


% --- Executes just before compartmentalisationdlg is made visible.
function compartmentalisationdlg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to compartmentalisationdlg (see VARARGIN)

% Choose default command line output for compartmentalisationdlg
handles.output = 3;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes compartmentalisationdlg wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = compartmentalisationdlg_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The figure can be deleted now
delete(handles.figure1);





% --- Executes on button press in score1_button.
function score1_button_Callback(hObject, eventdata, handles)

% return button's string property
handles.output = 1;

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);


% --- Executes on button press in score2_button.
function score2_button_Callback(hObject, eventdata, handles)

% return button's string property
handles.output = 2;

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);


% --- Executes on button press in score3_button.
function score3_button_Callback(hObject, eventdata, handles)

% return button's string property
handles.output = 3;

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);


% --- Executes on button press in score4_button.
function score4_button_Callback(hObject, eventdata, handles)

% return button's string property
handles.output = 4;

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);


% --- Executes on button press in score5_button.
function score5_button_Callback(hObject, eventdata, handles)

% return button's string property
handles.output = 5;

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end
