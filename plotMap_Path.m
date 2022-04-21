%画出环境地图及路径
function plotMap_Path(map,spcost,OUT,P,X,Y,C,I)
% map 地图矩阵
% P   路径索引矩阵
% spcost 路径距离值
% OUT 路径索引标识
% X Y 路径坐标矩阵
n = size(map);
step = 1;
a = 0 : step :n(1);
b = 0 : step :n(2);
figure(1)
axis([0 n(2) 0 n(1)]); %设置地图横纵尺寸
set(gca,'xtick',b,'ytick',a,'GridLineStyle','-',...
'xGrid','on','yGrid','on');
hold on
r = 1;
for(i=1:n(1))         %设置障碍物的左下角点的x,y坐标
    for(j=1:n(2))
        if(map(i,j)==1)
            p(r,1)=j-1;
            p(r,2)=i-1;
            fill([p(r,1) p(r,1) + step p(r,1) + step p(r,1)],...
                 [p(r,2) p(r,2) p(r,2) + step p(r,2) + step ],'k');
            r=r+1;
            hold on
        end
    end
end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%栅格数字标识%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_text = 1:1:n(1)*n(2); %产生所需数值.
for i = 1:1:n(1)*n(2)
    [row,col] = ind2sub([n(2),n(1)],i);
    text(row-0.9,col-0.5,num2str(x_text(i)),'FontSize',8,'Color','0.7 0.7 0.7');
end
hold on
axis square
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%栅画出栅格时标及路径%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
if(spcost<999)    %判断是否为可达路径
      place = 0.6-0.03*I;
      plot(X(P(OUT(1)),:)-place,Y(P(OUT(1)),:)-place,'Color',C(I-1,:),'LineWidth',2);%画出路径
      hold on
%       if I==2   %画出时标
%           q = size(TW,2)-1;
%          for z=1:q    
%           text(X(P(OUT),z)-0.98,Y(P(OUT),z)-0.05,num2str(TW(OUT,z)),'Fontsize',8,'Color',C(I-1,:));
%           text(X(P(OUT),z)-0.9,Y(P(OUT),z)-0.18,'|','Fontsize',8,'Color','k');
%           text(X(P(OUT),z)-0.98,Y(P(OUT),z)-0.35,num2str(TW(OUT,z+1)),'Fontsize',8,'Color',C(I-1,:));
%          end
%          hold on
%       else
%           q = size(TW(OUT,:),2)-1;
%          for z=1:q
%           text(X(P(OUT),z)-0.98,Y(P(OUT),z)-0.65,num2str(TW(OUT,z)),'Fontsize',8,'Color',C(I-1,:));
%           text(X(P(OUT),z)-0.9,Y(P(OUT),z)-0.77,'|','Fontsize',8,'Color','k');
%           text(X(P(OUT),z)-0.98,Y(P(OUT),z)-0.9,num2str(TW(OUT,z+1)),'Fontsize',8,'Color',C(I-1,:));
%          end
%          hold on
%       end
 else
    error('路径不可达');
end

end
