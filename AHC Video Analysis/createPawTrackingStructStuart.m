function exptStruct = createPawTrackingStructStuart(ratName)
%% creates a struct with the same fields as regular struct (from createExptStruct) plus the following fields
% Paw1
% Paw2
% Ear
% Aligned at first tap (frame 30)
saveStruct = 1; % if == 1, then save in saveDirectoryName

% saveDirectoryName = 'E:\Risa\Data\Countries\Tracked\';
% saveDirectoryName = 'D:\Olveczkylab\Tim Rats\';
saveDirectoryName = 'C:\Users\Risa\My Cubby\Stuart\With tracking\';
% trajDirectoryName = 'E:\Risa\Chong\for Chong on paw tracking\AHC Video Analysis\Output\';
% trajDirectoryName = 'C:\Users\risak_000\My Cubby\Stuart\';
trajDirectoryName = 'C:\Users\Risa\My Cubby\Stuart\';
% directoryName = 'E:\Risa\Data\Countries\Progress figures\'; % directory that stores exptStruct
% directoryName = 'C:\Users\risak_000\My Cubby\Stuart\';% directory that stores exptStruct
directoryName = 'C:\Users\Risa\My Cubby\Stuart\';% directory that stores exptStruct
data = load([directoryName ratName '.mat']);
exptStruct = eval(['data.' ratName]);

exptIDFolderName = [trajDirectoryName ratName '\'];
exptDirectories = dir(exptIDFolderName)'; %folders with exptIDs as names

if ~isfield(exptStruct, 'pawTracked')
    exptStruct(1).pawXY = [];
    exptStruct(1).timeStamps = [];
    exptStruct(1).pawTracked = [];
    exptStruct(1).errors = [];
%     exptStruct(1).nondominantPaw = [];
%     exptStruct(1).ear = [];
    exptStruct(1).type = 'Auto';
end

for m = 1:numel(exptDirectories)
% for m = 1:4
    if ~isequal(exptDirectories(m).name, '.') && ~isequal (exptDirectories(m).name, '..')
        trialDirectories = dir([exptIDFolderName exptDirectories(m).name])
        currentExptID = str2double(exptDirectories(m).name); %exptID of current tracking

        for n = 1:numel(trialDirectories)
%         for n = 1:5
            if exist([exptIDFolderName exptDirectories(m).name '\' trialDirectories(n).name '\chData.mat'], 'file')
                chData = load([exptIDFolderName exptDirectories(m).name '\' trialDirectories(n).name '\chData.mat']);
                chData = chData.chData;
                currentTrialNum = str2double(trialDirectories(n).name); %trial number of current tracking
%                 [structNum sessionTrialNum] = getStructNumFromChongTrialNum(exptStruct, currentExptID, currentTrialNum); %% convert Chong's trial num (concatenated sessiosn with same exptID) to session trial num
                switch currentExptID
                    case 91008
                        structNum = 112;
                        sessionTrialNum = currentTrialNum;
                    case 91015
                        structNum = 116;
                        sessionTrialNum = currentTrialNum;     
                end
                trackingDate = chData{1,6};
                if currentExptID == 424
                    display(trackingDate)
                end
%                 if ~isequal(trackingDate, exptStruct(structNum).startTime)
%                     display('Tracked file date does not match exptStruct date')
%                 else
                    %% Get trajectories (1st row for dominant paw, 2nd row for nondominant paw, 3rd row for ear).  Leave empty if channel does not exist
                    pawXY = [];
                    nondominantPaw = [];
                    ear = [];
                    sizeOfChData = size(chData, 1);
                    if sizeOfChData > 0;
                        pawXY = chData{1,end};
                        if sizeOfChData > 1;
                            nondominantPaw = chData{2,end};
                            if sizeOfChData > 2;
                                ear = chData{3,end};
                                if sizeOfChData > 3;
                                    display('Extra channels')
                                end
                            end
                        end
                    end
                    
                    %% check to see if cell structure exists
                    currentSessionNumOfTrials = exptStruct(structNum).numOfTrials;
%                     structNum
                    if isempty(exptStruct(structNum).pawXY) || isempty(exptStruct(structNum).pawTracked);
                       
                        exptStruct(structNum).pawXY = cell(1, currentSessionNumOfTrials);
                        %%exptStruct(structNum).nondominantPaw = cell(1, currentSessionNumOfTrials);
                        %%exptStruct(structNum).ear = cell(1, currentSessionNumOfTrials);
                        exptStruct(structNum).pawTracked = zeros(1, currentSessionNumOfTrials);
                        exptStruct(structNum).errors = cell(1, currentSessionNumOfTrials);
                    end
                     %% FOR BURKINA FASO, SWITCH PAWS
%                      if length(pawXY) > 55
%                         exptStruct(structNum).pawXY(1, sessionTrialNum) = {pawXY(11:end,:)};
%                      else
%                          
%                      end
                    exptStruct(structNum).pawXY(1, sessionTrialNum) = {pawXY};
%                     if sizeOfChData>1
%                         exptStruct(structNum).pawXY(1, sessionTrialNum) = {nondominantPaw(11:end,:)};
%                     else
%                         exptStruct(structNum).pawXY(1, sessionTrialNum) = {pawXY};
%                     end
                    %%exptStruct(structNum).nondominantPaw(1, sessionTrialNum) = {nondominantPaw};
                    %%exptStruct(structNum).ear(1,sessionTrialNum) = {ear};
                    exptStruct(structNum).pawTracked(sessionTrialNum) = 1;
                    sessionTrialNum
                    exptStruct(structNum).errors = cell(zeros(1,size(pawXY,1)));
                    exptStruct(structNum).type = 'Auto';
                end
            end
%         end
        
    end
end

if saveStruct
%% Save
    ratName
    eval([ratName '= exptStruct']);
    save([saveDirectoryName ratName '.mat'], ratName);
end



end



