function mytestfunction()
f=figure;
set(f,'WindowButtonDownFcn',@mytestcallback)

function mytestcallback(hObject,eventdata,handles)
pos=get(hObject,'CurrentPoint');
disp(['You clicked X:',num2str(pos(1)),', Y:',num2str(pos(2))]);
