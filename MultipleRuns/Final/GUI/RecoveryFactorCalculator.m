function varargout = RecoveryFactorCalculator(varargin)
% RECOVERYFACTORCALCULATOR MATLAB code for RecoveryFactorCalculator.fig
%      RECOVERYFACTORCALCULATOR, by itself, creates a new RECOVERYFACTORCALCULATOR or raises the existing
%      singleton*.
%
%      H = RECOVERYFACTORCALCULATOR returns the handle to a new RECOVERYFACTORCALCULATOR or the handle to
%      the existing singleton*.
%
%      RECOVERYFACTORCALCULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECOVERYFACTORCALCULATOR.M with the given input arguments.
%
%      RECOVERYFACTORCALCULATOR('Property','Value',...) creates a new RECOVERYFACTORCALCULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RecoveryFactorCalculator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RecoveryFactorCalculator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RecoveryFactorCalculator

% Last Modified by GUIDE v2.5 08-Apr-2014 09:27:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RecoveryFactorCalculator_OpeningFcn, ...
                   'gui_OutputFcn',  @RecoveryFactorCalculator_OutputFcn, ...
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


% --- Executes just before RecoveryFactorCalculator is made visible.
function RecoveryFactorCalculator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RecoveryFactorCalculator (see VARARGIN)

%%%
% load('training_data_scored.mat');
% load('trainedNetwork.mat');
% handles.net = net;
% handles.targets = t;
% handles.outputs = y;

%%%

% Choose default command line output for RecoveryFactorCalculator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RecoveryFactorCalculator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RecoveryFactorCalculator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in predict_button.
function predict_button_Callback(hObject, eventdata, handles)

% Get data the data from the input edit boxes
viscosity = str2double(get(handles.viscosity_input,'String'));
arealDensity = str2double(get(handles.arealDensity_input,'String'));
heterogeneity = str2double(get(handles.heterogeneity_input,'String'));
compartmentalisation = str2double(get(handles.compartmentalisationScored_input,'String'));

% if statement to validate input data
if isnan(viscosity) || ~isreal(viscosity) || viscosity < 0
    % isdouble returns NaN for non-numbers and f1 cannot be complex
    uiwait(msgbox('Viscosity must be a non negative number!','Incorrect Input!', 'warn', 'modal'));
    % Give the edit text box focus so user can correct the error
    uicontrol(handles.viscosity_input)
elseif isnan(arealDensity) || ~isreal(arealDensity) || arealDensity <= 0
    uiwait(msgbox('Areal density must be a number greater than 0!','Incorrect Input!', 'warn', 'modal'));
    uicontrol(handles.arealDensity_input)
elseif isnan(heterogeneity) || ~isreal(heterogeneity) || heterogeneity < 1
    uiwait(msgbox('Heterogeneity must be a number not less than 1!','Incorrect Input!', 'warn', 'modal'));
    uicontrol(handles.heterogeneity_input)
elseif isnan(compartmentalisation) || ~isreal(compartmentalisation) || compartmentalisation < 1 || compartmentalisation > 5
    uiwait(msgbox('Compartmentalisation must be a number between 1 and 5 inclusive.','Incorrect Input!', 'warn', 'modal'));
    uicontrol(handles.compartmentalisation_input)
else

    % viscosity scoring
    if viscosity <= 1
      viscosity = 1;
    elseif viscosity <= 10
      viscosity = 2;
    elseif viscosity <= 100
      viscosity = 3;
    elseif viscosity <= 1000
      viscosity = 4;
    else
      viscosity = 5;
    end

    % arealDensity scoring
    if arealDensity > 4.5
      arealDensity = 1;
    elseif arealDensity > 2
      arealDensity = 2;
    elseif arealDensity > 1
      arealDensity = 3;
    elseif arealDensity > 0.5
      arealDensity = 4;
    else
      arealDensity = 5;
    end

    % heterogeneity scoring
    if heterogeneity <= 10
      heterogeneity = 1;
    elseif heterogeneity <= 10^2
      heterogeneity = 2;
    elseif heterogeneity <= 10^3
      heterogeneity = 3;
    elseif heterogeneity <= 10^4
      heterogeneity = 4;
    else
      heterogeneity = 5;
    end

    % Update the scores in the Score edit boxes
    set(handles.viscosityScored_input, 'String', viscosity);
    set(handles.arealDensityScored_input, 'String', arealDensity);
    set(handles.heterogeneityScored_input, 'String', heterogeneity);
    set(handles.compartmentalisationScored_input, 'String', compartmentalisation);

    sample = [viscosity; arealDensity; heterogeneity; compartmentalisation];
