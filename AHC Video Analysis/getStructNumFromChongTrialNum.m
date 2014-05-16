    function [structNum sessionTrialNum] = getStructNumFromChongTrialNum(exptStruct, exptID, trialNum)
        %% returns the struct num and session trial number corresponding to the trial number (summation of same exptID)
        sumTrials = 0;
        structNums = getStructNumFromExptID(exptStruct, exptID);
        structNumStart = structNums(1);
        count = 0;
        while sumTrials < trialNum
            sumTrials = sumTrials+exptStruct(structNumStart+count).numOfTrials;
            count = count+1;
        end
        structNum = structNumStart + count-1;
        sessionTrialNum = trialNum-(sumTrials-exptStruct(structNumStart+count-1).numOfTrials);
    end