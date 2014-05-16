function varargout = vidpointan(varargin)
%VIDPOINTAN video point annotation
%   Example application for mmplayer class, covering its most important
%   features.
%
%   requires Image Processing Toolbox (impixel-method)!
%
%   USAGE:
%       simply call VIDPOINTAN without any parameters.

% Author: Robert Walter

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vidpointan_OpeningFcn, ...
                   'gui_OutputFcn',  @vidpointan_OutputFcn, ...
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


% --- Executes just before vidpointan is made visible.
function vidpointan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vidpointan (see VARARGIN)

% Choose default command line output for vidpointan
handles.output = hObject;

% Disable Controls at the Beginning
handles = disableControls(handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vidpointan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vidpointan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pbopen.
function pbopen_Callback(hObject, eventdata, handles)
% initialization
[file,path] = uigetfile('*.*','Select Video File');
if file
    obj = mmreader( [path,file] ); % mmreader object
    init(hObject, obj, handles);
end


% --- Executes on button press in pbclose.
function pbclose_Callback(hObject, eventdata, handles)
delete(handles.player); % call player deconstructor
handles = disableControls(handles);
guidata(hObject, handles);


% --- Executes on button press in pbprev.
function pbprev_Callback(hObject, eventdata, handles)
% junp to previous frame of interest
idx = find( handles.foi < handles.player.currentFrameIndex);
if ~isempty(idx)
    foiidx = idx(end);
	handles.player.jump( handles.foi(foiidx) );
end

% --- Executes on button press in pbnext.
function pbnext_Callback(hObject, eventdata, handles)
% junp to next frame of interest
idx = find( handles.foi > handles.player.currentFrameIndex);
if ~isempty(idx)
    foiidx = idx(1);
	handles.player.jump( handles.foi(foiidx) );
end

% --- Executes on button press in pbmark.
function pbmark_Callback(hObject, eventdata, handles)
% annotate points
foiidx = find(handles.foi == handles.player.currentFrameIndex, 1);
if ~isempty(foiidx) % current frame is a frame of interest
    h = figure;
    [c,r,P] = impixel(handles.player.currentFrame); % current video frame is used
    handles.points{foiidx} = [c,r];
    close(h);
    guidata(hObject,handles);
    update(hObject);
end

% --- Executes on button press in pbsave.
function pbsave_Callback(hObject, eventdata, handles)
points = handles.points;
framesOfInterest = handles.foi;
videoName = get(handles.obj,'Name');
videoPath = get(handles.obj,'Path');
[file,path] = uiputfile('*.mat','Save Annotated Points As');
if file
    save([path,file], 'points', 'framesOfInterest', 'videoName', 'videoPath');
end

% -------------------------------------------------------------------------

% initialization
function init(hObject, mmreaderobj, handles)
handles.obj = mmreaderobj;
handles.player = mmplayer(handles.obj);  % mmplayer object
addlistener(handles.player,'refreshed',@(src,event)update(hObject)); % update when player refreshes
handles.foi = uint32((1:10)/10 * get(handles.obj,'NumberOfFrames'));  % frames of interest (here: random)
handles.points = cell(numel(handles.foi),1); % annotated points
handles = enableControls(handles); % enabled controls after initialization
guidata(hObject, handles);
update(hObject); % update controls / annotated points in player window

% updates controls and displays annotated points in video player
function update(hObject)
handles = guidata(hObject);

handles.player.axesClear(); % remove old points every time
foiidx = find(handles.foi == handles.player.currentFrameIndex, 1);
if ~isempty(foiidx) % current frame is a frame of interest
    % enable annotation button
    set(handles.pbmark,'Enable','on');
    set(handles.tfoi,'String',sprintf('%d/%d', [foiidx, numel(handles.foi)]));

    % draw annotated points in video player
    cr = handles.points{foiidx};
    if ~isempty(cr) % user annotated points for this frame
        scatter(handles.player.axesHandle,cr(:,1),cr(:,2),'red','filled');
    end
else % current frame is NOT a frame of interest
    % disable annotation button
    set(handles.pbmark,'Enable','off');
    set(handles.tfoi,'String',sprintf('-/%d', [numel(handles.foi)]));
end

function handles = enableControls(handles)
set(handles.pbclose,'Enable','on');
set(handles.pbnext,'Enable','on');
set(handles.pbprev,'Enable','on');
set(handles.pbsave,'Enable','on');

function handles = disableControls(handles)
set(handles.pbclose, 'Enable','off');
set(handles.pbnext, 'Enable','off');
set(handles.pbprev, 'Enable','off');
set(handles.pbmark, 'Enable','off');
set(handles.pbsave,'Enable','off');
