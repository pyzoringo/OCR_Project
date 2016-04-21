function varargout = GUItest(varargin)
% GUITEST MATLAB code for GUItest.fig
%      GUITEST, by itself, creates a new GUITEST or raises the existing
%      singleton*.
%
%      H = GUITEST returns the handle to a new GUITEST or the handle to
%      the existing singleton*.
%
%      GUITEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUITEST.M with the given input arguments.
%
%      GUITEST('Property','Value',...) creates a new GUITEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUItest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUItest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUItest

% Last Modified by GUIDE v2.5 15-Apr-2016 00:28:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUItest_OpeningFcn, ...
                   'gui_OutputFcn',  @GUItest_OutputFcn, ...
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


% --- Executes just before GUItest is made visible.
function GUItest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUItest (see VARARGIN)

handles.upLeft = findobj('Tag','upLeft');       
handles.upRight = findobj('Tag','upRight');     
handles.midLeft = findobj('Tag','midLeft');     
handles.midRight = findobj('Tag','midRight');   
handles.botLeft = findobj('Tag','botLeft');     
handles.botRight = findobj('Tag','botRight');   


% Choose default command line output for GUItest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUItest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUItest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in getFile.
function getFile_Callback(hObject, eventdata, handles)
% hObject    handle to getFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[imgName, pathName] = uigetfile({'*.jpg'}, 'Select an image');
filename = strcat(pathName, imgName);
img = imread(filename);
imgDisplay = uipanel(handles.patientProfile);
subHandle = subplot(1,1,1,'Parent',imgDisplay);
subPosition = [0,0,1,1];
set(subHandle, 'Position', subPosition);
imshow(img);
numbersImg = extractNumFrom(filename);
numsdisplay = uipanel(handles.numbersDisplay);
for i = 1:6
    subplot(3,2,i, 'Parent', numsdisplay); 
    imshow(numbersImg(:,:,i),[]);
end
handles.image = img;

uistack(handles.upLeft,'top');
uistack(handles.upRight,'top');
uistack(handles.midLeft,'top');
uistack(handles.midRight,'top');
uistack(handles.botLeft,'top');
uistack(handles.botRight,'top');
guidata(hObject,handles);



% --- Executes on button press in process.
function process_Callback(hObject, eventdata, handles)
% hObject    handle to process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% img = findobj('Tag','getFile');
result = sudokuImg(handles.image);
ulcheck = get(handles.upLeft, 'Value');
urcheck = get(handles.upRight, 'Value');
mlcheck = get(handles.midLeft, 'Value');
mrcheck = get(handles.midRight, 'Value');
blcheck = get(handles.botLeft, 'Value');
brcheck = get(handles.botRight, 'Value');
checkbox = [ulcheck, urcheck;
                    mlcheck, mrcheck;
                    blcheck, brcheck];
handles.result = result .* checkbox;
resultCell = cell(3,2);
str = '';
for row = 1:3
    for col = 1:2
        if checkbox(row,col) == 0
            resultCell{row,col} = 'nil';
            str = [str,' ', 'nil'];
        else
            resultCell{row,col} = result(row,col);
            str = [str,' ', num2str(result(row,col))];
        end
    end
    str = [str, char(10)];
end
set(handles.resultNumber, 'String',str);
guidata(hObject,handles);
                
