t0=33; % time of first tap
%% BurkinaFaso
rat='BurkinaFaso';
condition={'Pre-mock','Mock','Pre-contra','Contra','Pre-ipsi','Ipsi'};
exptID={370,424,424,444,468,477};
trial=[4353 4374 4381 4393 4394 4401 4449 4453 4456 4514 4529 4547 4570 4572 4597,...
    4642 4712 4732 4739 4756 4785 4786 4791 4825 4850 4658 4665 4667 4681 4796;...
    1127 1146 1179 1252 1268 1420 1457 1476 1479 1532 1536 1602 1639 1719 1742,...
    1790 1805 1806 1827 1861 1902 1941 1957 1966 1973 1996 2033 2037 2038 2052;...
    4280 4281 4291 4306 4307 4311 4341 4398 4399 4406 4490 4507 4520 4542 4550,...
    4589 4597 4602 4605 4632 4637 4667 4672 4728 4729 4731 4740 4744 4749 4761;...
    885 886 915 928 936 956 957 972 974 985 986 1003 1010 1039 1040,...
    1134 1136 1143 1144 1161 1162 1165 1198 1199 1200 1206 1224 1225 1226 1237;...
    3359 3366 3389 3405 3428 3442 3446 3451 3461 3472 3529 3549 3556 3597 3528,...
    3645 3805 3809 3871 3876 3961 3993 4016 4035 4045 4086 4094 4104 4110 4120;...
    899 1058 1064 1111 1147 1183 1186 1206 1237 1243 1255 1266 1267 1309 1350,...
    1372 1382 1383 1414 1418 1419 1430 1486 1519 1543 1545 1560 1563 1603 1638]';
BF=LoadTraj(rat,condition,exptID,trial,t0);

%% Burundi

rat='Burundi';
condition={'Pre-mock','Mock','Pre-contra','Contra'};
exptID={405,436,436,452};
trial=[1363 1402 1406 1412 1437 1466 1527 1613 1618 1668 1690 1719 1722 1726 1736,...
    1786 1843 1869 1969 1979 2031 2043 2070 2096 2154 2167 2171 2173 2188 2207;...
    1048 1060 1135 1147 1158 1175 1180 1230 1244 1253 1270 1276 1285 1302 1308,...
    1380 1381 1386 1396 1400 1405 1414 1427 1429 1436 1464 1467 1476 1481 1488;...
    4195 4204 4205 4222 4226 4244 4247 4258 4291 4298 4303 4319 4321 4334 4347,...
    4370 4382 4387 4407 4410 4414 4417 4421 4437 4443 4445 4450 4473 4478 4481;...
    2317 2321 2364 2367 2373 2375 2389 2400 2436 2445 2518 2607 2627 2633 2685,...
    2697 2728 2737 2746 2767 2775 2788 2822 2831 2855 2879 2881 2908 2952 2957;]';
Burundi=LoadTraj(rat,condition,exptID,trial,t0);

%% Cameroon

rat='Cameroon';
condition={'Pre-mock','Mock','Pre-contra','Contra'};
exptID={[438 425],443 443,469};
trial=[12 18 31 90 103 105 107 135 148 162 174 178 198 203 278,...
    3530 3538 3614 3620 3626 3651 3666 3673 3680 3686 3727 3833 3839 3859 3874;...
    994 998 1066 1144 1152 1156 1172 1179 1191 1247 1251 1266 1304 1307 1310,...
    1356 1389 1391 1422 1432 1439 1444 1456 1495 1523 1541 1587 1596 1598 1622;...
    5314 5325 5332 5337 5366 5374 5376 5389 5412 5450 5453 5466 5467 5473 5474,...
    5490 5491 5495 5501 5509 5513 5518 5523 5540 5616 5617 5625 5626 5628 5629;...
    1107 1182 1196 1200 1311 1357 1367 1370 1373 1379 1420 1431 1465 1470 1471,...
    1491 1493 1506 1514 1520 1525 1554 1576 1584 1602 1619 1632 1639 1647 1679;]';
