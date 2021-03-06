% close all
% clear all
% t0=33;
% 
% % BurkinaFaso
% rat='BurkinaFaso';
% condition={'Pre-mock','Mock','Pre-contra','Contra','Pre-ipsi','Ipsi'};
% exptID={370,424,424,444,468,477};
% trial=[4353 4374 4381 4393 4394 4401 4449 4453 4456 4514 4529 4547 4570 4572 4597,...
%     4642 4712 4732 4739 4756 4785 4786 4791 4825 4850 4658 4665 4667 4681 4796;...
%     1127 1146 1179 1252 1268 1420 1457 1476 1479 1532 1536 1602 1639 1719 1742,...
%     1790 1805 1806 1827 1861 1902 1941 1957 1966 1973 1996 2033 2037 2038 2052;...
%     4280 4281 4291 4306 4307 4311 4341 4398 4399 4406 4490 4507 4520 4542 4550,...
%     4589 4597 4602 4605 4632 4637 4667 4672 4728 4729 4731 4740 4744 4749 4761;...
%     885 886 915 928 936 956 957 972 974 985 986 1003 1010 1039 1040,...
%     1134 1136 1143 1144 1161 1162 1165 1198 1199 1200 1206 1224 1225 1226 1237;...
%     3359 3366 3389 3405 3428 3442 3446 3451 3461 3472 3529 3549 3556 3597 3528,...
%     3645 3805 3809 3871 3876 3961 3993 4016 4035 4045 4086 4094 4104 4110 4120;...
%     899 1058 1064 1111 1147 1183 1186 1206 1237 1243 1255 1266 1267 1309 1350,...
%     1372 1382 1383 1414 1418 1419 1430 1486 1519 1543 1545 1560 1563 1603 1638]';
% BF=LoadTraj(rat,condition,exptID,trial,t0);
% 
% shade=[1 .2];
% c1=[0 0 1];
% c2=[1 0 0];
% 
% figure(1)
% for i=1:3
%     subplot(3,3,(i-1)*3+1)
%     hold on
%     for t=1:size(trial,1)
%         plot(BF((i-1)*2+1,t).ch1(:,1),'color',c1*shade(1));
%         plot(200+BF((i-1)*2+1,t).ch1(:,2),'color',c2*shade(1));
%         plot(BF((i-1)*2+2,t).ch1(:,1),'color',c1*shade(2));
%         plot(200+BF((i-1)*2+2,t).ch1(:,2),'color',c2*shade(2));
%     end
%     subplot(3,3,(i-1)*3+2)
%     hold on
%     for t=1:size(trial,1)
%         plot(BF((i-1)*2+1,t).ch2(:,1),'color',c1*shade(1));
%         plot(200+BF((i-1)*2+1,t).ch2(:,2),'color',c2*shade(1));
%         plot(BF((i-1)*2+2,t).ch2(:,1),'color',c1*shade(2));
%         plot(200+BF((i-1)*2+2,t).ch2(:,2),'color',c2*shade(2));
%     end
%     subplot(3,3,(i-1)*3+3)
%     hold on
%     for t=1:size(trial,1)
%         if min(BF(2,t).ch3(:,2))<10
%             disp(trial(t,2))
%         end
%         plot(BF((i-1)*2+1,t).ch3(:,1),'color',c1*shade(1));
%         plot(200+BF((i-1)*2+1,t).ch3(:,2),'color',c2*shade(1));
%         plot(BF((i-1)*2+2,t).ch3(:,1),'color',c1*shade(2));
%         plot(200+BF((i-1)*2+2,t).ch3(:,2),'color',c2*shade(2));
%     end
% end
% 
% x=[];
% y=[];
% count=1;
% 
% figure(2)
% for i=1:3
%     subplot(3,3,(i-1)*3+1)
%     hold on
%     for t=1:size(trial,1)
%         [id ix iy]=TrajSem(BF((i-1)*2+1,t).ch1(:,1),BF((i-1)*2+1,t).ch1(:,2),t0);
%         plot(id,ix,'color',c1*shade(1));
%         plot(id,200+iy,'color',c2*shade(1));
%         d{count}=id';
%         x{count}=ix';
%         y{count}=iy';
%         count=count+1;
%         [id ix iy]=TrajSem(BF((i-1)*2+2,t).ch1(:,1),BF((i-1)*2+2,t).ch1(:,2),t0);
%         plot(id,ix,'color',c1*shade(2));
%         plot(id,200+iy,'color',c2*shade(2));
%         d{count}=id';
%         x{count}=ix';
%         y{count}=iy';
%         count=count+1;
%     end
%     subplot(3,3,(i-1)*3+2)
%     hold on
%     for t=1:size(trial,1)
%         [id ix iy]=TrajSem(BF((i-1)*2+1,t).ch2(:,1),BF((i-1)*2+1,t).ch2(:,2),t0);
%         plot(id,ix,'color',c1*shade(1));
%         plot(id,200+iy,'color',c2*shade(1));
%         x(count,:)=interp1(id,ix,-301:500);
%         y(count,:)=interp1(id,iy,-301:500);
%         count=count+1;
%         [id ix iy]=TrajSem(BF((i-1)*2+2,t).ch2(:,1),BF((i-1)*2+2,t).ch2(:,2),t0);
%         plot(id,ix,'color',c1*shade(2));
%         plot(id,200+iy,'color',c2*shade(2));
%         x(count,:)=interp1(id,ix,-301:500);
%         y(count,:)=interp1(id,iy,-301:500);
%         count=count+1;
%     end
%     subplot(3,3,(i-1)*3+3)
%     hold on
%     for t=1:size(trial,1)
%         [id ix iy]=TrajSem(BF((i-1)*2+1,t).ch3(:,1),BF((i-1)*2+1,t).ch3(:,2),t0);
%         plot(id,ix,'color',c1*shade(1));
%         plot(id,200+iy,'color',c2*shade(1));
%         d{count}=id';
%         x{count}=ix';
%         y{count}=iy';
%         count=count+1;
%         [id ix iy]=TrajSem(BF((i-1)*2+2,t).ch3(:,1),BF((i-1)*2+2,t).ch3(:,2),t0);
%         plot(id,ix,'color',c1*shade(2));
%         plot(id,200+iy,'color',c2*shade(2));
%         d{count}=id';
%         x{count}=ix';
%         y{count}=iy';
%         count=count+1;
%     end
% end
% 
% 
% figure(3)
% hold on
% for t=1:30
%     plot(BF(6,t).ch1(:,2),'-b')
% end
% 
% 
% % Burundi
% 
% rat='Burundi';
% condition={'Pre-mock','Mock','Pre-contra','Contra'};
% exptID={405,436,436,452};
% trial=[1363 1402 1406 1412 1437 1466 1527 1613 1618 1668 1690 1719 1722 1726 1736,...
%     1786 1843 1869 1969 1979 2031 2043 2070 2096 2154 2167 2171 2173 2188 2207;...
%     1048 1060 1135 1147 1158 1175 1180 1230 1244 1253 1270 1276 1285 1302 1308,...
%     1380 1381 1386 1396 1400 1405 1414 1427 1429 1436 1464 1467 1476 1481 1488;...
%     4195 4204 4205 4222 4226 4244 4247 4258 4291 4298 4303 4319 4321 4334 4347,...
%     4370 4382 4387 4407 4410 4414 4417 4421 4437 4443 4445 4450 4473 4478 4481;...
%     2317 2321 2364 2367 2373 2375 2389 2400 2436 2445 2518 2607 2627 2633 2685,...
%     2697 2728 2737 2746 2767 2775 2788 2822 2831 2855 2879 2881 2908 2952 2957;]';
% Burundi=LoadTraj(rat,condition,exptID,trial,t0);
% 
% shade=[1 .2];
% c1=[0 0 1];
% c2=[1 0 0];
% 
% figure(3)
% for i=1:2
%     subplot(2,2,(i-1)*2+1)
%     hold on
%     for t=1:size(trial,1)
%         plot(Burundi((i-1)*2+1,t).ch1(:,1),'color',c1*shade(1));
%         plot(300+Burundi((i-1)*2+1,t).ch1(:,2),'color',c2*shade(1));
%         plot(Burundi((i-1)*2+2,t).ch1(:,1),'color',c1*shade(2));
%         plot(300+Burundi((i-1)*2+2,t).ch1(:,2),'color',c2*shade(2));
%     end
%     subplot(2,2,(i-1)*2+2)
%     hold on
%     for t=1:size(trial,1)
%         plot(Burundi((i-1)*2+1,t).ch3(:,1),'color',c1*shade(1));
%         plot(300+Burundi((i-1)*2+1,t).ch3(:,2),'color',c2*shade(1));
%         plot(Burundi((i-1)*2+2,t).ch3(:,1),'color',c1*shade(2));
%         plot(300+Burundi((i-1)*2+2,t).ch3(:,2),'color',c2*shade(2));
%     end
% end
% 
% figure(4)
% for i=1:2
%     subplot(2,2,(i-1)*2+1)
%     hold on
%     for t=1:size(trial,1)
%         [id ix iy]=TrajSem(Burundi((i-1)*2+1,t).ch1(:,1),Burundi((i-1)*2+1,t).ch1(:,2),t0);
%         plot(id,ix,'color',c1*shade(1));
%         plot(id,300+iy,'color',c2*shade(1));
%         [id ix iy]=TrajSem(Burundi((i-1)*2+2,t).ch1(:,1),Burundi((i-1)*2+2,t).ch1(:,2),t0);
%         plot(id,ix,'color',c1*shade(2));
%         plot(id,300+iy,'color',c2*shade(2));
%     end
%     subplot(2,2,(i-1)*2+2)
%     hold on
%     for t=1:size(trial,1)
%         [id ix iy]=TrajSem(Burundi((i-1)*2+1,t).ch3(:,1),Burundi((i-1)*2+1,t).ch3(:,2),t0);
%         plot(id,ix,'color',c1*shade(1));
%         plot(id,300+iy,'color',c2*shade(1));
%         [id ix iy]=TrajSem(Burundi((i-1)*2+2,t).ch3(:,1),Burundi((i-1)*2+2,t).ch3(:,2),t0);
%         plot(id,ix,'color',c1*shade(2));
%         plot(id,300+iy,'color',c2*shade(2));
%     end
% end
% 
% % Cameroon
% 
% rat='Cameroon';
% condition={'Pre-mock','Mock','Pre-contra','Contra'};
% exptID={[438 425],443 443,469};
% trial=[12 18 31 90 103 105 107 135 148 162 174 178 198 203 278,...
%     3530 3538 3614 3620 3626 3651 3666 3673 3680 3686 3727 3833 3839 3859 3874;...
%     994 998 1066 1144 1152 1156 1172 1179 1191 1247 1251 1266 1304 1307 1310,...
%     1356 1389 1391 1422 1432 1439 1444 1456 1495 1523 1541 1587 1596 1598 1622;...
%     5314 5325 5332 5337 5366 5374 5376 5389 5412 5450 5453 5466 5467 5473 5474,...
%     5490 5491 5495 5501 5509 5513 5518 5523 5540 5616 5617 5625 5626 5628 5629;...
%     1107 1182 1196 1200 1311 1357 1367 1370 1373 1379 1420 1431 1465 1470 1471,...
%     1491 1493 1506 1514 1520 1525 1554 1576 1584 1602 1619 1632 1639 1647 1679;]';
% Cameroon=LoadTraj(rat,condition,exptID,trial,t0);
% 
% shade=[1 .2];
% c1=[0 0 1];
% c2=[1 0 0];
% 
% figure(5)
% for i=1:2
%     subplot(2,3,(i-1)*3+1)
%     hold on
%     for t=1:size(trial,1)
%         plot(Cameroon((i-1)*2+1,t).ch1(:,1),'color',c1*shade(1));
%         plot(500+Cameroon((i-1)*2+1,t).ch1(:,2),'color',c2*shade(1));
%         plot(Cameroon((i-1)*2+2,t).ch1(:,1),'color',c1*shade(2));
%         plot(500+Cameroon((i-1)*2+2,t).ch1(:,2),'color',c2*shade(2));
%     end
%     subplot(2,3,(i-1)*3+2)
%     hold on
%     for t=1:size(trial,1)
%         plot(Cameroon((i-1)*2+1,t).ch2(:,1),'color',c1*shade(1));
%         plot(500+Cameroon((i-1)*2+1,t).ch2(:,2),'color',c2*shade(1));
%         plot(Cameroon((i-1)*2+2,t).ch2(:,1),'color',c1*shade(2));
%         plot(500+Cameroon((i-1)*2+2,t).ch2(:,2),'color',c2*shade(2));
%     end
%     subplot(2,3,(i-1)*3+3)
%     hold on
%     for t=1:size(trial,1)
%         plot(Cameroon((i-1)*2+1,t).ch3(:,1),'color',c1*shade(1));
%         plot(500+Cameroon((i-1)*2+1,t).ch3(:,2),'color',c2*shade(1));
%         plot(Cameroon((i-1)*2+2,t).ch3(:,1),'color',c1*shade(2));
%         plot(500+Cameroon((i-1)*2+2,t).ch3(:,2),'color',c2*shade(2));
%     end
% end
% 
% figure(6)
% for i=1:2
%     subplot(2,3,(i-1)*3+1)
%     hold on
%     for t=1:size(trial,1)
%         [id ix iy]=TrajSem(Cameroon((i-1)*2+1,t).ch1(:,1),Cameroon((i-1)*2+1,t).ch1(:,2),t0);
%         plot(id,ix,'color',c1*shade(1));
%         plot(id,500+iy,'color',c2*shade(1));
%         [id ix iy]=TrajSem(Cameroon((i-1)*2+2,t).ch1(:,1),Cameroon((i-1)*2+2,t).ch1(:,2),t0);
%         plot(id,ix,'color',c1*shade(2));
%         plot(id,500+iy,'color',c2*shade(2));
%     end
%     subplot(2,3,(i-1)*3+2)
%     hold on
%     for t=1:size(trial,1)
%         [id ix iy]=TrajSem(Cameroon((i-1)*2+1,t).ch2(:,1),Cameroon((i-1)*2+1,t).ch2(:,2),t0);
%         plot(id,ix,'color',c1*shade(1));
%         plot(id,500+iy,'color',c2*shade(1));
%         [id ix iy]=TrajSem(Cameroon((i-1)*2+2,t).ch2(:,1),Cameroon((i-1)*2+2,t).ch2(:,2),t0);
%         plot(id,ix,'color',c1*shade(2));
%         plot(id,500+iy,'color',c2*shade(2));
%     end
%     subplot(2,3,(i-1)*3+3)
%     hold on
%     for t=1:size(trial,1)
%         [id ix iy]=TrajSem(Cameroon((i-1)*2+1,t).ch3(:,1),Cameroon((i-1)*2+1,t).ch3(:,2),t0);
%         plot(id,ix,'color',c1*shade(1));
%         plot(id,500+iy,'color',c2*shade(1));
%         [id ix iy]=TrajSem(Cameroon((i-1)*2+2,t).ch3(:,1),Cameroon((i-1)*2+2,t).ch3(:,2),t0);
%         plot(id,ix,'color',c1*shade(2));
%         plot(id,500+iy,'color',c2*shade(2));
%     end
% end
% 
% % Brazil
% 
% rat='Brazil';
% condition={'Pre-mock','Mock','Pre-contra','Contra'};
% exptID={266,309};
% trial=[7385 7393 7400 7449 7463 7486 7496 7497 7513 7516 7528 7542 7544 7554 7557,...
%     7615 7617 7649 7709 7715 7721 7732 7786 7786 7787 7798 7821 7908 7918 7927;...
%     3615 3669 3672 3682 3697 3724 3730 3737 3752 3772 3790 3831 3846 3875 3876,...
%     3882 3897 3900 3902 3913 3933 3961 4002 4013 4017 4030 4058 4067 4090 4148]';
% Brazil=LoadTraj(rat,condition,exptID,trial,t0);
% 
% shade=[1 .2];
% c1=[0 0 1];
% c2=[1 0 0];
% 
% figure(7)
% for i=1
%     subplot(1,3,(i-1)*3+1)
%     hold on
%     for t=1:size(trial,1)
%         plot(Brazil((i-1)*2+1,t).ch1(:,1),'color',c1*shade(1));
%         plot(500+Brazil((i-1)*2+1,t).ch1(:,2),'color',c2*shade(1));
%         plot(Brazil((i-1)*2+2,t).ch1(:,1),'color',c1*shade(2));
%         plot(500+Brazil((i-1)*2+2,t).ch1(:,2),'color',c2*shade(2));
%     end
%     subplot(1,3,(i-1)*3+2)
%     hold on
%     for t=1:size(trial,1)
%         plot(Brazil((i-1)*2+1,t).ch2(:,1),'color',c1*shade(1));
%         plot(500+Brazil((i-1)*2+1,t).ch2(:,2),'color',c2*shade(1));
%         plot(Brazil((i-1)*2+2,t).ch2(:,1),'color',c1*shade(2));
%         plot(500+Brazil((i-1)*2+2,t).ch2(:,2),'color',c2*shade(2));
%     end
%     subplot(1,3,(i-1)*3+3)
%     hold on
%     for t=1:size(trial,1)
%         plot(Brazil((i-1)*2+1,t).ch3(:,1),'color',c1*shade(1));
%         plot(500+Brazil((i-1)*2+1,t).ch3(:,2),'color',c2*shade(1));
%         plot(Brazil((i-1)*2+2,t).ch3(:,1),'color',c1*shade(2));
%         plot(500+Brazil((i-1)*2+2,t).ch3(:,2),'color',c2*shade(2));
%     end
% end
% 
% figure(8)
% for i=1
%     subplot(1,3,(i-1)*3+1)
%     hold on
%     for t=1:size(trial,1)
%         [id ix iy]=TrajSem(Brazil((i-1)*2+1,t).ch1(:,1),Brazil((i-1)*2+1,t).ch1(:,2),t0);
%         plot(id,ix,'color',c1*shade(1));
%         plot(id,500+iy,'color',c2*shade(1));
%         [id ix iy]=TrajSem(Brazil((i-1)*2+2,t).ch1(:,1),Brazil((i-1)*2+2,t).ch1(:,2),t0);
%         plot(id,ix,'color',c1*shade(2));
%         plot(id,500+iy,'color',c2*shade(2));
%     end
%     subplot(1,3,(i-1)*3+2)
%     hold on
%     for t=1:size(trial,1)
%         [id ix iy]=TrajSem(Brazil((i-1)*2+1,t).ch2(:,1),Brazil((i-1)*2+1,t).ch2(:,2),t0);
%         plot(id,ix,'color',c1*shade(1));
%         plot(id,500+iy,'color',c2*shade(1));
%         [id ix iy]=TrajSem(Brazil((i-1)*2+2,t).ch2(:,1),Brazil((i-1)*2+2,t).ch2(:,2),t0);
%         plot(id,ix,'color',c1*shade(2));
%         plot(id,500+iy,'color',c2*shade(2));
%     end
%     subplot(1,3,(i-1)*3+3)
%     hold on
%     for t=1:size(trial,1)
%         [id ix iy]=TrajSem(Brazil((i-1)*2+1,t).ch3(:,1),Brazil((i-1)*2+1,t).ch3(:,2),t0);
%         plot(id,ix,'color',c1*shade(1));
%         plot(id,500+iy,'color',c2*shade(1));
%         [id ix iy]=TrajSem(Brazil((i-1)*2+2,t).ch3(:,1),Brazil((i-1)*2+2,t).ch3(:,2),t0);
%         plot(id,ix,'color',c1*shade(2));
%         plot(id,500+iy,'color',c2*shade(2));
%     end
% end

