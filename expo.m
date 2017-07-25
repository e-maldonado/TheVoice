function varargout = expo(varargin)
% EXPO MATLAB code for expo.fig
%      EXPO, by itself, creates a new EXPO or raises the existing
%      singleton*.
%
%      H = EXPO returns the handle to a new EXPO or the handle to
%      the existing singleton*.
%
%      EXPO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPO.M with the given input arguments.
%
%      EXPO('Property','Value',...) creates a new EXPO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before expo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to expo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help expo

% Last Modified by GUIDE v2.5 22-May-2014 14:22:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @expo_OpeningFcn, ...
                   'gui_OutputFcn',  @expo_OutputFcn, ...
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


% --- Executes just before expo is made visible.
function expo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to expo (see VARARGIN)

% Choose default command line output for expo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes expo wait for user response (see UIRESUME)
% uiwait(handles.expo);


% --- Outputs from this function are returned to the command line.
function varargout = expo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in grabar.
function grabar_Callback(hObject, eventdata, handles)
% hObject    handle to grabar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

myRecObj = audiorecorder(44100, 16, 2);
recordblocking (myRecObj, 5);


y = getaudiodata(myRecObj);



handles.wav = y



% --- Executes on button press in normal.
function normal_Callback(hObject, eventdata, handles)
ynormal = handles.wav

sound (ynormal, 44100);



% --- Executes on button press in invertir.
function invertir_Callback(hObject, eventdata, handles)
yinv=y(1,:);
sound(yinv(end:-1:1),44100);


% --- Executes on button press in lento.
function lento_Callback(hObject, eventdata, handles)
sound(y(end:-1:1),22050);


% --- Executes on button press in rapido.
function rapido_Callback(hObject, eventdata, handles)
sound(y(end:-1:1),60000);


% --- Executes on button press in grito.
function grito_Callback(hObject, eventdata, handles)
s=fft(y);
f=linspace(-44100,44100);


% --- Executes during object creation, after setting all properties.
function expo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to expo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
