function [id ix iy]=TrajSem(x,y,t0)
d=cumsum([0; sqrt(diff(x).^2+diff(y).^2)]);
d0=d(t0);
[ud ia ic]=unique(d);
ux=x(ia);
uy=y(ia);
len=round(max(ud));
ix=interp1(ud,ux,0:len,'pchip');
iy=interp1(ud,uy,0:len,'pchip');
id=(0:len)-d0;

% 
% figure
% subplot(1,3,1)
% hold on
% plot(ix,'-r')
% plot(iy,'-b')
% subplot(1,3,2)
% hold on
% plot(x,'-r')
% plot(y,'-b')
% subplot(1,3,3)
% hold on
% plot(ix,iy,'-r')
% plot(x,y,'-b')