t0=33;
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



%% 2D Trajectories
trange=20:75;
xBF={[],[],[]};
yBF={[],[],[]};
n=round(size(BF,2)/2);

for i=1:2
    for j=1:2*n
        for ch=1:3
            eval(['xBF{ch}=[xBF{ch} smooth(BF(i,j).ch' num2str(ch) '(trange,1),4)];'])
            eval(['yBF{ch}=[yBF{ch} smooth(BF(i,j).ch' num2str(ch) '(trange,2),4)];'])
        end
    end
end

figure
for ch=1:3
    subplot(2,3,ch)
    hold on
    plot(xBF{ch}(:,1:2*n),-yBF{ch}(:,1:2*n),'-b')
    plot(xBF{ch}(:,2*n+1:4*n),-yBF{ch}(:,2*n+1:4*n),'-r')
    set(gca,'xtick',[],'ytick',[],'box','on')
    if ch==1
        set(gca,'xlim',[-100 20],'ylim',[-20 80])
    elseif ch==2
        set(gca,'xlim',[-100 200],'ylim',[-300 100])
    else
        set(gca,'xlim',[-80 80],'ylim',[-200 100])
    end
    subplot(2,3,ch+3)
    hold on
    plot(mean(xBF{ch}(:,1:2*n),2),mean(-yBF{ch}(:,1:2*n),2),'-b')
    plot(mean(xBF{ch}(:,2*n+1:4*n),2),mean(-yBF{ch}(:,2*n+1:4*n),2),'-r')
    set(gca,'xtick',[],'ytick',[],'box','on')
    if ch==1
        set(gca,'xlim',[-100 20],'ylim',[-20 80])
    elseif ch==2
        set(gca,'xlim',[-100 200],'ylim',[-300 100])
    else
        set(gca,'xlim',[-80 80],'ylim',[-200 100])
    end