Cameroon=LoadTraj(rat,condition,exptID,trial,t0);

%% Brazil

rat='Brazil';
condition={'Pre-mock','Mock','Pre-contra','Contra'};
exptID={266,309};
trial=[7385 7393 7400 7449 7463 7486 7496 7497 7513 7516 7528 7542 7544 7554 7557,...
    7615 7617 7649 7709 7715 7721 7732 7786 7786 7787 7798 7821 7908 7918 7927;...
    3615 3669 3672 3682 3697 3724 3730 3737 3752 3772 3790 3831 3846 3875 3876,...
    3882 3897 3900 3902 3913 3933 3961 4002 4013 4017 4030 4058 4067 4090 4148]';
Brazil=LoadTraj(rat,condition,exptID,trial,t0);

%% Stuart

rat='Stuart';
condition={'Pre-contra','Contra'};
exptID={91008,91015};
trial=[42 77 105 117 136 208 218 406 428 516 588 634 665 693 774,...
    867 876 900 901 935 1020 1047 1061 1072 1138 1159 1231 1268 1331 1350;...
    15 42 53 57 70 72 86 95 105 121 126 133 134 144 154,...
    159 181 183 187 189 214 218 238 244 266 267 281 284 292 294]';
Stuart=LoadTraj(rat,condition,exptID,trial,t0);

%% Anna

rat='Anna';
condition={'Pre-contra','Contra'};
exptID={91012,91020};
trial=[57 79 112 152 176 182 186 191 225 233 248 250 292 293 303 ,...
    317 328 377 381 385 403 438 478 495 524 528 577 600 634 685;...
    53 113 117 138 140 145 162 167 174 185 205 208 211 223 227,...
    243 248 272 280 294 304 319 334 343 355 374 380 388 393 399]';
Anna=LoadTraj(rat,condition,exptID,trial,t0);

%% Reinterpolate Stuart and Anna's data
for i=1:size(Stuart,1)
    for j=1:size(Stuart,2)
        ch0=Stuart(i,j).ch1;
        Stuart(i,j).ch1=[interp1(1:size(ch0,1),smooth(ch0(:,1),2),1:2:size(ch0,1))' interp1(1:size(ch0,1),smooth(ch0(:,2),2),1:2:size(ch0,1))'];
        ch0=Stuart(i,j).ch3;
        Stuart(i,j).ch3=[interp1(1:size(ch0,1),smooth(ch0(:,1),2),1:2:size(ch0,1))' interp1(1:size(ch0,1),smooth(ch0(:,2),2),1:2:size(ch0,1))'];
    end
end

for i=1:size(Anna,1)
    for j=1:size(Anna,2)
        ch0=Anna(i,j).ch1;
        Anna(i,j).ch1=[interp1(1:size(ch0,1),smooth(ch0(:,1),2),1:2:size(ch0,1))' interp1(1:size(ch0,1),smooth(ch0(:,2),2),1:2:size(ch0,1))'];
        ch0=Anna(i,j).ch2;
        Anna(i,j).ch2=[interp1(1:size(ch0,1),smooth(ch0(:,1),2),1:2:size(ch0,1))' interp1(1:size(ch0,1),smooth(ch0(:,2),2),1:2:size(ch0,1))'];
        ch0=Anna(i,j).ch3;
        Anna(i,j).ch3=[interp1(1:size(ch0,1),smooth(ch0(:,1),2),1:2:size(ch0,1))' interp1(1:size(ch0,1),smooth(ch0(:,2),2),1:2:size(ch0,1))'];
    end
end

%% PCA IIIa (dominant paw; pre-post lesion with different shade)
normfac={[220.34 274.66 15.34 204.97;...
    219.21 273.53 14.22 206.10;...
    219.21 274.66 17.60 204.97;...
    220.34 272.40 14.22 204.97],...
    [190.99 276.91 18.73 203.84;...
    192.12 274.66 13.09 201.59;...
    192.12 273.53 15.34 204.97;...
    193.25 273.53 15.34 204.97],...
    [398.68 248.69 0 216.26;...
    418.99 253.21 0 220.77;...
    421.25 254.34 0 220.78;...
    285.80 245.31 5.19 208.36],...
    [296.06 271.22 0 133.35;...
    296.06 271.22 0 133.35],...
    [296.06 271.22 0 133.35;...
    296.06 271.22 0 133.35]};


