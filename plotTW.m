%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%画出时间窗%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Q,I]=plotTW(map,TW,sp,OUT,P,Q,C,I)
% map  地图矩阵
% TW   时间窗矩阵
% P    路径索引矩阵
% sp   选择的路径矩阵
% OUT  路径索引标识
n = size(map);     %得到地图尺寸
Y = n(1)*n(2);
b = size(OUT,2);   %得到路径条数
y = 0:1:Y;
for i=1:b
    figure(i+Q)
    X = floor(max(TW(OUT,:)))+10;  %得到x轴长度
    x = 0:1:X;
    axis([0 X 0 Y]);              %得到时间窗窗口
    set(gca,'xtick',x,'ytick',y,'GridLineStyle','-',...
        'xGrid','on','yGrid','on');
    hold on
    m = length(sp{P(OUT(i))});      %得到每条路径的栅格点数
    for j=1:m
        t = sp{P(OUT(i))}(j);       %得到具体的栅格点
        fill([TW(i,j),TW(i,j),TW(i,j+1),TW(i,j+1)],[t-1,t,t,t-1],C(I,:));
        hold on
    xlabel(['time /s'],'Fontsize',14);
    ylabel(['栅格号'],'Fontsize',14);
    title(['AGV',num2str(I),' 时间窗'],'Fontsize',18);
    end
end
Q = Q+b;
I = I+1;
end
