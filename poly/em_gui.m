function varargout = em_gui(varargin)
% EM_GUI M-file for em_gui.fig
%      EM_GUI, by itself, creates a new EM_GUI or raises the existing
%      singleton*.
%
%      H = EM_GUI returns the handle to a new EM_GUI or the handle to
%      the existing singleton*.
%
%      EM_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EM_GUI.M with the given input arguments.
%
%      EM_GUI('Property','Value',...) creates a new EM_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before em_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to em_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help em_gui

% Last Modified by GUIDE v2.5 13-May-2005 20:10:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @em_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @em_gui_OutputFcn, ...
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


% --- Executes just before em_gui is made visible.
function em_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to em_gui (see VARARGIN)

% Choose default command line output for em_gui
global Fs M midi_note A C S R Q H

handles.output = hObject;
handles.i = 0;
handles.audiosamples = 0;
handles.D = 8;
handles.sampling_rate = Fs;
handles.T = 100;
handles.ML = 0;
handles.midi_note = midi_note;
handles.note = 1;
handles.converged = false;

handles.A = A{1,1};
handles.Q = Q(1:2*H,1:2*H);
handles.S = S(1:2*H,1:2*H);
handles.C = C(1:2*H);
handles.R = R;

set(handles.ax1,'XLim',[1 handles.T]);
set(handles.ax1,'YLim',[-1 1]);
set(handles.i_text,'String',num2str(0));
set(handles.pot_text,'String',num2str(0));
set(handles.T_edit,'String', num2str(handles.T));
set(handles.note_popup,'String',{midi_note.name});
set(handles.filename_edit,'String','C:\Research\Audio\A_string.wav');

%show current system params
set(handles.A_text,'String',num2str(handles.A));
set(handles.Q_text,'String',num2str(handles.Q));
set(handles.C_text,'String',num2str(handles.C));
set(handles.R_text,'String',num2str(handles.R));
set(handles.S_text,'String',num2str(handles.S));

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = em_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in step_button.
function step_button_Callback(hObject, eventdata, handles)
% hObject    handle to step_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.i = handles.i+1;
% [handles.cc handles.converged] = viterbi_chord_itr( ...
%     handles.cc, handles.audiosamples,handles.T);
lt = get(handles.pot_text,'String');
set(handles.pot_text,'String', ...
    strvcat(lt,num2str(handles.ML)));

lt = get(handles.i_text,'String');
if handles.converged
    set(handles.i_text,'String', ...
        strvcat(lt,['*']));
else
    set(handles.i_text,'String', ...
        strvcat(lt,['i=' num2str(handles.i)]));
end
guidata(hObject, handles);

% --- Executes on button press in finish_button.
function finish_button_Callback(hObject, eventdata, handles)
% hObject    handle to finish_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for k=(handles.i:handles.max_itr)
    handles.i = handles.i+1;
%     [handles.delta handles.MAP] = ...
%         viterbi_mono_step(handles.delta,handles.audiosamples,...
%         handles.i, true, false);
end

function filename_edit_Callback(hObject, eventdata, handles)
% hObject    handle to filename_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename_edit as text
%        str2double(get(hObject,'String')) returns contents of
%        filename_edit as a double

% --- Executes during object creation, after setting all properties.
function filename_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_button.
function load_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filename = get(handles.filename_edit,'String');
[Y FS NBITS] = wavread(filename);

t_y = down_sample(Y,handles.D);
handles.audiosamples = t_y(1:handles.T);
handles.sampling_rate = FS / handles.D;
set(handles.FS_text, 'String', num2str(handles.sampling_rate));
set(handles.ax1,'XLim',[0 handles.T]);
set(handles.ax1,'YLim',[-1 1]);
axes(handles.ax1);
plot(handles.ax1, handles.audiosamples);
title('Training Data');

guidata(hObject, handles);

function T_edit_Callback(hObject, eventdata, handles)
% hObject    handle to T_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_edit as text
%        str2double(get(hObject,'String')) returns contents of T_edit as a double
handles.T = str2double(get(hObject,'Value'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function T_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function D_edit_Callback(hObject, eventdata, handles)
% hObject    handle to D_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of D_edit as text
%        str2double(get(hObject,'String')) returns contents of D_edit as a double
handles.D = str2double(get(hObject,'Value'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function D_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to D_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function em_gui_CreateFcn(hObject, eventdata, handles)
% hObject    handle to em_gui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in note_popup.
function note_popup_Callback(hObject, eventdata, handles)
% hObject    handle to note_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns note_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from note_popup
handles.note = str2double(get(hObject,'Value'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function note_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to note_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


