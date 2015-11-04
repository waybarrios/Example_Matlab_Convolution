function varargout = convfin(varargin)
% CONVFIN M-file for convfin.fig
%      CONVFIN, by itself, creates a new CONVFIN or raises the existing
%      singleton*.
%
%      H = CONVFIN returns the handle to a new CONVFIN or the handle to
%      the existing singleton*.
%
%      CONVFIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONVFIN.M with the given input arguments.
%
%      CONVFIN('Property','Value',...) creates a new CONVFIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before convfin_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to convfin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help convfin

% Last Modified by GUIDE v2.5 15-Oct-2011 17:45:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @convfin_OpeningFcn, ...
                   'gui_OutputFcn',  @convfin_OutputFcn, ...
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


% --- Executes just before convfin is made visible.
function convfin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to convfin (see VARARGIN)

% Choose default command line output for convfin
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes convfin wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = convfin_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in expcre.
function expcre_Callback(hObject, eventdata, handles)
% hObject    handle to expcre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t1ini=str2double(get(handles.t1in,'string'));
t1fin=str2double(get(handles.t1fin,'string'));
A1=str2double(get(handles.A_1,'string'));
t2ini=str2double(get(handles.t2in,'string'));
t2fin=str2double(get(handles.t2fin,'string'));
a=abs(str2double(get(handles.arg,'string')));
T1=t1ini:0.01:t1fin;
T2=t2ini:0.01:t2fin;
Lx=length(T1);
Lh=length(T2);
x=ones (size(T1)).*(T1>=t1ini).*(T1<=t1fin); 
x=A1*x;
h=exp(a*T2).*(T2>=t2ini).*(T2<=t2fin);
ancho=T2(Lh)-T2(1);
Eje_t=linspace(-ancho+T1(1),T1(Lx)+ancho,Lx+Lh+Lh+1);
Eje_tfinal=linspace(T2(1)+T1(1),T1(Lx)+T2(Lh),Lx+Lh+1+1);
%--------------------Desarrollo de la Convolucion----------------
            for tc=0:Lx+Lh-1 %Longitud del resultado de la convolución = Lx+Lh-1

            %--------------- Gráfica de x(T)------------------
            x_T=[zeros(1,Lh) x zeros(1,Lh+1)];
            axes(handles.axes1)
            plot(Eje_t,x_T,'b');
            title('x(T)')
            xlabel('T')
            set(handles.axes1,'XMinorTick','on')
            grid;
            pause(0.0000001);
            %--------------- Gráfica de h(t-T) -----------------
            h_t_menos_T=[zeros(1,tc+1) h(Lh:-1:1) zeros(1,Lx+Lh-tc)];
            axes(handles.axes3)
            plot(Eje_t,h_t_menos_T,'r');
            title('h(t-T)')
            xlabel('T')
            set(handles.axes3,'XMinorTick','on')
            grid; 
            pause(0.0000001);
            %--------------- Gráfica de x(T)h[t-T] -----------------   
            axes(handles.axes2)
            plot(Eje_t,x_T.*h_t_menos_T,'y');
            title('x(t)*h(t-T)')
            xlabel('T')
            set(handles.axes3,'XMinorTick','on')
            grid;

            %--------------- Gráfica de y(t) --------------
            y_t(tc+1)=sum(x_T.*h_t_menos_T);
            axes(handles.axes4)
            plot(Eje_tfinal,[0 y_t zeros(1,Lx+Lh-tc)]*0.01,'g');
            title('y(t)')
            xlabel('t')
            set(handles.axes4,'XMinorTick','on')
            grid;
            pause(0.0000001);
            end



% --- Executes on button press in expdecre.
function expdecre_Callback(hObject, eventdata, handles)
% hObject    handle to expdecre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t1ini=str2double(get(handles.t1in,'string'));
t1fin=str2double(get(handles.t1fin,'string'));
A1=str2double(get(handles.A_1,'string'));
t2ini=str2double(get(handles.t2in,'string'));
t2fin=str2double(get(handles.t2fin,'string'));
a=abs(str2double(get(handles.arg,'string')));
T1=t1ini:0.01:t1fin;
T2=t2ini:0.01:t2fin;
Lx=length(T1);
Lh=length(T2);
x=ones (size(T1)).*(T1>=t1ini).*(T1<=t1fin); 
x=A1*x;
h=exp(-a*T2).*(T2>=t2ini).*(T2<=t2fin);
ancho=T2(Lh)-T2(1);
Eje_t=linspace(-ancho+T1(1),T1(Lx)+ancho,Lx+Lh+Lh+1);
Eje_tfinal=linspace(T2(1)+T1(1),T1(Lx)+T2(Lh),Lx+Lh+1+1);
%--------------------Desarrollo de la Convolucion----------------
            for tc=0:Lx+Lh-1 %Longitud del resultado de la convolución = Lx+Lh-1

            %--------------- Gráfica de x(T)------------------
            x_T=[zeros(1,Lh) x zeros(1,Lh+1)];
            axes(handles.axes1)
            plot(Eje_t,x_T,'b');
            title('x(T)')
            xlabel('T')
            set(handles.axes1,'XMinorTick','on')
            grid;
            pause(0.0000001);
            %--------------- Gráfica de h(t-T) -----------------
            h_t_menos_T=[zeros(1,tc+1) h(Lh:-1:1) zeros(1,Lx+Lh-tc)];
            axes(handles.axes3)
            plot(Eje_t,h_t_menos_T,'r');
            title('h(t-T)')
            xlabel('T')
            set(handles.axes3,'XMinorTick','on')
            grid; 
            pause(0.0000001);
            %--------------- Gráfica de x(T)h[t-T] -----------------   
            axes(handles.axes2)
            plot(Eje_t,x_T.*h_t_menos_T,'y');
            title('x(t)*h(t-T)')
            xlabel('T')
            set(handles.axes3,'XMinorTick','on')
            grid;

            %--------------- Gráfica de y(t) --------------
            y_t(tc+1)=sum(x_T.*h_t_menos_T);
            axes(handles.axes4)
            plot(Eje_tfinal,[0 y_t zeros(1,Lx+Lh-tc)]*0.01,'g');
            title('y(t)')
            xlabel('t')
            set(handles.axes4,'XMinorTick','on')
            grid;
            pause(0.0000001);
            end




