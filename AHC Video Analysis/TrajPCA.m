function TrajPCA
Traj={[],[],[],[],[],[],[]};
% R=genpath(['Output\BurkinaFaso']);%' filesep handles.selectedrat]);
R=genpath(['E:\Risa\Chong\for Chong on paw tracking\AHC Video Analysis\Output\BurkinaFaso']);%' filesep handles.selectedrat]);
p=pathlist(R);
for i=1:numel(p)
    if exist([p{i} filesep 'chData.mat'])
        oldChData=load([p{i} filesep 'chData.mat']);
        Traj=[Traj; oldChData(1).chData(cell2mat(oldChData(1).chData(:,1)),1:7)];
    end
end
Traj=Traj(2:end,:);

TrajB={[],[],[],[],[],[],[]};
% R=genpath(['Output\Burundi']);%' filesep handles.selectedrat]);
R=genpath(['E:\Risa\Chong\for Chong on paw tracking\AHC Video Analysis\Output\Burundi']);%' filesep handles.selectedrat]);
p=pathlist(R);
for i=1:numel(p)
    if exist([p{i} filesep 'chData.mat'])
        oldChData=load([p{i} filesep 'chData.mat']);
        TrajB=[TrajB; oldChData(1).chData(cell2mat(oldChData(1).chData(:,1)),1:7)];
    end
end
TrajB=TrajB(2:end,:);

% PCA

close all

Traj0=Traj(1:90,:);
Traj1=Traj(91:180,:);
Traj2=Traj(181:270,:);
Traj3=TrajB(1:30,:);

sample=5;
X0=zeros(sample*100,30);
Y0=zeros(sample*100,30);
X1=zeros(sample*100,30);
Y1=zeros(sample*100,30);
X2=zeros(sample*100,30);
Y2=zeros(sample*100,30);
X3=zeros(sample*100,30);
Y3=zeros(sample*100,30);
for i=1:30
    X0(:,i)=interp1(0:99,smooth(Traj0{(i-1)*3+2,7}(:,1)),0:1/sample:99+4/sample);
    Y0(:,i)=interp1(0:99,smooth(Traj0{(i-1)*3+2,7}(:,2)),0:1/sample:99+4/sample);
    X1(:,i)=interp1(0:99,smooth(Traj1{(i-1)*3+2,7}(:,1)),0:1/sample:99+4/sample);
    Y1(:,i)=interp1(0:99,smooth(Traj1{(i-1)*3+2,7}(:,2)),0:1/sample:99+4/sample);
    X2(:,i)=interp1(0:99,smooth(Traj2{(i-1)*3+2,7}(:,1)),0:1/sample:99+4/sample);
    Y2(:,i)=interp1(0:99,smooth(Traj2{(i-1)*3+2,7}(:,2)),0:1/sample:99+4/sample);
    X3(:,i)=interp1(0:99,smooth(Traj3{i,7}(:,1)),0:1/sample:99+4/sample);
    Y3(:,i)=interp1(0:99,smooth(Traj3{i,7}(:,2)),0:1/sample:99+4/sample);
end

seg=21:70;
nY01=[];
for i=1:30
    nY01(:,i)=Y0(seg*sample,i)-mean(Y0(seg*sample,i));
end
for i=1:30
    nY01(:,i+30)=Y1(seg*sample,i)-mean(Y1(seg*sample,i));
end
for i=1:30
    nY01(:,i+60)=Y2(seg*sample,i)-mean(Y2(seg*sample,i));
end
for i=1:30
    nY01(:,i+90)=Y3(seg*sample,i)-mean(Y3(seg*sample,i));
end


nX01=[];
for i=1:30
    nX01(:,i)=X0(seg*sample,i)-mean(X0(seg*sample,i));
end
for i=1:30
    nX01(:,i+30)=X1(seg*sample,i)-mean(X1(seg*sample,i));
end
for i=1:30
    nX01(:,i+60)=X2(seg*sample,i)-mean(X2(seg*sample,i));
end
for i=1:30
    nX01(:,i+90)=X3(seg*sample,i)-mean(X3(seg*sample,i));
end

nY01=[];
for i=1:30
    nY01(:,i)=Y0(seg*sample,i)-mean(Y0(seg*sample,i));
end
for i=1:30
    nY01(:,i+30)=Y1(seg*sample,i)-mean(Y1(seg*sample,i));
end
for i=1:30
    nY01(:,i+60)=Y2(seg*sample,i)-mean(Y2(seg*sample,i));
end
for i=1:30
    nY01(:,i+90)=Y3(seg*sample,i)-mean(Y3(seg*sample,i));
end