end

%% PCA I (performed independently)
trange=30:55;
p1=[];p2=[];

figure
cmap=hsv(4);
for ch=1:3
    for cor=1:2
        ey=[];
        for i=1:4
            for j=1:size(BF,2)
                eval(['ey=[ey BF(i,j).ch' num2str(ch) '(trange,cor)];'])
            end
        end
        for i=1:size(Burundi,1)
            for j=1:size(Burundi,2)
                eval(['ey=[ey Burundi(i,j).ch' num2str(ch) '(trange,cor)];'])
            end
        end
        for i=1:size(Cameroon,1)
            for j=1:size(Cameroon,2)
                eval(['ey=[ey Cameroon(i,j).ch' num2str(ch) '(trange,cor)];'])
            end
        end
        for i=1:size(Brazil,1)
            for j=1:size(Brazil,2)
                eval(['ey=[ey Brazil(i,j).ch' num2str(ch) '(trange,cor)];'])
            end
        end
        
        [COEFF,SCORE,latent] = princomp(ey');
%         disp(sum(latent(1:2))/sum(latent))
        for i=1:size(ey,2)
            p1(i)=dot(ey(:,i),COEFF(:,1))/norm(COEFF(:,1));
            p2(i)=dot(ey(:,i),COEFF(:,2))/norm(COEFF(:,2));
        end
        
        subplot(2,3,ch+3*(cor-1))
        hold on
        for i=1:3
            plot(p1((i-1)*120+1:i*120),p2((i-1)*120+1:i*120),'.','Color',cmap(i,:));
%             DarkShades=[linspace(cmap(i,1), 0, 10)' linspace(cmap(i,2), 0, 10)' linspace(cmap(i,3), 0, 10)'];
%             LightShades=[linspace(cmap(i,1), 1, 10)' linspace(cmap(i,2), 1, 10)' linspace(cmap(i,3), 1, 10)'];
%             plot(p1((i-1)*120+1:i*120-90),p2((i-1)*120+1:i*120-90),'.','Color',DarkShades(5,:));
%             plot(p1((i-1)*120+31:i*120-60),p2((i-1)*120+31:i*120-60),'.','Color',LightShades(5,:));
        end
%         plot(p1(241:end),p2(241:end),'.','Color',cmap(4,:));
        plot(p1(361:end),p2(361:end),'.','Color',cmap(4,:));
        set(gca,'Box','on','XTick',[],'YTick',[])
    end
end

legend('BurkinaFaso','Burundi','Cameroon','Brazil')

%% PCA II (alternative formulation)
trange=30:55;
v0=[];
p1=[];p2=[];

for ch=1
    for cor=1:2
        ey=[];
        for i=1:4
            for j=1:size(BF,2)
                eval(['ey=[ey BF(i,j).ch' num2str(ch) '(trange,cor)];'])
            end
        end
        for i=1:size(Burundi,1)
            for j=1:size(Burundi,2)
                eval(['ey=[ey Burundi(i,j).ch' num2str(ch) '(trange,cor)];'])
            end
        end
        for i=1:size(Cameroon,1)
            for j=1:size(Cameroon,2)
                eval(['ey=[ey Cameroon(i,j).ch' num2str(ch) '(trange,cor)];'])
            end
        end
        for i=1:size(Brazil,1)
            for j=1:size(Brazil,2)
                eval(['ey=[ey Brazil(i,j).ch' num2str(ch) '(trange,cor)];'])
            end
        end
        v0=[v0; ey];
    end
end


[COEFF,SCORE,latent] = princomp(v0');
% disp(sum(latent(1:2))/sum(latent))

for i=1:size(v0,2)
    p1(i)=dot(v0(:,i),COEFF(:,1))/norm(COEFF(:,1));
    p2(i)=dot(v0(:,i),COEFF(:,2))/norm(COEFF(:,2));
end

figure
hold on
cmap=hsv(4);
for i=1:3
    plot(p1((i-1)*120+1:i*120),p2((i-1)*120+1:i*120),'.','Color',cmap(i,:));
end
plot(p1(361:end),p2(361:end),'.','Color',cmap(4,:));
set(gca,'Box','on','XTick',[],'YTick',[])
legend('BurkinaFaso','Burundi','Cameroon','Brazil')



%% PCA IIIa (dominant paw; pre-post lesion with different shade)
close all
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
    [296.06 271.22 0 132.47;...
    294.30 272.09 0 133.35],...
    [294.30 271.22 0 122.82;...
    296.06 271.22 0 136.86]};

trange=26:60;
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
    v0=[v0; traj]; % concatinate x and y
end

figure(1);
cmap=hsv(4);
for i=1:3
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
h1=subplot(2,2,1);
hold on
cmap=hsv(4);
for i=1:3
    DarkShades=[linspace(cmap(i,1), 0, 10)' linspace(cmap(i,2), 0, 10)' linspace(cmap(i,3), 0, 10)'];
    plot(p1((i-1)*60+1:i*60-30),p2((i-1)*60+1:i*60-30),'.','Color',DarkShades(5,:));
    LightShades=[linspace(cmap(i,1), 1, 10)' linspace(cmap(i,2), 1, 10)' linspace(cmap(i,3), 1, 10)'];
    plot(p1((i-1)*60+31:i*60),p2((i-1)*60+31:i*60),'.','Color',LightShades(5,:));
end
set(gca,'Box','on','XTick',[],'YTick',[])
title(h1,'Alternative Paw - Control')
xlabel('PC 1')
ylabel('PC 2')

h2=subplot(2,2,2);
hold on
cmap=hsv(4);
for i=1:3
    DarkShades=[linspace(cmap(i,1), 0, 10)' linspace(cmap(i,2), 0, 10)' linspace(cmap(i,3), 0, 10)'];
    plot(p1((i-1)*60+181:i*60+150),p2((i-1)*60+181:i*60+150),'.','Color',DarkShades(5,:));
    LightShades=[linspace(cmap(i,1), 1, 10)' linspace(cmap(i,2), 1, 10)' linspace(cmap(i,3), 1, 10)'];
    plot(p1((i-1)*60+211:i*60+180),p2((i-1)*60+211:i*60+180),'.','Color',LightShades(5,:));
end
set(gca,'Box','on','XTick',[],'YTick',[])
title(h2,'Alternative Paw - Contralateral Lesion')
xlabel('PC 1')
ylabel('PC 2')

%% PCA IIIb (alternative paw; pre-post lesion with different shades)
trange=26:60;
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
    v0=[v0; traj]; % concatinate x and y
end

figure(1);
cmap=hsv(4);
for i=1:3
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
cmap=hsv(4);
for i=1:3
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
cmap=hsv(4);
for i=1:3
    DarkShades=[linspace(cmap(i,1), 0, 10)' linspace(cmap(i,2), 0, 10)' linspace(cmap(i,3), 0, 10)'];
    plot(p1((i-1)*60+181:i*60+150),p2((i-1)*60+181:i*60+150),'.','Color',DarkShades(5,:));
    LightShades=[linspace(cmap(i,1), 1, 10)' linspace(cmap(i,2), 1, 10)' linspace(cmap(i,3), 1, 10)'];
    plot(p1((i-1)*60+211:i*60+180),p2((i-1)*60+211:i*60+180),'.','Color',LightShades(5,:));
end
set(gca,'Box','on','XTick',[],'YTick',[])
title(h4,'Alternative Paw - Contralateral Lesion')
xlabel('PC 1')
ylabel('PC 2')