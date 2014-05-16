function Traj=LoadTraj(rat,condition,exptID,trial,t0)
% condition is a cell array for the conditions of the group
% exptID a row vector, one ID for one condition/day
% trial is a 2d vector, each column corresponds to the trials of the corresponding condition/day

Traj=struct('rat',[],'condition',[],'day',[],'exptID',[],'trial',[],'ch1',[],'ch2',[],'ch3',[]);


for i=1:length(exptID)
    ch1x=[];ch1y=[];ch2x=[];ch2y=[];ch3x=[];ch3y=[];
    for j=1:size(trial,1);
%         filename=['Output' filesep rat filesep num2str(exptID{i}(1)) filesep num2str(trial(j,i))];
        filename=['E:\Risa\Chong\for Chong on paw tracking\AHC Video Analysis\Output' filesep rat filesep num2str(exptID{i}(1)) filesep num2str(trial(j,i))];
        if ~exist(filename,'dir') && length(exptID{i})==2
%             filename=['Output' filesep rat filesep num2str(exptID{i}(2)) filesep num2str(trial(j,i))];
            filename=['E:\Risa\Chong\for Chong on paw tracking\AHC Video Analysis\Output' filesep rat filesep num2str(exptID{i}(2)) filesep num2str(trial(j,i))];
        end
        load([filename filesep 'chData.mat']);
        Traj(i,j)=struct('rat',rat,...
            'condition',condition{i},...
            'day',chData(1,6),...
            'exptID',chData(1,2),...
            'trial',chData(1,3),...
            'ch1',chData{1,7},...
            'ch2',chData{2,7},...
            'ch3',chData{3,7});
        if ~isempty(chData{1,7})
            ch1x=[ch1x chData{1,7}(t0,1)];
            ch1y=[ch1y chData{1,7}(t0,2)];
        end
        if ~isempty(chData{2,7})
            ch2x=[ch2x chData{2,7}(t0,1)];
            ch2y=[ch2y chData{2,7}(t0,2)];
        end
        if ~isempty(chData{3,7})
            ch3x=[ch3x chData{3,7}(t0,1)];
            ch3y=[ch3y chData{3,7}(t0,2)];
        end
    end
%     mch1x=median(ch1x);
%     mch1y=median(ch1y);
%     mch2x=median(ch2x);
%     mch2y=median(ch2y);
%     mch3x=median(ch3x);
%     mch3y=median(ch3y);
%     for j=1:size(trial,1);
%         if ~size(Traj(i,j).ch1)==0
%             Traj(i,j).ch1(:,1)=Traj(i,j).ch1(:,1)-mch1x;
%             Traj(i,j).ch1(:,2)=Traj(i,j).ch1(:,2)-mch1y;
%         else
%             Traj(i,j).ch2=zeros(size(Traj(i,j).ch2));
%         end
%         if ~size(Traj(i,j).ch2)==0
%             Traj(i,j).ch2(:,1)=Traj(i,j).ch2(:,1)-mch2x;
%             Traj(i,j).ch2(:,2)=Traj(i,j).ch2(:,2)-mch2y;
%         else
%             Traj(i,j).ch2=zeros(size(Traj(i,j).ch1));
%         end
%         if ~size(Traj(i,j).ch3)==0
%             Traj(i,j).ch3(:,1)=Traj(i,j).ch3(:,1)-mch3x;
%             Traj(i,j).ch3(:,2)=Traj(i,j).ch3(:,2)-mch3y;
%         else
%             Traj(i,j).ch2=zeros(size(Traj(i,j).ch1));
%         end
%     end
end