%     recoveryFactor = sim(handles.net, sample);
% 
%     set(handles.recoveryFactor_output, 'String', sprintf('%.2f', recoveryFactor))
% 
%     % cla;
%     plot(handles.regression_axes, handles.targets, handles.outputs, 'rx', 'MarkerSize', 10);
%     grid on;
%     ylabel('Actual Values');     %Set the y-axis label
%     xlabel('Predicted Values');  %Set the x-axis label
%     uicontrol(handles.viscosity_input);
%     lsline;
%     hold on; % keep previous plot visible
%     plot(recoveryFactor, handles.outputs, '-');
%     line([recoveryFactor,recoveryFactor], [0,max(ylim)])
%     hold off % don't overlay any more plots on this figure
end


% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)

% Reset all input edit boxes to their initial value of 0.00 then clear the axes
set(handles.viscosity_input,'String','0.90');
set(handles.arealDensity_input,'String','1.26');
set(handles.heterogeneity_input,'String','100000');
set(handles.recoveryFactor_output,'String','0.00');

set(handles.viscosityScored_input,'String','');
set(handles.arealDensityScored_input,'String','');
set(handles.heterogeneityScored_input,'String','');
set(handles.compartmentalisationScored_input,'String','3');

cla;


% --- Executes on button press in exit_button.
function exit_button_Callback(hObject, eventdata, handles)

% Get the current position of the GUI from the handles structure
% to pass to the modal dialog.
pos_size = get(handles.figure1,'Position');
% Call modaldlg with the argument 'Position'.
user_response = exitdlg('Title','Confirm Exit');
switch user_response
case {'No'}
% take no action
case 'Yes'
% Prepare to close GUI application window
% .
% .
% .
delete(handles.figure1)

end


% --- Executes during object creation, after setting all properties.
function viscosity_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to viscosity_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function arealDensity_input_Callback(hObject, eventdata, handles)
% hObject    handle to arealDensity_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of arealDensity_input as text
%        str2double(get(hObject,'String')) returns contents of arealDensity_input as a double


% --- Executes during object creation, after setting all properties.
function arealDensity_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arealDensity_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function viscosity_input_Callback(hObject, eventdata, handles)
% hObject    handle to heterogeneity_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of heterogeneity_input as text
%        str2double(get(hObject,'String')) returns contents of heterogeneity_input as a double

function heterogeneity_input_Callback(hObject, eventdata, handles)
% hObject    handle to heterogeneity_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of heterogeneity_input as text
%        str2double(get(hObject,'String')) returns contents of heterogeneity_input as a double


% --- Executes during object creation, after setting all properties.
function heterogeneity_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to heterogeneity_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function compartmentalisation_input_Callback(hObject, eventdata, handles)
% hObject    handle to compartmentalisation_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of compartmentalisation_input as text
%        str2double(get(hObject,'String')) returns contents of compartmentalisation_input as a double


% --- Executes during object creation, after setting all properties.
function compartmentalisation_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to compartmentalisation_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function recoveryFactor_output_Callback(hObject, eventdata, handles)
% hObject    handle to recoveryFactor_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recoveryFactor_output as text
%        str2double(get(hObject,'String')) returns contents of recoveryFactor_output as a double


% --- Executes during object creation, after setting all properties.
function recoveryFactor_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recoveryFactor_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function compartmentalisationScored_input_Callback(hObject, eventdata, handles)
% hObject    handle to recoveryFactor_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recoveryFactor_output as text
%        str2double(get(hObject,'String')) returns contents of recoveryFactor_output as a double


% --- Executes during object creation, after setting all properties.
function compartmentalisationScored_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recoveryFactor_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function heterogeneityScored_input_Callback(hObject, eventdata, handles)
% hObject    handle to recoveryFactor_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recoveryFactor_output as text
%        str2double(get(hObject,'String')) returns contents of recoveryFactor_output as a double


% --- Executes during object creation, after setting all properties.
function heterogeneityScored_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recoveryFactor_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function arealDensityScored_input_Callback(hObject, eventdata, handles)
% hObject    handle to recoveryFactor_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recoveryFactor_output as text
%        str2double(get(hObject,'String')) returns contents of recoveryFactor_output as a double


% --- Executes during object creation, after setting all properties.
function arealDensityScored_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recoveryFactor_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function viscosityScored_input_Callback(hObject, eventdata, handles)
% hObject    handle to recoveryFactor_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recoveryFactor_output as text
%        str2double(get(hObject,'String')) returns contents of recoveryFactor_output as a double


% --- Executes during object creation, after setting all properties.
function viscosityScored_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recoveryFactor_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fieldName_input_Callback(hObject, eventdata, handles)
% hObject    handle to fieldName_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fieldName_input as text
%        str2double(get(hObject,'String')) returns contents of fieldName_input as a double


% --- Executes during object creation, after setting all properties.
function fieldName_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fieldName_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in loadCompartmentalisation_button.
function loadCompartmentalisation_button_Callback(hObject, eventdata, handles)
% hObject    handle to loadCompartmentalisation_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get the current position of the GUI from the handles structure
% to pass to the modal dialog.
pos_size = get(handles.figure1,'Position');
% Call modaldlg with the argument 'Position'.
user_response = compartmentalisationdlg();
set(handles.compartmentalisationScored_input,'String', user_response);
