function varargout = AHCVideoAnalysis(varargin)
% AHCVIDEOANALYSIS M-file for AHCVideoAnalysis.fig
%      AHCVIDEOANALYSIS, by itself, creates a new AHCVIDEOANALYSIS or raises the existing
%      singleton*.
%
%      H = AHCVIDEOANALYSIS returns the handle to a new AHCVIDEOANALYSIS or the handle to
%      the existing singleton*.
%
%      AHCVIDEOANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AHCVIDEOANALYSIS.M with the given input arguments.
%
%      AHCVIDEOANALYSIS('Property','Value',...) creates a new AHCVIDEOANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AHCVideoAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AHCVideoAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AHCVideoAnalysis

% Last Modified by GUIDE v2.5 16-May-2014 11:10:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @AHCVideoAnalysis_OpeningFcn, ...
    'gui_OutputFcn',  @AHCVideoAnalysis_OutputFcn, ...
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

% --- Executes just before AHCVideoAnalysis is made visible.
function AHCVideoAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AHCVideoAnalysis (see VARARGIN)


% get the name of the rat and the directory for the struct files
structfiledir='E:\Risa\Dropbox\Structs';

% structfiledir=uigetdir(matlabroot,'monkeypoops');
ratfilenames=dir([structfiledir filesep]);
rats={'Please select a rat','---'};
nrats=0;
for i=1:length(ratfilenames)
    if length(ratfilenames(i).name)>4 && strcmp(ratfilenames(i).name(end-2:end),'mat')
        nrats=nrats+1;
        rats{1,nrats+2}=ratfilenames(i).name(1:end-4);
    end
end

% get the name of the experiments and the directory of the data files
datafiledir='X:\RISAKAWAI3';
% datafiledir='\\ANNAPURNA\RatControlOp\RAYMONDKO3\Data';
% datafiledir=uigetdir(matlabroot,'monkeypoopsalot');
exptfilenames=dir([datafiledir filesep]);
expts=[];
nexpts=0;
for i=1:length(exptfilenames)
    if ~isempty(str2num(exptfilenames(i).name))
        nexpts=nexpts+1;
        expts(1,nexpts)=str2num(exptfilenames(i).name);
    end
end

pos=get(handles.uipanel6,'position');
handles.sliderx0=pos(1);
handles.sliderwidth=pos(3);

% add the path to all AHC utilities
p=genpath(cd);
addpath(p);