[COEFFX,SCOREX,latentX] = princomp(nX01');
pX01=zeros(120,2);
for i=1:120
    pX01(i,1)=dot(nX01(:,i),COEFFX(:,1))/norm(COEFFX(:,1));
    pX01(i,2)=dot(nX01(:,i),COEFFX(:,2))/norm(COEFFX(:,2));
    %     pY01(i,3)=dot(nY01(:,i),COEFF(:,3))/norm(COEFF(:,3));
end

[COEFFY,SCOREY,latentY] = princomp(nY01');
pY01=zeros(120,2);
for i=1:120
    pY01(i,1)=dot(nY01(:,i),COEFFY(:,1))/norm(COEFFY(:,1));
    pY01(i,2)=dot(nY01(:,i),COEFFY(:,2))/norm(COEFFY(:,2));
    %     pY01(i,3)=dot(nY01(:,i),COEFF(:,3))/norm(COEFF(:,3));
end

% PCA on X

figure
subplot(2,2,1)
title('All horizontal trajectories')
hold on
plot(nX01(:,1:30),'-r')
plot(nX01(:,31:60),'-g')
plot(nX01(:,61:90),'-b')
plot(nX01(:,91:120),'-c')

subplot(2,2,2)
title('Average horizontal trajectories')
hold on
plot(mean(nX01(:,1:30),2),'-r')
plot(mean(nX01(:,31:60),2),'-g')
plot(mean(nX01(:,61:90),2),'-b')
plot(mean(nX01(:,91:120),2),'-c')

subplot(2,2,3)
title(gca,'Variability across trials at each time point')
xlabel(gca,'time')
hold on
plot(mad(nX01(:,1:30)'),'-r')
plot(mad(nX01(:,31:60)'),'-g')
plot(mad(nX01(:,61:90)'),'-b')
plot(mad(nX01(:,91:120)'),'-c')

subplot(2,2,4)
title(gca,'Clustering using the first two components of horizontal coordinate location')
hold on
plot(pX01(1:30,1),pX01(1:30,2),'.r')
plot(pX01(31:60,1),pX01(31:60,2),'.g')
plot(pX01(61:90,1),pX01(61:90,2),'.b')
plot(pX01(91:120,1),pX01(91:120,2),'.c')

% PCA on Y

figure
subplot(2,2,1)
title('All vertical trajectories')
hold on
plot(nY01(:,1:30),'-r')
plot(nY01(:,31:60),'-g')
plot(nY01(:,61:90),'-b')
plot(nY01(:,91:120),'-c')

subplot(2,2,2)
title('Average vertical trajectories')
hold on
plot(mean(nY01(:,1:30),2),'-r')
plot(mean(nY01(:,31:60),2),'-g')
plot(mean(nY01(:,61:90),2),'-b')
plot(mean(nY01(:,91:120),2),'-c')

subplot(2,2,3)
title(gca,'Variability across trials at each time point')
xlabel(gca,'time')
hold on
plot(mad(nY01(:,1:30)'),'-r')
plot(mad(nY01(:,31:60)'),'-g')
plot(mad(nY01(:,61:90)'),'-b')
plot(mad(nY01(:,91:120)'),'-c')

subplot(2,2,4)
title(gca,'Clustering using the first two components of vertical coordinate location')
hold on
plot(pY01(1:30,1),pY01(1:30,2),'.r')
plot(pY01(31:60,1),pY01(31:60,2),'.g')
plot(pY01(61:90,1),pY01(61:90,2),'.b')
plot(pY01(91:120,1),pY01(91:120,2),'.c')

disp('latentX:')
disp(cumsum(latentX(1:3))./sum(latentX))
disp('latentY:')
disp(cumsum(latentY(1:3))./sum(latentY))

figure
subplot(1,3,1)
title(gca,'PCA on horizontal coordinate location')
xlabel('time')
hold on
plot(COEFFX(:,1),'-r')
plot(COEFFX(:,2),'-g')
plot(COEFFX(:,3),'-b')
subplot(1,3,2)
title(gca,'PCA on vertical coordinate location')
xlabel('time')
hold on
plot(COEFFY(:,1),'-r')
plot(COEFFY(:,2),'-g')
plot(COEFFY(:,3),'-b')
subplot(1,3,3)
title(gca,'Clustering using the first components of horizontal and vertical coordinate locations')
xlabel('Component 1 (PCA Horizontal)')
ylabel('Component 1 (PCA Vertical)')
hold on
plot(pX01(1:30,1),pY01(1:30,1),'.r')
plot(pX01(31:60,1),pY01(31:60,1),'.g')
plot(pX01(61:90,1),pY01(61:90,1),'.b')
plot(pX01(91:120,1),pY01(91:120,1),'.c')

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

