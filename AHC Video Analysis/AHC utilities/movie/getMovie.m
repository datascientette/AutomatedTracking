function movieFrames = getMovie(exptID, triggerSampleNum, Tap1CPUTime, numOfFrames, fileNames, varargin)
% load movie using triggerSampleNum and load frames, aligned to Tap1CpuTime
% pretapNumOfFrames = 30;
pretapNumOfFrames = 25;
postTapNumOfFrames = 25;

LastTapCPUTime = [];

if ~isempty(varargin)
    for m = 1:2:length(varargin)
        key = varargin{m};
        val = varargin{m+1};
        switch key
            case 'LastTap'
                LastTapCPUTime = val;
            otherwise
                error('Typo in getMovie')
        end
    end
end

% %% Get directory information for exptID in server
extension = '-0.mp4';
% directoryName = ['\\RatControlServ\RatControlOp\RISAKAWAI3\Data\' num2str(exptID) '\'];
% directoryName = ['X:\RISAKAWAI3\' num2str(exptID) '\'];
directoryName = ['X:\RISAKAWAI5\' num2str(exptID) '\'];
% directory = dir([directoryName '*.mp4']);
% 
% fileNames = zeros(numel(directory), 1);
% for m = 1:numel(directory)
%     fileNames(m) = str2num(directory(m).name(1:end-numel(extension)));
% end
% fileNames = sort(fileNames);
%% Find max filename <= triggerSampleNum
fileNameIDX = find(fileNames <= triggerSampleNum, 1, 'last');
if isempty(fileNameIDX)
    movieFrames = [];
else
    fileName = fileNames(fileNameIDX);

    %% Load .times file

    fid = fopen([directoryName num2str(fileName) extension '.times'], 'r');
    timesFile = fread(fid, 'int64');
    fclose(fid);
    
    %% Find closest timestamp to tap1cputime
    tap1FrameNum = find(timesFile<=Tap1CPUTime, 1, 'last');
    if isempty(LastTapCPUTime)
        movieFrames = mmread([directoryName num2str(fileName) extension],tap1FrameNum-pretapNumOfFrames:tap1FrameNum-pretapNumOfFrames+numOfFrames-1);
    else
        lastTapFrameNum = find(timesFile <= LastTapCPUTime, 1, 'last');
        movieFrames = mmread([directoryName num2str(fileName) extension],tap1FrameNum-pretapNumOfFrames:lastTapFrameNum+postTapNumOfFrames-1);
    end
%     movieTimestamps = timesFile(tap1FrameNum-pretapNumOfFrames:tap1FrameNum+postTapNumOfFrames-1);
end