% initialize rat names in selectRat
set(handles.selectRat, 'String', rats,'Value',1);
% initialize experiment IDs in selectExpt
set(handles.selectExpt, 'String', '---','Value',1);
% initialize tables
dat0 =  {false, [], [], [], [], [],[]};
columnformat = {'logical', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'};
columneditable = [true false false false false false false];
set(handles.uitable1,'Data',dat0,'ColumnFormat', columnformat,'ColumnEditable', columneditable)
set(handles.uitable2,'Data',dat0,'ColumnFormat', columnformat,'ColumnEditable', columneditable)

% update handles data
handles.structfiledir=structfiledir;
handles.datafiledir=datafiledir;
handles.rats=rats;
handles.expts=expts;
handles.popupdefaults=[1,1];
handles.playback=false;
handles.queue=[];
handles.WSqueue=[];
handles.WStrial=[];
handles.WSmovieFrames=[];
handles.WSa=[];
handles.speed=1;
handles.chTraj=0;
handles.chROI=0;
handles.WSsliderlisten=[];
handles.chData=[];

handles.taps=0;
handles.rewards=6;
handles.minDelay=0;
handles.maxDelay=Inf;

% addlistener for continous slider call back
set(handles.slider1,'Min',0,'Max',1,'Value',0)
addlistener(handles.slider1,'Value','PostSet',@(source,eventdata)slider1_Callback(hObject,eventdata, handles));

% add a buttondown callback to workspace browser queue
handles.panelaxes=axes('Position',[0 0 1 1],'Color','k','Parent',handles.uipanel6,'Tag','panelaxes');
cla(handles.panelaxes)
set(handles.panelaxes,'XTick',[],'YTick',[]);
set(handles.panelaxes,'ButtonDownFcn',@moviebrowser_Callback);

% clear axes in workspace browser
set(handles.axes5,'XTick',[],'YTick',[],'Box','on')
cla(handles.axes5)
% the set the hidden axes in the back
set(handles.axes6,'XTick',[],'YTick',[]);
set(handles.axes6);
% initialize the channel numbers
set(handles.editChTraj,'String',0);
set(handles.editChROI,'String',0);

% initialize number of taps in popupmenu4
set(handles.popupmenu4, 'String', {'# Taps','---','All','1','2','2+', '3','>=4'},'Value',1);
% initialize experiment IDs in selectExpt
set(handles.popupmenu5, 'String', {'Reward','---','None','1','2','3','4','5','0~5'},'Value',1);
% intialize minDelay in edit 1
set(handles.edit1,'String',0)
% intialize maxDelay in edit 2
set(handles.edit2,'String',Inf)
% intialize trials detected in edit4
set(handles.edit4,'String',0)
% intialize random election box in edit5
set(handles.edit5,'String',0)

% initialze uitable5 for tracking channels
set(handles.uitable5,'Data',{false,[],[],[],[]},'ColumnEditable',[false,false,false,false,false])
% initialize trajTrack
set(handles.trajTrack,'String','---','Value',1)
% initialize ROIselect
set(handles.ROIselect,'String','---','Value',1)

% disable the panel for tracking
set(handles.uitable5,'Enable','off')
set(handles.trajTrack,'Enable','off')
set(handles.ROIselect,'Enable','off')
set(handles.updateROI,'Enable','off')
set(handles.trackSelected,'Enable','off')
set(handles.save,'Enable','off')
set(handles.endtracking,'Enable','off')

% trajectory plotting panel
plotdat={false,[],[],[]};
set(handles.plotTable,'Data',plotdat)

% Choose default command line output for AHCVideoAnalysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using AHCVideoAnalysis.
if strcmp(get(hObject,'Visible'),'off')
    %     axis(handles.axes1,'normal')
    %     set(handles.axes1,'XTickLabel','','YTickLabel','','TickLength',[0 0])
    %     axis(handles.axes2,'normal')
    %     set(handles.axes2,'XTickLabel','','YTickLabel','','TickLength',[0 0])
    %     text('Parent',handles.axes1,'Position',[.35 .5],'String','Your Rat Here!!!')
end

% UIWAIT makes AHCVideoAnalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AHCVideoAnalysis_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in loadRat.
function loadRat_Callback(hObject, eventdata, handles)
% hObject    handle to loadRat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

popup1_sel_index = get(handles.selectRat, 'Value');
if popup1_sel_index>=3
    handles.popupdefaults(1)=popup1_sel_index;
    % temporarily disable selectExpt and popupmenu3
    set(handles.selectExpt, 'String', 'Loading new experiments...','Value',1,'Enable','off');
    pause(.1)
    % load the new experiments
    handles.selectedrat = handles.rats{popup1_sel_index};
    load([handles.structfiledir filesep handles.selectedrat '.mat']);
    handles.ratstruct=eval(handles.selectedrat);
    listedexpts={'Please select an experiment ID','---'};
    indxexpts=cell(1);
    nlisted=0;
    for i=1:length(handles.ratstruct)
        tempexpt=handles.ratstruct(i).exptID;
        if any(handles.expts==tempexpt)
            if~any(ismember(listedexpts,num2str(tempexpt)))
                nlisted=nlisted+1;
                listedexpts{1,nlisted+2}=num2str(tempexpt);
                indxexpts{nlisted}=i;
            else
                indxexpts{nlisted}=[indxexpts{nlisted} i];
            end
        end
    end
    handles.listedexpts=listedexpts;
    handles.indxexpts=indxexpts;
    set(handles.selectExpt, 'String', listedexpts,'Value',1,'Enable','on');
else
    warndlg('No rat selected!')
    set(handles.selectRat,'Value',handles.popupdefaults(1));
end

% update handles object
guidata(hObject, handles);

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
    ['Close ' get(handles.figure1,'Name') '...'],...
    'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in selectRat.
function selectRat_Callback(hObject, eventdata, handles)
% hObject    handle to selectRat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns selectRat contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectRat


% --- Executes during object creation, after setting all properties.
function selectRat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectRat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close('AHCVideoAnalysis')


% --- Executes on selection change in selectExpt.
function selectExpt_Callback(hObject, eventdata, handles)
% hObject    handle to selectExpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns selectExpt contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectExpt


% --- Executes during object creation, after setting all properties.
function selectExpt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectExpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadDay.
function loadDay_Callback(hObject, eventdata, handles)
% hObject    handle to loadDay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
popup2_sel_index = get(handles.selectExpt, 'Value');
if popup2_sel_index>=3
    handles.popupdefaults(2)=popup2_sel_index;
    handles.selectedexpt = handles.listedexpts{popup2_sel_index};
    pause(.1)
    
    % find all movie files under the selected experiment
    extension = '-0.mp4';
    directoryName = [handles.datafiledir filesep handles.selectedexpt filesep];
    directory = dir([directoryName '*.mp4']);
    
    fileNames = zeros(numel(directory), 1);
    for m = 1:numel(directory)
        fileNames(m) = str2num(directory(m).name(1:end-numel(extension)));
    end
    fileNames = sort(fileNames);
    handles.moviefiles=fileNames;
    
    % total number of trials
    ntrials=0;
    sessions={'Select a session','---'};
    for i=1:length(handles.ratstruct)
        if strcmp(num2str(handles.ratstruct(i).exptID),handles.selectedexpt)
            sessions=[sessions handles.ratstruct(i).startTime];
            for j=1:handles.ratstruct(i).numOfTrials
                ntrials=ntrials+1;
                switch length(handles.ratstruct(i).intertapIntervals{j})
                    case 0
                        interval1=0;
                        interval2=0;
                    case 1
                        interval1=handles.ratstruct(i).intertapIntervals{j}(1);
                        interval2=0;
                    case 2
                        interval1=handles.ratstruct(i).intertapIntervals{j}(1);
                        interval2=handles.ratstruct(i).intertapIntervals{j}(2);
                    otherwise
                        interval1=handles.ratstruct(i).intertapIntervals{j}(1);
                        interval2=handles.ratstruct(i).intertapIntervals{j}(2);
                end
                
                dat(ntrials,:)={false,...
                    ntrials,...
                    handles.ratstruct(i).exptID,...
                    handles.ratstruct(i).numOfTaps(j),...
                    interval1,...
                    interval2,...
                    handles.ratstruct(i).rewards(j),...
                    handles.ratstruct(i).triggerSampleNum(j,:),...
                    handles.ratstruct(i).tapTimes{j}(1),...
                    cell2mat(handles.ratstruct(i).startTime)};
            end
        end
    end
    
    % display trial statistics in table1
    set(handles.uitable1,'Data',dat(:,1:7))
    set(handles.edit4,'String',size(dat,1))
    set(handles.selectSession,'String',sessions,'Value',1)
    % store all trial info under current experiment
    handles.allData=dat;
    % save dat in output folder
    if ~exist(['Output' filesep handles.selectedrat filesep handles.selectedexpt filesep],'dir')
        mkdir(['Output' filesep handles.selectedrat filesep handles.selectedexpt filesep])
    end
    save(['Output' filesep handles.selectedrat filesep handles.selectedexpt filesep 'allData.mat'],'dat')
else
    warndlg('No experiment selected!')
    set(handles.selectExpt,'Value',handles.popupdefaults(2));
end

% update handles object
guidata(hObject, handles);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dat = get(handles.uitable1, 'data');
newtrials=cell2mat(dat(find(cell2mat(dat(:,1))==true),2)).';
handles.queue=unique([handles.queue newtrials]);
if sum(cell2mat(dat(:,1)))>0
    set(handles.uitable2,'Data',handles.allData(handles.queue,1:7));
else
    warndlg('No trial selected!')
end

% update handles object
guidata(hObject, handles);

% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% taps=get(handles.popupmenu4,'Value')-3;
taps = get(handles.popupmenu4, 'String');
rewards=get(handles.popupmenu5,'Value')-3;
minDelay=str2num(get(handles.edit1,'String'));
maxDelay=str2num(get(handles.edit2,'String'));
sessionIndx=get(handles.selectSession,'Value');
sessions=get(handles.selectSession,'String');

if isempty(minDelay) || isempty(maxDelay) ||minDelay>=maxDelay
    warndlg('Please check your selections!')
else
    dat=handles.allData;
    
    % get logical indx of selected trials based on # taps
    switch taps
        case '0'
            itaps=1:size(dat,1);
        case '2+'
            itaps=find(cell2mat(dat(:,4))>1);
        case '4+'
            itaps=find(cell2mat(dat(:,4))>1);
        otherwise
            itaps=find(cell2mat(dat(:,4))==num2str(taps));
    end
%     if taps<=0
%         itaps=1:size(dat,1);
%     elseif taps>0 && taps<4
%         itaps=find(cell2mat(dat(:,4))==taps);
%     else
%         itaps=find(cell2mat(dat(:,4))>=taps);
%     end
    
    % get logical indx of selected trials based on rewards
    if rewards>=0 && rewards<=5
        irewards=find(cell2mat(dat(:,7))==rewards);
    else
        irewards=1:size(dat,1);
    end
    
    if sessionIndx<3
        isession=1:size(dat,1);
    else
        isession=find(strcmp(dat(:,10),sessions(sessionIndx,1)));
    end
    
    % get logical indx of selected trials based on interval duration
    iminDelay=find(cell2mat(dat(:,5))>= minDelay);
    imaxDelay=find(cell2mat(dat(:,5))<= maxDelay);
    
    % update the data
    idat=mintersect(itaps,irewards,iminDelay,imaxDelay,isession);
    if any(idat)
        set(handles.uitable1,'Data',dat(idat,1:7))
        set(handles.edit4,'String',sum(idat>0))
        handles.taps=taps;
        handles.rewards=rewards;
        handles.minDelay=minDelay;
        handles.maxDelay=maxDelay;
    else
        warndlg('No trial meets specified criterion!')
    end
    
end

% update handles object
guidata(hObject, handles);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get trial statistics in table1
dat=get(handles.uitable1,'data');
dat(:,1)={false};
% redisplay trial statistics in table1
set(handles.uitable1,'Data',dat)

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get trial statistics in table1
dat=get(handles.uitable1,'data');
dat(:,1)={true};
% redisplay trial statistics in table1
set(handles.uitable1,'Data',dat)




function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

nrandtrial=str2num(get(handles.edit5,'String'));
dat=get(handles.uitable1,'data');
ntrials=size(dat,1);

if nrandtrial<=ntrials && nrandtrial>0
    randindx=randperm(ntrials);
    randindx=randindx(1:nrandtrial);
    dat(:,1)={false};
    dat(randindx,1)={true};
    % redisplay trial statistics in table1
    set(handles.uitable1,'Data',dat)
else
    warndlg(['There are only ' num2str(ntrials) ' trials to select from!'])
end

% update handles object
guidata(hObject, handles);

function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dat = get(handles.uitable2, 'data');
removetrials=cell2mat(dat(find(cell2mat(dat(:,1))==true),2)).';
handles.queue=setdiff(handles.queue,removetrials);
if sum(cell2mat(dat(:,1)))>0
    set(handles.uitable2,'Data',handles.allData(handles.queue,1:7));
else
    warndlg('No trial selected!')
end

% update handles object
guidata(hObject, handles);

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get trial statistics in table1
dat=get(handles.uitable2,'data');
dat(:,1)={false};
% redisplay trial statistics in table1
set(handles.uitable2,'Data',dat)

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get trial statistics in table1
dat=get(handles.uitable2,'data');
dat(:,1)={true};
% redisplay trial statistics in table1
set(handles.uitable2,'Data',dat)

% --- Executes on button press in importWS.
function importWS_Callback(hObject, eventdata, handles)
% hObject    handle to importWS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if numel(handles.queue)
    if ismember(handles.selectedrat,{'Stuart','Anna'}) % check if it's Tim's rat
        delete(findobj(handles.uipanel6,'type','axes','-not','Tag','panelaxes'))
        cla(handles.axes5)
        handles.WSqueue=handles.queue;
        hwait=waitbar(0,'Loading movies to workspace browser...');
        steps=numel(handles.queue);
        pos=get(handles.uipanel6,'position');
        dat=handles.allData;
        exptID=str2num(handles.selectedexpt); %#ok<ST2NM>
        
        movieFrames0=getFrames(handles.ratstruct,dat{1,8}(1),dat{1,8}(2),[1 1]);
        wth=2*movieFrames0.width/movieFrames0.height;
        width=pos(4)*wth*steps+pos(4)/5*(steps+1);
        height=pos(4);
        set(handles.uipanel6,'position',[pos(1) pos(2) width height]);
        handles.wth=wth; handles.width=width; handles.height=height;
        
        for step=1:steps
            % using Risa's getFrame function to load videos
            trial=handles.queue(step);
            movieFrames=getFrames(handles.ratstruct,dat{trial,8}(1),dat{trial,8}(2),[50 100]);
            axispos=[((pos(4)*wth+pos(4)/5)*(step-1)+pos(4)/5)/width 0 wth*height/width 1];
            handles.WSa(step)=axes('units','norm','outerposition',axispos,'position',axispos,'parent',handles.uipanel6);
            imagehandle=imshow(movieFrames.frames(1).cdata,'Parent',handles.WSa(step));
            text(movieFrames0.height*(1/10),movieFrames0.height*(9/10),['Trial:' num2str(trial)],'parent',handles.WSa(step),'Color','b','FontSize',12,'FontWeight','bold')
            set(imagehandle,'HitTest','off') % this allows mouse clicks in workspace browser to be recognized
            handles.movieFrames{step}=movieFrames;
            % move the slider
            set(handles.slider1,'Value',step/steps);
            % update waitbar
            figure(hwait)
            waitbar(step/steps)
        end
        % close waitbar
        close(hwait)
        
        % move the slider back
        for step=steps:-0.5:0
            % move the slider
            set(handles.slider1,'Value',(step/steps)^3);
            pause(.01)
        end
    else
        delete(findobj(handles.uipanel6,'type','axes','-not','Tag','panelaxes'))
        cla(handles.axes5)
        handles.WSqueue=handles.queue;
        hwait=waitbar(0,'Loading movies to workspace browser...');
        steps=numel(handles.queue);
        pos=get(handles.uipanel6,'position');
        dat=handles.allData;
        exptID=str2num(handles.selectedexpt); %#ok<ST2NM>
        
        movieFrames0=getMovie(exptID, cell2mat(dat(1,8)), cell2mat(dat(1,9)), 1, handles.moviefiles); %#ok<NASGU>
        wth=2*movieFrames0.width/movieFrames0.height;
        width=pos(4)*wth*steps+pos(4)/5*(steps+1);
        height=pos(4);
        set(handles.uipanel6,'position',[pos(1) pos(2) width height]);
        handles.wth=wth; handles.width=width; handles.height=height;
        
%         nframes=100;
        nframes=55;
        for step=1:steps
            % using Risa's getMovie function to load videos
            trial=handles.queue(step);
            movieFrames=getMovie(exptID, cell2mat(dat(trial,8)), cell2mat(dat(trial,9)), nframes, handles.moviefiles); %#ok<NASGU>
            axispos=[((pos(4)*wth+pos(4)/5)*(step-1)+pos(4)/5)/width 0 wth*height/width 1];
            handles.WSa(step)=axes('units','norm','outerposition',axispos,'position',axispos,'parent',handles.uipanel6);
            imagehandle=imshow(movieFrames.frames(1).cdata,'Parent',handles.WSa(step));
            text(movieFrames0.height*(1/10),movieFrames0.height*(9/10),['Trial:' num2str(trial)],'parent',handles.WSa(step),'Color','b','FontSize',12,'FontWeight','bold')
            set(imagehandle,'HitTest','off') % this allows mouse clicks in workspace browser to be recognized
            handles.movieFrames{step}=movieFrames;
            % move the slider
            set(handles.slider1,'Value',step/steps);
            % update waitbar
            figure(hwait)
            waitbar(step/steps)
        end
        % close waitbar
        close(hwait)
        
        % move the slider back
        for step=steps:-0.5:0
            % move the slider
            set(handles.slider1,'Value',(step/steps)^3);
            pause(.01)
        end
    end
else
    warndlg('The queue is empty!')
end

% update handles object
guidata(hObject, handles);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

pos=get(handles.uipanel6,'position');
val=get(handles.slider1,'value');
pos(1)=handles.sliderx0-val*(pos(3)-handles.sliderwidth);
set(handles.uipanel6,'position',pos);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function moviebrowser_Callback(hObject,eventdata,handles)

handles=guidata(hObject);

nvids=length(handles.WSqueue);
if nvids>0
    pos=get(hObject,'CurrentPoint');
    wth=handles.wth; width=handles.width; height=handles.height;
    for ivid=1:nvids
        if pos(1,1)>=((height*wth+height/5)*(ivid-1)+height/5)/width && pos(1,1)<=((height*wth+height/5)*(ivid-1)+height/5)/width+wth*height/width
            handles.WStrial=handles.WSqueue(ivid);
            handles.WSmovieFrames=handles.movieFrames{ivid};
        end
    end
    % initialize the WSframe slider and add listener
    set(handles.WSframeslider,'Min',1,'Max',numel(handles.WSmovieFrames.frames),'Value',1);
    delete(handles.WSsliderlisten)
    handles.WSsliderlisten=addlistener(handles.WSframeslider,'Value','PostSet',@(source,eventdata)WSframeslider_Callback(hObject,eventdata, handles));
    % show the selected trial in WS
    imshow(handles.WSmovieFrames.frames(1).cdata,'Parent',handles.axes5)
    ylim=handles.WSmovieFrames.height;
    nframes=numel(handles.WSmovieFrames.frames);
    text(10,ylim-15,['Trial: ' num2str(handles.WStrial)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
    text(10,15,[ 'Frame: 1/' num2str(nframes)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
    
    % diable the panel for tracking
    set(handles.uitable5,'Enable','off')
    set(handles.trajTrack,'Enable','off')
    set(handles.ROIselect,'Enable','off')
    set(handles.trackSelected,'Enable','off')
    set(handles.updateROI,'Enable','off')
    set(handles.save,'Enable','off')
    set(handles.endtracking,'Enable','off')
end

% update handles object
guidata(hObject, handles);


% --- Executes on button press in Play.
function Play_Callback(hObject, eventdata, handles)
% hObject    handle to Play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.WSmovieFrames)
    nframes=numel(handles.WSmovieFrames.frames);
    ylim=handles.WSmovieFrames.height;
    speed=handles.speed;
    if speed==0
        warndlg('Please choose a non-zeros speed to start the video playback!')
    else
        % update handles in guidata
        handles.playback=true;
        guidata(hObject, handles);
        
        fps=speed*handles.WSmovieFrames.rate;
        i=1;
        while handles.playback
            % play the movies in loop
            if i>nframes
                i=1;
            end
            
            imshow(handles.WSmovieFrames.frames(i).cdata(:,:,1),'Parent',handles.axes5)
            text(10,ylim-15,['Trial: ' num2str(handles.WStrial)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
            text(10,15,[ 'Frame: ' num2str(i) '/' num2str(nframes)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
            set(handles.WSframeslider,'Value',i);
            pause(1/fps)
            i=i+1;
            handles=guidata(hObject);
        end
    end
else
    warndlg('There is no video in workspace!')
end


% --- Executes on slider movement.
function speed_Callback(hObject, eventdata, handles)
% hObject    handle to speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.speed=get(hObject,'Value');
set(handles.speededit,'String',[num2str(handles.speed,'%.1f') 'X'])

% update handles object
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.WSmovieFrames)
    % update handles object
    handles.playback=false;
    guidata(hObject, handles);
    nframes=numel(handles.WSmovieFrames.frames);
    ylim=handles.WSmovieFrames.height;
    
    % return to first frame
    imshow(handles.WSmovieFrames.frames(1).cdata,'Parent',handles.axes5)
    text(10,ylim-15,['Trial: ' num2str(handles.WStrial)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
    text(10,15,['Frame: 1/' num2str(nframes)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
    
    set(handles.WSframeslider,'Value',1)
else
    warndlg('There is no video in workplace!')
end

% --- Executes on slider movement.
function WSframeslider_Callback(hObject, eventdata, handles)
% hObject    handle to WSframeslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

if ~isempty(handles.WSmovieFrames)
    nframes=numel(handles.WSmovieFrames.frames);
    ylim=handles.WSmovieFrames.height;
    i=round(get(handles.WSframeslider,'Value'));
    
    imshow(handles.WSmovieFrames.frames(i).cdata,'Parent',handles.axes5)
    text(10,ylim-15,['Trial: ' num2str(handles.WStrial)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
    text(10,15,[ 'Frame: ' num2str(i) '/' num2str(nframes)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
end

% --- Executes during object creation, after setting all properties.
function WSframeslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WSframeslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function editChTraj_Callback(hObject, eventdata, handles)
% hObject    handle to editChTraj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editChTraj as text
%        str2double(get(hObject,'String')) returns contents of editChTraj
%        as a double

% --- Executes during object creation, after setting all properties.
function editChTraj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editChTraj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editChROI_Callback(hObject, eventdata, handles)
% hObject    handle to editChROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editChROI as text
%        str2double(get(hObject,'String')) returns contents of editChROI as
%        a double

% --- Executes during object creation, after setting all properties.

function editChROI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editChROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonStartTracking.
function pushbuttonStartTracking_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStartTracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% allow a maximum of 10 channels
maxCh=10;

% get the editbox inputs
chTraj=str2num(get(handles.editChTraj,'String'));
chROI=str2num(get(handles.editChROI,'String'));


% check for prohibited inputs
if ~isempty(handles.WStrial)
    % check existing tracking
    if exist(['Output' filesep handles.selectedrat filesep handles.selectedexpt filesep num2str(handles.WStrial) filesep 'chData.mat'])
        choice = questdlg('Use existing channel data?', ...
            'Previous tracking channels detected!', ...
            'Yes','No','Yes');
        % Handle response
        switch choice
            case 'Yes'
                load(['Output' filesep handles.selectedrat filesep handles.selectedexpt filesep num2str(handles.WStrial) filesep 'chData.mat'])
                handles.chData=chData;
                % enable the panel for tracking
                set(handles.uitable5,'Enable','on')
                set(handles.trajTrack,'Enable','on')
                set(handles.trackSelected,'Enable','on')
                set(handles.save,'Enable','on')
                set(handles.endtracking,'Enable','on')
                set(handles.ROIselect,'Enable','on')
                set(handles.updateROI,'Enable','on')
                set(handles.uitable5,'Data',chData(:,1:5))
                
                handles.chTraj=sum(strcmp(chData(:,4),'Trajectory'));
                handles.chROI=sum(strcmp(chData(:,4),'ROI'));
                handles.ROIcolor=hsv(chROI);
                
                % we disable further changes on the number of channels for Trajectories and
                % ROI once the tracking starts
                set(handles.editChTraj,'String',handles.chTraj,'Enable','off')
                set(handles.editChROI,'String',handles.chROI,'Enable','off')
                
                set(handles.trajTrack,'String',[{'Track trajectory','---'},num2cell(1:handles.chTraj)])
                set(handles.ROIselect,'String',[{'Select ROI','---'},num2cell(1:handles.chROI)])
                
            case 'No'
                if isempty(chTraj) || isempty(chROI)
                    set(handles.editChTraj,'String',0);
                    set(handles.editChROI,'String',0);
                    warndlg('Please enter numbers only!')
                elseif (chTraj>=1 && chTraj<=maxCh) && (chROI>=0 && chROI<=maxCh)
                    % enable the panel for tracking
                    set(handles.uitable5,'Enable','on')
                    set(handles.trajTrack,'Enable','on')
                    set(handles.ROIselect,'Enable','on')
                    set(handles.trackSelected,'Enable','on')
                    set(handles.save,'Enable','on')
                    set(handles.endtracking,'Enable','on')
                    set(handles.updateROI,'Enable','on')
                    
                    handles.chTraj=chTraj;
                    handles.chROI=chROI;
                    handles.ROIcolor=hsv(chROI);
                    % we disable further changes on the number of channels for Trajectories and
                    % ROI once the tracking starts
                    set(handles.editChTraj,'Enable','off')
                    set(handles.editChROI,'Enable','off')
                    % start the tracking protocol
                    chdat=cell(1,7);
                    for ch=1:chTraj
                        chdat(ch,1:6)={false,str2num(handles.selectedexpt),handles.WStrial,'Trajectory',ch,handles.allData(handles.WStrial,10)};
                    end
                    ROIw=100; ROIh=100;
                    xlim=handles.WSmovieFrames.width; ylim=handles.WSmovieFrames.height;
                    for ch=1:chROI
                        chdat(chTraj+ch,1:6)={false,str2num(handles.selectedexpt),handles.WStrial,'ROI',ch,handles.allData(handles.WStrial,10)};
                        handles.ROIpos(ch,1:4)=[(xlim-ROIw)/2 (ylim-ROIh)/2 ROIw ROIh];
                    end
                    set(handles.trajTrack,'String',[{'Track trajectory','---'},num2cell(1:chTraj)],'Value',1)
                    set(handles.ROIselect,'String',[{'Select ROI','---'},num2cell(1:chROI)],'Value',1)
                    set(handles.uitable5,'Data',chdat(:,1:5))
                    handles.chData=chdat;
                else
                    set(handles.editChTraj,'String',0);
                    set(handles.editChTraj,'String',0);
                    warndlg(['Please enter a number between 1 and ' num2str(maxCh) '!'])
                end
        end
    else
        if isempty(chTraj) || isempty(chROI)
            set(handles.editChTraj,'String',0);
            set(handles.editChROI,'String',0);
            warndlg('Please enter numbers only!')
        elseif (chTraj>=1 && chTraj<=maxCh) && (chROI>=0 && chROI<=maxCh)
            % enable the panel for tracking
            set(handles.uitable5,'Enable','on')
            set(handles.trajTrack,'Enable','on')
            set(handles.ROIselect,'Enable','on')
            set(handles.trackSelected,'Enable','on')
            set(handles.save,'Enable','on')
            set(handles.endtracking,'Enable','on')
            set(handles.updateROI,'Enable','on')
            
            handles.chTraj=chTraj;
            handles.chROI=chROI;
            handles.ROIcolor=hsv(chROI);
            % we disable further changes on the number of channels for Trajectories and
            % ROI once the tracking starts
            set(handles.editChTraj,'Enable','off')
            set(handles.editChROI,'Enable','off')
            % start the tracking protocol
            chdat=cell(1,7);
            for ch=1:chTraj
                chdat(ch,1:6)={false,str2num(handles.selectedexpt),handles.WStrial,'Trajectory',ch,handles.allData(handles.WStrial,10)};
            end
            ROIw=100; ROIh=100;
            xlim=handles.WSmovieFrames.width; ylim=handles.WSmovieFrames.height;
            for ch=1:chROI
                chdat(chTraj+ch,1:6)={false,str2num(handles.selectedexpt),handles.WStrial,'ROI',ch,handles.allData(handles.WStrial,10)};
                handles.ROIpos(ch,1:4)=[(xlim-ROIw)/2 (ylim-ROIh)/2 ROIw ROIh];
            end
            set(handles.trajTrack,'String',[{'Track trajectory','---'},num2cell(1:chTraj)],'Value',1)
            set(handles.ROIselect,'String',[{'Select ROI','---'},num2cell(1:chROI)],'Value',1)
            set(handles.uitable5,'Data',chdat(:,1:5))
            handles.chData=chdat;
        else
            set(handles.editChTraj,'String',0);
            set(handles.editChTraj,'String',0);
            warndlg(['Please enter a number between 1 and ' num2str(maxCh) '!'])
        end
    end
else
    warndlg('There is no video in workplace!')
end

% update handle object
guidata(hObject, handles);



function speededit_Callback(hObject, eventdata, handles)
% hObject    handle to speededit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of speededit as text
%        str2double(get(hObject,'String')) returns contents of speededit as a double


% --- Executes during object creation, after setting all properties.
function speededit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speededit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in trajTrack.
function trajTrack_Callback(hObject, eventdata, handles)
% hObject    handle to trajTrack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns trajTrack contents as cell array
%        contents{get(hObject,'Value')} returns selected item from trajTrack


% --- Executes during object creation, after setting all properties.
function trajTrack_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trajTrack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ROIselect.
function ROIselect_Callback(hObject, eventdata, handles)
% hObject    handle to ROIselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ROIselect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ROIselect

chROI=get(handles.ROIselect,'Value')-2;
if chROI>0
    if ~isfield(handles,'ROIh')
        handles.ROIh=imrect(handles.axes5,handles.ROIpos(chROI,:));
        setColor(handles.ROIh,handles.ROIcolor(chROI,:))
    else
        if ~isvalid(handles.ROIh)
            handles.ROIh=imrect(handles.axes5,handles.ROIpos(chROI,:));
            setColor(handles.ROIh,handles.ROIcolor(chROI,:))
        else
            if ~isequal(getColor(handles.ROIh),handles.ROIcolor(chROI))
                delete(handles.ROIh);
                handles.ROIh=imrect(handles.axes5,handles.ROIpos(chROI,:));
                setColor(handles.ROIh,handles.ROIcolor(chROI,:))
            end
        end
    end
else
    ylim=handles.WSmovieFrames.height;
    nframes=numel(handles.WSmovieFrames.frames);
    currentFrame=round(get(handles.WSframeslider,'Value'));
    imshow(handles.WSmovieFrames.frames(currentFrame).cdata(:,:,1),'Parent',handles.axes5)
    text(10,ylim-15,['Trial: ' num2str(handles.WStrial)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
    text(10,15,[ 'Frame: ' num2str(currentFrame) '/' num2str(nframes)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
end

% update handle object
guidata(hObject, handles)


% --- Executes during object creation, after setting all properties.
function ROIselect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ROIselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in trackSelected.
function trackSelected_Callback(hObject, eventdata, handles)
% hObject    handle to trackSelected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

chTraj=get(handles.trajTrack,'Value')-2;
if chTraj>0
    % disable the preview features first
    set(handles.Play,'Enable','off');
    set(handles.Stop,'Enable','off');
    set(handles.speededit,'Enable','off');
    set(handles.WSframeslider,'Enable','off');
    
    nframes=numel(handles.WSmovieFrames.frames);
    ylim=handles.WSmovieFrames.height;
    xtraj=zeros(nframes,1);ytraj=zeros(nframes,1);
    for i=1:nframes
        imshow(handles.WSmovieFrames.frames(i).cdata,'Parent',handles.axes5)
        hold on
        text(10,ylim-15,['Trial: ' num2str(handles.WStrial)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
        text(10,15,['Frame: ' num2str(i) '/' num2str(nframes)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
        text(10,40,['Ch: ' num2str(chTraj)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
        if i>1
            plot(xtraj(i-1,1),ytraj(i-1,1),'or','MarkerSize',6,'Parent',handles.axes5)
        elseif i>2
            plot(xtraj(i-2:i-1,1),ytraj(i-2:i-1,1),'-r','LineWidth',1.5,'Parent',handles.axes5);
            plot(xtraj(i-1,1),ytraj(i-1,1),'or','MarkerSize',6,'Parent',handles.axes5)
        end
        [xtraj(i,1) ytraj(i,1)]=myginput(1,'circle');
        hold off
    end
    imshow(handles.WSmovieFrames.frames(end).cdata,'Parent',handles.axes5)
    text(10,ylim-15,['Trial: ' num2str(handles.WStrial)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
    text(10,40,['Ch: ' num2str(chTraj)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
    text(10,15,['Frame: ' num2str(nframes) '/' num2str(nframes)],'Color','b','FontSize',12,'FontWeight','bold','Parent',handles.axes5)
    
    % inform the user that current channel is done
    msgh=msgbox(['Finshed tracking channel ' num2str(chTraj) ' trajectory.']);
    pause(.6)
    if isempty(msgh)
        close(msgh)
    end
    
    dat=get(handles.uitable5,'Data');
    dat(chTraj,1)={true};
    set(handles.uitable5,'Data',dat)
    handles.chData(chTraj,7)={[xtraj ytraj]};
    handles.chData(chTraj,1)={true};
    
    % enable the preview features
    set(handles.Play,'Enable','on');
    set(handles.Stop,'Enable','on');
    set(handles.speededit,'Enable','on');
    set(handles.WSframeslider,'Enable','on');
else
    warndlg('No channel selected!')
end

% update handle object
guidata(hObject, handles);

% --- Executes on button press in updateROI.
function updateROI_Callback(hObject, eventdata, handles)
% hObject    handle to updateROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

chROI=get(handles.ROIselect,'Value')-2;
if isfield(handles,'ROIh') && isvalid(handles.ROIh)
    handles.ROIpos(chROI,:)=getPosition(handles.ROIh);
end
dat=get(handles.uitable5,'Data');
dat(chROI+handles.chTraj,1)={true};
set(handles.uitable5,'Data',dat)
handles.chData(chROI+handles.chTraj,7)={handles.ROIpos(chROI,:)};
handles.chData(chROI+handles.chTraj,1)={true};

% update handle object
guidata(hObject, handles)

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

chData=handles.chData;
if ~exist(['Output' filesep handles.selectedrat filesep handles.selectedexpt filesep num2str(handles.WStrial)])
    mkdir(['Output' filesep handles.selectedrat filesep handles.selectedexpt filesep num2str(handles.WStrial)])
end
save(['Output' filesep handles.selectedrat filesep handles.selectedexpt filesep num2str(handles.WStrial) filesep 'chData.mat'],'chData')


% --- Executes on button press in plotSelected.
function plotSelected_Callback(hObject, eventdata, handles)
% hObject    handle to plotSelected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure
hold on
dat=get(handles.plotTable,'Data');
nCH=max(cell2mat(handles.Traj(:,1)));
for i=1:size(handles.Traj,1)
    
    %% Change Chong's plot function; assumes only 1 channel
    Traj=cell2mat(handles.Traj(i,3));
    plot(smooth(Traj(:,1)), '-g')
    plot(smooth(Traj(:,2)), 'b');
%     for j=1:nCH
%         if cell2mat(handles.Traj(i,1))==j && cell2mat(dat(i,1))
%             subplot(2,3,j)
%             hold on
%             Traj=cell2mat(handles.Traj(i,3));
%             plot(smooth(Traj(:,1)),'-g')
%             plot(smooth(Traj(:,2)),'-b')
%             subplot(2,3,j+3)
%             hold on
%             if j==1
%                 handles.Traj
%                 i
%                 TrajE=cell2mat(handles.Traj(i+2,3));
%                 plot(smooth(Traj(:,1)-TrajE(:,1)),'-g')
%                 plot(smooth(Traj(:,2)-TrajE(:,2)),'-b')
%                 subplot(2,3,j+5)
%                 hold on
%                 plot(sqrt(smooth(Traj(:,1)-TrajE(:,1)).^2+smooth(Traj(:,2)-TrajE(:,2)).^2),'-b')
%             elseif j==2
%                 if min(Traj(:))<10
%                     disp(dat(i,3))
%                 end
%                 TrajE=cell2mat(handles.Traj(i+1,3));
%                 plot(smooth(Traj(:,1)-TrajE(:,1)),'-g')
%                 plot(smooth(Traj(:,2)-TrajE(:,2)),'-b')
%                 subplot(2,3,j+4)
%                 hold on
%                 plot(sqrt(smooth(Traj(:,1)-TrajE(:,1)).^2+smooth(Traj(:,2)-TrajE(:,2)).^2),'-g')
%             end
%         end
%     end
end

% perform PCA on CH2 vertical position
%
% Traj0=handles.Traj(1:90,:);
% Traj1=handles.Traj(91:180,:);
% Traj2=handles.Traj(181:270,:);
%
% X0=zeros(100,30);
% X1=zeros(100,30);
% Y0=zeros(100,30);
% Y1=zeros(100,30);
% for i=1:30
%     X0(:,i)=smooth(Traj0{(i-1)*3+2,3}(:,1));
%     Y0(:,i)=smooth(Traj0{(i-1)*3+2,3}(:,2));
%     X1(:,i)=smooth(Traj1{(i-1)*3+2,3}(:,1));
%     Y1(:,i)=smooth(Traj1{(i-1)*3+2,3}(:,2));
%     X2(:,i)=smooth(Traj2{(i-1)*3+3,3}(:,1));
%     Y2(:,i)=smooth(Traj2{(i-1)*3+3,3}(:,2));
% end
%
% nY01=[];
% for i=1:30
% nY01(:,i)=Y0(26:65,i)-mean(Y0(26:65,i));
% end
% for i=1:30
% nY01(:,i+30)=Y1(26:65,i)-mean(Y1(26:65,i));
% end
% for i=1:30
% nY01(:,i+60)=Y2(26:65,i)-mean(Y2(26:65,i));
% end
%
% figure;
% subplot(2,2,1)
% hold on
% plot(nY01(:,1:30))
% plot(nY01(:,31:60))
% plot(nY01(:,61:90))
% subplot(2,2,2)
% hold on
% plot(mean(nY01(:,1:30),2),'-r')
% plot(mean(nY01(:,31:60),2),'-g')
% plot(mean(nY01(:,61:90),2),'-b')
%
% subplot(2,2,3)
% hold on
% plot(mad(nY01(:,1:30)'),'-r')
% plot(mad(nY01(:,31:60)'),'-g')
% plot(mad(nY01(:,61:90)'),'-b')
%
% [COEFF,SCORE,latent] = princomp(nY01');
% pY01=[];
% for i=1:90
%     pY01(i,1)=dot(nY01(:,i),COEFF(:,1))/norm(COEFF(:,1));
%     pY01(i,2)=dot(nY01(:,i),COEFF(:,2))/norm(COEFF(:,2));
% %     pY01(i,3)=dot(nY01(:,i),COEFF(:,3))/norm(COEFF(:,3));
% end
%
% subplot(2,2,4)
% hold on
% plot(pY01(1:30,1),pY01(1:30,2),'.r')
% plot(pY01(31:60,1),pY01(31:60,2),'.g')
% plot(pY01(61:90,1),pY01(61:90,2),'.b')
% disp(cumsum(latent(1:3))./sum(latent))

% --- Executes on button press in endtracking.
function endtracking_Callback(hObject, eventdata, handles)
% hObject    handle to endtracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% disable the panel for tracking
set(handles.uitable5,'Enable','off')
set(handles.trajTrack,'Enable','off')
set(handles.ROIselect,'Enable','off')
set(handles.trackSelected,'Enable','off')
set(handles.updateROI,'Enable','off')
set(handles.save,'Enable','off')
set(handles.endtracking,'Enable','off')
% delete ROI boxes
if isfield(handles,'ROIh') && isvalid(handles.ROIh)
    delete(handles.ROIh)
end

%
% chData=handles.chData;
% if ~exist(['Output' filesep handles.selectedrat filesep handles.selectedexpt filesep num2str(handles.WStrial)])
%     mkdir(['Output' filesep handles.selectedrat filesep handles.selectedexpt filesep num2str(handles.WStrial)])
% end
% save(['Output' filesep handles.selectedrat filesep handles.selectedexpt filesep num2str(handles.WStrial) filesep 'chData.mat'],'chData')


% --- Executes on button press in loadTrajectories.
function loadTrajectories_Callback(hObject, eventdata, handles)
% hObject    handle to loadTrajectories (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Traj={[],[],[],[],[],[],[]};
['Output' filesep handles.selectedrat filesep]
if exist(['Output' filesep handles.selectedrat filesep])
    R=genpath(['Output' filesep handles.selectedrat filesep]);
    p=pathlist(R);
    for i=1:numel(p)
        if exist([p{i} filesep 'chData.mat'])
            oldChData=load([p{i} filesep 'chData.mat']);
%             Traj=[Traj; oldChData(1).chData(cell2mat(oldChData(1).chData(:,1)),1:7)];
                Traj=[Traj; oldChData(1).chData(cell2mat(oldChData(1).chData(:,1)),:)];
        end
    end
    Traj=Traj(2:end,:);
    set(handles.plotTable,'Data',Traj(:,1:4))
else
    set(handles.plotTable,'Data',[])
end

handles.Traj=Traj(:,5:7);
guidata(hObject,handles)

function p = pathlist(R)
% PATHLIST(R) Returns path R or current path as a cell array. The delimiter
%is the value
% returned by the pathsep function.
% USAGE: p = pathlist(genpath);

% Initialize to the current path.
if nargin < 1
    R = path;
end

% Remove trailing path separator, if any.
if ~isempty(R)
    if isequal(R(end), pathsep)
        R = R(1:end-1);
    end
end

p = strread(R, '%s', 'delimiter', pathsep); % Use generic parse function.

% --- Executes on selection change in selectSession.
function selectSession_Callback(hObject, eventdata, handles)
% hObject    handle to selectSession (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns selectSession contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectSession


% --- Executes during object creation, after setting all properties.
function selectSession_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectSession (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over popupmenu4.
function popupmenu4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
