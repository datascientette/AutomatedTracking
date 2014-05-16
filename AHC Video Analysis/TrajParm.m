function [Traj]=TrajParm

Traj={[],[],[],[],[],[],[]};
R=genpath(['Output\BurkinaFaso']);%' filesep handles.selectedrat]);
p=pathlist(R);
for i=1:numel(p)
    if exist([p{i} filesep 'chData.mat'])
        oldChData=load([p{i} filesep 'chData.mat']);
        Traj=[Traj; oldChData(1).chData(cell2mat(oldChData(1).chData(:,1)),1:7)];
    end
end
Traj=Traj(2:end,:);

% TrajB={[],[],[],[],[],[],[]};
% R=genpath(['Output\Burundi']);%' filesep handles.selectedrat]);
% p=pathlist(R);
% for i=1:numel(p)
%     if exist([p{i} filesep 'chData.mat'])
%         oldChData=load([p{i} filesep 'chData.mat']);
%         TrajB=[TrajB; oldChData(1).chData(cell2mat(oldChData(1).chData(:,1)),1:7)];
%     end
% end
% TrajB=TrajB(2:end,:);

% PCA

close all

Traj0=Traj(1:90,:);
Traj1=Traj(91:180,:);
Traj2=Traj(181:270,:);
% Traj3=TrajB(1:30,:);

sample=10;
X0=zeros(sample*100,30);
Y0=zeros(sample*100,30);
X1=zeros(sample*100,30);
Y1=zeros(sample*100,30);
X2=zeros(sample*100,30);
Y2=zeros(sample*100,30);
% X3=zeros(sample*100,30);
% Y3=zeros(sample*100,30);
for i=1:30
    X0(:,i)=interp1(0:99,smooth(Traj0{(i-1)*3+2,7}(:,1)),0:1/sample:99+(sample-1)/sample,'spline');
    Y0(:,i)=interp1(0:99,smooth(Traj0{(i-1)*3+2,7}(:,2)),0:1/sample:99+(sample-1)/sample,'spline');
    X1(:,i)=interp1(0:99,smooth(Traj1{(i-1)*3+2,7}(:,1)),0:1/sample:99+(sample-1)/sample,'spline');
    Y1(:,i)=interp1(0:99,smooth(Traj1{(i-1)*3+2,7}(:,2)),0:1/sample:99+(sample-1)/sample,'spline');
    X2(:,i)=interp1(0:99,smooth(Traj2{(i-1)*3+2,7}(:,1)),0:1/sample:99+(sample-1)/sample,'spline');
    Y2(:,i)=interp1(0:99,smooth(Traj2{(i-1)*3+2,7}(:,2)),0:1/sample:99+(sample-1)/sample,'spline');
%     X3(:,i)=interp1(0:99,smooth(Traj3{i,7}(:,1)),0:1/sample:99+4/sample);
%     Y3(:,i)=interp1(0:99,smooth(Traj3{i,7}(:,2)),0:1/sample:99+4/sample);
end


for i=1:30
    for j=1:sample*100-1
        if j==1
            v0=[diff(X0(j:j+1,i));diff(Y0(j:j+1,i))];
        else
            v0=[diff(X0(j-1:j,i));diff(Y0(j-1:j,i))];
        end
        v1=[diff(X0(j:j+1,i));diff(Y0(j:j+1,i))];
        
        v0=v0/norm(v0);
        v1=v1/norm(v1);
        
        theta0=angle(complex(v0(1),v0(2)));
        R=[cos(-theta0) -sin(-theta0); sin(-theta0) cos(-theta0)]; % rotation matrix
        Rv1=R*v1;
        
        dtheta(j,i)=angle(complex(Rv1(1),Rv1(2)));
    end
    d(:,i)=cumsum(sqrt(diff(X0(:,1)).^2+diff(Y0(:,1)).^2));
    theta(:,i)=cumsum(dtheta(:,i));
end

figure; plot(X0,Y0)
figure; plot(d,theta)
figure
subplot(2,2,1)
plot(X0)
subplot(2,2,3)
plot([zeros(1,30); d],X0)
subplot(2,2,2)
plot(Y0)
subplot(2,2,4)
plot([zeros(1,30); d],Y0)

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