%% PCA IIIb (alternative paw; pre-post lesion with different shades)
trange=26:60; % time range that you want to look at.
trange60=21:55;
v0=[];
p1=[];p2=[];

% alternative paw
for cor=1:2
    traj=[];
    for i=1:2
        for j=1:size(BF,2)
            traj=[traj sign(1.5-cor)*smooth(BF(i,j).ch2(trange,cor)-normfac{1}(i,cor))/norm(normfac{1}(i,3:4))];
        end
    end
    for i=1:2
        for j=1:size(Burundi,2)
            traj=[traj sign(1.5-cor)*smooth(Burundi(i,j).ch1(trange,cor)-normfac{2}(i,cor))/norm(normfac{2}(i,3:4))];
        end
    end
    for i=1:2
        for j=1:size(Cameroon,2)
            traj=[traj sign(1.5-cor)*smooth(Cameroon(i,j).ch2(trange,cor)-normfac{3}(i,cor))/norm(normfac{3}(i,3:4))];
        end
    end
    for i=1:2
        for j=1:size(Anna,2)
            traj=[traj -smooth(Anna(i,j).ch1(trange60,cor)-normfac{5}(i,cor))/norm(normfac{5}(i,3:4))];
        end
    end
    for i=1:2
        for j=1:size(Stuart,2)
            traj=[traj -smooth(Stuart(i,j).ch1(trange60,cor)-normfac{4}(i,cor))/norm(normfac{4}(i,3:4))];
        end
    end
    
    for i=3:4
        for j=1:size(BF,2)
            traj=[traj sign(1.5-cor)*smooth(BF(i,j).ch2(trange,cor)-normfac{1}(i,cor))/norm(normfac{1}(i,3:4))];
        end
    end
    for i=3:4
        for j=1:size(Burundi,2)
            traj=[traj sign(1.5-cor)*smooth(Burundi(i,j).ch1(trange,cor)-normfac{2}(i,cor))/norm(normfac{2}(i,3:4))];
        end
    end
    for i=3:4
        for j=1:size(Cameroon,2)
            traj=[traj sign(1.5-cor)*smooth(Cameroon(i,j).ch2(trange,cor)-normfac{3}(i,cor))/norm(normfac{3}(i,3:4))];
        end
    end
    for i=1:2
        for j=1:size(Anna,2)
            traj=[traj -smooth(Anna(i,j).ch1(trange60,cor)-normfac{5}(i,cor))/norm(normfac{5}(i,3:4))];
        end
    end
    for i=1:2
        for j=1:size(Stuart,2)
            traj=[traj -smooth(Stuart(i,j).ch1(trange60,cor)-normfac{4}(i,cor))/norm(normfac{4}(i,3:4))];
        end
    end
    v0=[v0; traj]; % concatinate x and y
end