% --- Executes on button press in rectangu.
function rectangu_Callback(hObject, eventdata, handles)
% hObject    handle to rectangu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t1ini=str2double(get(handles.t1in,'string'));
t1fin=str2double(get(handles.t1fin,'string'));
A1=str2double(get(handles.A_1,'string'));
t2ini=str2double(get(handles.t2in,'string'));
t2fin=str2double(get(handles.t2fin,'string'));
A2=str2double(get(handles.A_2,'string'));
T1=t1ini:0.01:t1fin;
T2=t2ini:0.01:t2fin;
Lx=length(T1);
Lh=length(T2);
x=ones (size(T1)).*(T1>=t1ini).*(T1<=t1fin); 
x=A1*x;
h=ones(size(T2)).*(T2>=t2ini).*(T2<=t2fin);
h=A2*h;
ancho=T2(Lh)-T2(1);
Eje_t=linspace(-ancho+T1(1),T1(Lx)+ancho,Lx+Lh+Lh+1);
Eje_tfinal=linspace(T2(1)+T1(1),T1(Lx)+T2(Lh),Lx+Lh+1+1);
%--------------------Desarrollo de la Convolucion----------------
            for tc=0:Lx+Lh-1 %Longitud del resultado de la convolución = Lx+Lh-1

            %--------------- Gráfica de x(T)------------------
            x_T=[zeros(1,Lh) x zeros(1,Lh+1)];
            axes(handles.axes1)
            plot(Eje_t,x_T,'b');
            title('x(T)')
            xlabel('T')
            set(handles.axes1,'XMinorTick','on')
            grid;
            pause(0.0000001);
            %--------------- Gráfica de h(t-T) -----------------
            h_t_menos_T=[zeros(1,tc+1) h(Lh:-1:1) zeros(1,Lx+Lh-tc)];
            axes(handles.axes3)
            plot(Eje_t,h_t_menos_T,'r');
            title('h(t-T)')
            xlabel('T')
            set(handles.axes3,'XMinorTick','on')
            grid; 
            pause(0.0000001);
            %--------------- Gráfica de x(T)h[t-T] -----------------   
            axes(handles.axes2)
            plot(Eje_t,x_T.*h_t_menos_T,'y');
            title('x(t)*h(t-T)')
            xlabel('T')
            set(handles.axes3,'XMinorTick','on')
            grid;

            %--------------- Gráfica de y(t) --------------
            y_t(tc+1)=sum(x_T.*h_t_menos_T);
            axes(handles.axes4)
            plot(Eje_tfinal,[0 y_t zeros(1,Lx+Lh-tc)]*0.01,'g');
            title('y(t)')
            xlabel('t')
            set(handles.axes4,'XMinorTick','on')
            grid;
            pause(0.0000001);
            end




function A_1_Callback(hObject, eventdata, handles)
% hObject    handle to A_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A_1 as text
%        str2double(get(hObject,'String')) returns contents of A_1 as a double


% --- Executes during object creation, after setting all properties.
function A_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t1fin_Callback(hObject, eventdata, handles)
% hObject    handle to t1fin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t1fin as text
%        str2double(get(hObject,'String')) returns contents of t1fin as a double


% --- Executes during object creation, after setting all properties.
function t1fin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1fin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function A_2_Callback(hObject, eventdata, handles)
% hObject    handle to A_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A_2 as text
%        str2double(get(hObject,'String')) returns contents of A_2 as a double


% --- Executes during object creation, after setting all properties.
function A_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t2in_Callback(hObject, eventdata, handles)
% hObject    handle to t2in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t2in as text
%        str2double(get(hObject,'String')) returns contents of t2in as a double


% --- Executes during object creation, after setting all properties.
function t2in_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t2fin_Callback(hObject, eventdata, handles)
% hObject    handle to t2fin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t2fin as text
%        str2double(get(hObject,'String')) returns contents of t2fin as a double


% --- Executes during object creation, after setting all properties.
function t2fin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t2fin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function arg_Callback(hObject, eventdata, handles)
% hObject    handle to arg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of arg as text
%        str2double(get(hObject,'String')) returns contents of arg as a double


% --- Executes during object creation, after setting all properties.
function arg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t1in_Callback(hObject, eventdata, handles)
% hObject    handle to t1in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t1in as text
%        str2double(get(hObject,'String')) returns contents of t1in as a double


% --- Executes during object creation, after setting all properties.
function t1in_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t1in (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


