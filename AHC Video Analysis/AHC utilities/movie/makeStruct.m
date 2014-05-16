function ratStruct = makeStruct(ratName)
% ratStruct = makeStruct(ratName)
%     ratStruct.ratName
%     ratStruct.fileName
%     ratStruct.exptID
%     ratStruct.trials = index of each tap
%     ratStruct.tapTimes = %times of each tap
%     ratStruct.intertapIntervals = delays;
%     ratStruct.numOfTaps %number of taps per trial
%     ratStruct.rewards
%     ratStruct.startTime
%     ratStruct.numOfTrials
%     ratStruct.triggerSampleNum = % the struct number and the trial number

%% Load movies
startingDirectory = ['M:' filesep ratName];
path=dir(startingDirectory);
path = path(arrayfun(@(x) x.name(1), path) ~= '.');
count = 1;
for i=1:length(path)
    directory_name = [startingDirectory filesep path(i).name];
    allTimingFiles = dir([directory_name '\*.timing*']);
    numberOfFiles = length(allTimingFiles);
    exptID=str2num(path(i).name);
    for m = 1:numberOfFiles
        currentTimingFile = importdata([directory_name '\' allTimingFiles(m).name]);
        time = currentTimingFile(:, 1);
        tapNumber = currentTimingFile(:, 2);
        reward = currentTimingFile(:, 3);
        lick = currentTimingFile(:, 4);
        firstTaps = find(tapNumber == 1);
        
        otherTaps =[];
        trials = {};
        tapTimes = {};
        delays = {};
        numberOfTaps = [];
        rewards = [];
        
        %find taps between each first tap
        if length(firstTaps) > 1
            for n = 1:length(firstTaps)-1
                otherTaps = find(tapNumber(firstTaps(n)+1:firstTaps(n+1)-1) ~= 0);
                trials(n, 1) = {cat(1, firstTaps(n), otherTaps+firstTaps(n)-1)};
                tapTimes(n,1) = {time([firstTaps(n); otherTaps+firstTaps(n)-1])};
                delays(n, 1) = {diff(time([firstTaps(n); otherTaps+firstTaps(n)-1]))};
                numberOfTaps(n, 1) = length(otherTaps) + 1;
                rewards(n,1) = ~isempty(find(reward(firstTaps(n)+1:firstTaps(n+1)) == 1));
            end
        end
        %     if isempty(trials)
        %         [directory_name '\' allTimingFiles(m).name]
        %     end
        if ~isempty(trials)
            ratStruct(count).ratName = ratName;
            ratStruct(count).fileName = [directory_name '\' allTimingFiles(m).name];
            ratStruct(count).exptID = exptID;
            ratStruct(count).trials = trials;  %index of each tap
            ratStruct(count).tapTimes = tapTimes; %times of each tap
            ratStruct(count).intertapIntervals = delays;
            ratStruct(count).numOfTaps = numberOfTaps; %number of taps per trial
            ratStruct(count).rewards = rewards;
            ratStruct(count).startTime = {allTimingFiles(m).date};
            ratStruct(count).numOfTrials = numel(trials);
            ratStruct(count).triggerSampleNum = [ones(1,numel(trials))*count; 1:numel(trials)]';
            count = count + 1;
        end
    end
end