figure(1);
cmap=hsv(6);
for i=1:5
    sx=spline(1:length(trange),v0(1:length(trange),(i-1)*60+1:i*60)',1:.2:length(trange));
    sy=spline(1:length(trange),v0(length(trange)+1:end,(i-1)*60+1:i*60)',1:.2:length(trange));
    subplot(2,3,1); hold on;
    plot(sx','Color',cmap(i,:))
    xlim([1 length(sx')])
    ylim([-1 1])
    xlabel('Time')
    ylabel('Horizontal')
    subplot(2,3,2); hold on;
    plot(sy','Color',cmap(i,:))
    xlim([1 length(sx')])
    ylim([-1 1])
    xlabel('Time')
    ylabel('Vertical')
    subplot(2,3,3); hold on;
    plot(sx',sy','Color',cmap(i,:))
    axis image
    xlabel('Horizontal')
    ylabel('Vertical')
    xlim([-.8 .4])
    ylim([-.5 1.2])
end

[COEFF,SCORE,latent] = princomp(v0');
disp(sum(latent(1:2))/sum(latent))

for i=1:size(v0,2)
    p1(i)=dot(v0(:,i),COEFF(:,1))/norm(COEFF(:,1));
    p2(i)=dot(v0(:,i),COEFF(:,2))/norm(COEFF(:,2));
end

figure(2);
h3=subplot(2,2,1);
hold on
cmap=hsv(6);
for i=1:5
    DarkShades=[linspace(cmap(i,1), 0, 10)' linspace(cmap(i,2), 0, 10)' linspace(cmap(i,3), 0, 10)'];
    plot(p1((i-1)*60+1:i*60-30),p2((i-1)*60+1:i*60-30),'.','Color',DarkShades(5,:));
    LightShades=[linspace(cmap(i,1), 1, 10)' linspace(cmap(i,2), 1, 10)' linspace(cmap(i,3), 1, 10)'];
    plot(p1((i-1)*60+31:i*60),p2((i-1)*60+31:i*60),'.','Color',LightShades(5,:));
end
set(gca,'Box','on','XTick',[],'YTick',[])
title(h3,'Dominant Paw - Control')
xlabel('PC 1')
ylabel('PC 2')

h4=subplot(2,2,2);
hold on
cmap=hsv(6);
for i=1:5
    DarkShades=[linspace(cmap(i,1), 0, 10)' linspace(cmap(i,2), 0, 10)' linspace(cmap(i,3), 0, 10)'];
    plot(p1((i-1)*60+301:i*60+270),p2((i-1)*60+301:i*60+270),'.','Color',DarkShades(5,:));
    LightShades=[linspace(cmap(i,1), 1, 10)' linspace(cmap(i,2), 1, 10)' linspace(cmap(i,3), 1, 10)'];
    plot(p1((i-1)*60+331:i*60+300),p2((i-1)*60+331:i*60+300),'.','Color',LightShades(5,:));
end
set(gca,'Box','on','XTick',[],'YTick',[])
title(h4,'Dominant Paw - Contralateral Lesion')
xlabel('PC 1')
ylabel('PC 2')

%% PCA IIIa (dominant paw; pre-post lesion with different shades)
v0=[];
p1=[];p2=[];

% alternative paw
for cor=1:2
    traj=[];
    for i=1:2
        for j=1:size(BF,2)
            traj=[traj sign(1.5-cor)*smooth(BF(i,j).ch1(trange,cor)-normfac{1}(i,cor))/norm(normfac{1}(i,3:4))];
        end
    end
    for i=1:2
        for j=1:size(Burundi,2)
            traj=[traj sign(1.5-cor)*smooth(Burundi(i,j).ch2(trange,cor)-normfac{2}(i,cor))/norm(normfac{2}(i,3:4))];
        end
    end
    for i=1:2
        for j=1:size(Cameroon,2)
            traj=[traj sign(1.5-cor)*smooth(Cameroon(i,j).ch1(trange,cor)-normfac{3}(i,cor))/norm(normfac{3}(i,3:4))];
        end
    end
    for i=1:2
        for j=1:size(Anna,2)
            traj=[traj -smooth(Anna(i,j).ch2(trange60,cor)-normfac{5}(i,cor))/norm(normfac{5}(i,3:4))];
        end
    end
    
    for i=3:4
        for j=1:size(BF,2)
            traj=[traj sign(1.5-cor)*smooth(BF(i,j).ch1(trange,cor)-normfac{1}(i,cor))/norm(normfac{1}(i,3:4))];
        end
    end
    for i=3:4
        for j=1:size(Burundi,2)
            traj=[traj sign(1.5-cor)*smooth(Burundi(i,j).ch2(trange,cor)-normfac{2}(i,cor))/norm(normfac{2}(i,3:4))];
        end
    end
    for i=3:4
        for j=1:size(Cameroon,2)
            traj=[traj sign(1.5-cor)*smooth(Cameroon(i,j).ch1(trange,cor)-normfac{3}(i,cor))/norm(normfac{3}(i,3:4))];
        end
    end
    for i=1:2
        for j=1:size(Anna,2)
            traj=[traj -smooth(Anna(i,j).ch2(trange60,cor)-normfac{5}(i,cor))/norm(normfac{5}(i,3:4))];
        end
    end
    v0=[v0; traj]; % concatinate x and y
end

figure(1);
cmap=hsv(6);
for i=1:4
    sx=spline(1:length(trange),v0(1:length(trange),(i-1)*60+1:i*60)',1:.2:length(trange));
    sy=spline(1:length(trange),v0(length(trange)+1:end,(i-1)*60+1:i*60)',1:.2:length(trange));
    subplot(2,3,4); hold on;
    plot(sx','Color',cmap(i,:))
    xlim([1 length(sx')])
    ylim([-1 1])
    xlabel('Time')
    ylabel('Horizontal')
    subplot(2,3,5); hold on;
    plot(sy','Color',cmap(i,:))
    xlim([1 length(sx')])
    ylim([-1 1])
    xlabel('Time')
    ylabel('Vertical')
    subplot(2,3,6); hold on;
    plot(sx',sy','Color',cmap(i,:))
    axis image
    xlabel('Horizontal')
    ylabel('Vertical')
    xlim([-.8 .4])
    ylim([-.5 1.2])
end

[COEFF,SCORE,latent] = princomp(v0');
disp(sum(latent(1:2))/sum(latent))

for i=1:size(v0,2)
    p1(i)=dot(v0(:,i),COEFF(:,1))/norm(COEFF(:,1));
    p2(i)=dot(v0(:,i),COEFF(:,2))/norm(COEFF(:,2));
end

figure(2);
h3=subplot(2,2,3);
hold on
cmap=hsv(6);
for i=1:4
    DarkShades=[linspace(cmap(i,1), 0, 10)' linspace(cmap(i,2), 0, 10)' linspace(cmap(i,3), 0, 10)'];
    plot(p1((i-1)*60+1:i*60-30),p2((i-1)*60+1:i*60-30),'.','Color',DarkShades(5,:));
    LightShades=[linspace(cmap(i,1), 1, 10)' linspace(cmap(i,2), 1, 10)' linspace(cmap(i,3), 1, 10)'];
    plot(p1((i-1)*60+31:i*60),p2((i-1)*60+31:i*60),'.','Color',LightShades(5,:));
end
set(gca,'Box','on','XTick',[],'YTick',[])
title(h3,'Alternative Paw - Control')
xlabel('PC 1')
ylabel('PC 2')

h4=subplot(2,2,4);
hold on
cmap=hsv(6);
for i=1:4
    DarkShades=[linspace(cmap(i,1), 0, 10)' linspace(cmap(i,2), 0, 10)' linspace(cmap(i,3), 0, 10)'];
    plot(p1((i-1)*60+241:i*60+210),p2((i-1)*60+241:i*60+210),'.','Color',DarkShades(5,:));
    LightShades=[linspace(cmap(i,1), 1, 10)' linspace(cmap(i,2), 1, 10)' linspace(cmap(i,3), 1, 10)'];
    plot(p1((i-1)*60+271:i*60+240),p2((i-1)*60+271:i*60+240),'.','Color',LightShades(5,:));
end
set(gca,'Box','on','XTick',[],'YTick',[])
title(h4,'Alternative Paw - Contralateral Lesion')
xlabel('PC 1')
ylabel('PC 2')

legend_handle=legend('Burkina Faso','Burundi','Cameroon','Anna','Stuart');
legend_markers = findobj(get(legend_handle, 'Children'), ...
    'Type', 'line', '-and', '-not', 'Marker', 'none');
for i = 1:length(legend_markers)
    set(legend_markers(i), 'Color', cmap(6-i,:));
end 