function varargout = LidarMapping(varargin)
% LIDARMAPPING MATLAB code for LidarMapping.fig
%      LIDARMAPPING, by itself, creates a new LIDARMAPPING or raises the existing
%      singleton*.
%
%      H = LIDARMAPPING returns the handle to a new LIDARMAPPING or the handle to
%      the existing singleton*.
%
%      LIDARMAPPING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LIDARMAPPING.M with the given input arguments.
%
%      LIDARMAPPING('Property','Value',...) creates a new LIDARMAPPING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LidarMapping_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LidarMapping_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LidarMapping

% Last Modified by GUIDE v2.5 23-Oct-2015 12:58:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LidarMapping_OpeningFcn, ...
                   'gui_OutputFcn',  @LidarMapping_OutputFcn, ...
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


% --- Executes just before LidarMapping is made visible.
function LidarMapping_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LidarMapping (see VARARGIN)
%imgData = imread('jpegstop.jpg');   % or: imread(URL)
%hObject = uicontrol('CData',imgData);
% Choose default command line output for LidarMapping
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LidarMapping wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LidarMapping_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in W.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.edit1,'string','Go forward'); 
    %Send character 'w' through serialport bluetooth into UART Tiva
    %The programming of the �controller TIVA requires 4 times repetitive
    %message due to FIFO troubles 
    %keyboard;
    fwrite(handles.b1,'wwww');
    


% --- Executes on button press in A.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.edit1,'string','Turn left'); 
    fwrite(handles.b1,'aaaa');



% --- Executes on button press in S.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.edit1,'string','Reverse'); 
        fwrite(handles.b1,'ssss');




% --- Executes on button press in D.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.edit1,'string','Turn right'); 
        fwrite(handles.b1,'dddd');



% --- Executes on button press in R.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.edit1,'string','Scanning surroundings...'); 
    %Send character R throught serialport bluetooth UART
    %Prepare to receive a large amout of data, the map of the LIDAR
    %TIVA sends first 8 bits MSB and then 8 bits LSB, this is one
    %measurement of length.
    %TIVA then proceeds and sends 400 values of the above format
    %Following assumptions are made;
    %#The LIDAR ontop of a stepper motor must be manually turned 90 deg
    %for the first measurement.
    %The first measurement is taken 90 degrees to the left of the vehicle
    %The 100th measurement is taken 90 degrees to the right of the vehicle
    %The 200th measurement is again taken 90 degrees to the left.
    %Its a sweeping motion and each step is 180 deg / 100 = 1.8 deg
    %Plot the map in "axes1" 
    fwrite(handles.b1,'rrrr');
    




% --- Executes on button press in Q.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.edit1,'string','Halt!'); 
    fwrite(handles.b1,'qqqq');



% --- Executes on button press in B.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.edit1,'string','Bluetooth connecting...'); 
    %Create a bluetooth obj at startup to allow every callback to use it
    %Create a bluetooth handle
    handles.b1 = Bluetooth('Grupp3Hugo',1);
    fopen(handles.b1);
    % Update handles structure
    guidata(hObject, handles);

    set(handles.edit1,'string','Connection confirmed!'); 


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
switch eventdata.Key 
    %Go forward
    case 'w' 
    % set(handles.edit1,'string','Go forward'); 
    pushbutton4_Callback(hObject, eventdata, handles);
    %Turn left
    case 'a' 
    pushbutton5_Callback(hObject, eventdata, handles);
    %Reverse motion
    case 's' 
    pushbutton6_Callback(hObject, eventdata, handles);
    %Turn right
    case 'd' 
    pushbutton7_Callback(hObject, eventdata, handles);
    %Connect with bluetooth throught serial port UART
    case 'b' 
    pushbutton10_Callback(hObject, eventdata, handles);
    %Stop moving, halt motion
    case 'q' 
    pushbutton9_Callback(hObject, eventdata, handles);
    %Scan surroundings and plot the map
    case'r'
    pushbutton8_Callback(hObject, eventdata, handles);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function pushbutton7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called