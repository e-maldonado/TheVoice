
function varargout = expojave(varargin)
% EXPOJAVE MATLAB code for expojave.fig
%      EXPOJAVE, by itself, creates a new EXPOJAVE or raises the existing
%      singleton*.
%
%      H = EXPOJAVE returns the handle to a new EXPOJAVE or the handle to
%      the existing singleton*.
%
%      EXPOJAVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPOJAVE.M with the given input arguments.
%
%      EXPOJAVE('Property','Value',...) creates a new EXPOJAVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before expojave_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to expojave_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help expojave

% Last Modified by GUIDE v2.5 22-May-2014 23:25:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @expojave_OpeningFcn, ...
                   'gui_OutputFcn',  @expojave_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
warning off
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before expojave is made visible.
function expojave_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to expojave (see VARARGIN)

% Choose default command line output for expojave
handles.output = hObject;

% Puntajes

dat= { '(vacio)', 0;
       '(vacio)', 0;
       '(vacio)', 0;
       '(vacio)', 0;
       '(vacio)', 0;};
set ( handles.uitable1, 'Data',  dat);

% Slider
 set(handles.slider1,'Value',0);
 set(handles.slider7,'Value',0.5);
 
 set (handles.tiempo, 'String', '1' );
 
 handles.f=88200;
 
 %imagen de grafica
 x = imread('thevoice.jpg');
 axes (handles.axes2)
 image (x)
 axis image
 axis off

 %imagen de la trinity
 y = imread('trinity.jpg');
 axes (handles.trini)
 image (y)
 axis image
 axis off

 
 
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes expojave wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = expojave_OutputFcn(hObject, eventdata, handles) 
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
 
% Segundos
tope =  str2num (get(handles.tiempo,'String'));
%-----------------------

set (handles.cuenta, 'String', 'REC' )
set (handles.cuenta, 'ForegroundColor', [1 1 1] ) 

 myRecObj = audiorecorder(handles.f, 16, 2);
 recordblocking (myRecObj, tope); 

 set (handles.cuenta, 'String', 'OFF' )
 set (handles.cuenta, 'ForegroundColor', [0 0 0] ) 
 
 
handles.voz = getaudiodata (myRecObj);
guidata(hObject,handles);

% Ploteo
 y = handles.voz (:, 1);
 t = 0:1/handles.f:length(y)/handles.f-1/handles.f;
 axes (handles.grafica)
 plot (t, y)
 title ('Grabacion')
 xlabel ('Tiempo (s)')

 %-----------
 


% --- Executes on button press in reproducir.
function reproducir_Callback(hObject, eventdata, handles)
% hObject    handle to reproducir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Ploteo
 y = handles.voz (:, 1);
 t = 0:1/handles.f:length(y)/handles.f-1/handles.f;
 axes (handles.grafica)
 plot (t, y)
 title ('Grabacion')
 xlabel ('Tiempo (s)')

 %-----------
 
sound (handles.voz, handles.f)

 


% --- Executes on button press in invertir.
function invertir_Callback(hObject, eventdata, handles)
% hObject    handle to invertir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sound (handles.voz(end:-1:1, 1), handles.f)


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

 value = get(handles.slider1,'Value');
 sec = ceil(value*5)+1;
 set (handles.tiempo, 'String', num2str (sec)   );


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end






% --- Executes on key press with focus on slider1 and none of its controls.
function slider1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
 % sec = get (handles.slider1,'value')    
 


% --- Executes on button press in stereo.
function stereo_Callback(hObject, eventdata, handles)
% hObject    handle to stereo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
audio = handles.voz;

 [ l m ] = size (audio);

 if get (handles.dirid, 'Value') == 1
  mascara1 = linspace (1, 0, l );
 mascara2 = linspace (0, 1, l );
 end
 
 if get (handles.dirdi, 'Value') == 1
 mascara1 = linspace (0, 1, l );
 mascara2 = linspace (1, 0, l );
 end
 
 mascara1 = (exp (mascara1)-1 )/1;
 mascara2 = (exp (mascara2)-1 )/1; 
 cool = zeros (l, 2);
 for i=1:l
     cool(i, 1)= mascara1(i) * audio (i, 1);
     cool(i, 2)= mascara2(i) * audio (i, 1);
 end
 
 sound (cool, handles.f);


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in dist.
function dist_Callback(hObject, eventdata, handles)
% hObject    handle to dist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value = get(handles.slider7,'Value');
m = 1;
if (value >=0.5)
    m=2*value
else
    m=(6*value/5)+0.4;
end
sound  (handles.voz, m*handles.f)




% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
value = get(handles.slider7,'Value');
if (value >=0.5)
     m=2*value
else
     m=(6*value/5)+0.4
end


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in concurso.
function concurso_Callback(hObject, eventdata, handles)
% hObject    handle to concurso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

audio = handles.voz;
audio = audio (:, 1);
 tr = fft (audio);
 tr= fftshift (tr);
 
 f = linspace (-44100, 44100, length (tr));
 f = f';
 
% Ploteo

 axes (handles.grafica)
 plot (f, abs (tr))
 title ('Análisis en frecuencia')
 xlabel ('Frecuencia (Hz)')
 zoom on
 datacursormode on
 %-----------

 

 pos20 = max (find (f<20)) ;
 pos20k= max (find (f<20000));
 
maximus =  max (abs (tr (pos20:pos20k)));

posmax = max (find (abs (tr)== maximus));
nuevaf = f(posmax);

set (handles.frecuencia, 'String', f(posmax));

dat = get (handles.uitable1, 'Data');
info = cell2struct (dat, {'ganador', 'puntajes'}, 2) ;


datos = struct2dataset(info);

df =[];
for i=1:5
    df = [df; datos.puntajes(i)];
end

if (nuevaf >= min (df))
    
   datos.puntajes(5) = nuevaf ;
   answer = inputdlg('Eres un feliz ganador. Estas en el TOP 5 de los mas gritones. Escribe tu nombre a continuacion: ','Ganador');
   nombre = answer{1};
   datos.ganador{5}= nombre;
   ordenado = sortrows (datos, {'puntajes'}, {'descend'});
   analisis = dataset2cell (ordenado);
   analisis = analisis (2:6, :);
   set (handles.uitable1, 'Data', analisis);
   
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over slider1.
function slider1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
