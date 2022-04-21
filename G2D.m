%%%%%%%%%%%%%%%%%%%%%%%%得到环境地图的邻接矩阵%%%%%%%%%%%%%%%%%%%%%%
function W=G2D(map)
% map 地图矩阵
l=size(map);
W=zeros(l(1)*l(2),l(1)*l(2));   %设置邻接矩阵的大小（行列数）
for i=1:l(1)
    for j=1:l(2)
        if map(i,j)==0
            for m=1:l(1)
                for n=1:l(2)
                    if map(m,n)==0
                        im=abs(i-m);
                        jn=abs(j-n);
                        if im+jn==1||(im==1&&jn==1)
                        W((i-1)*l(2)+j,(m-1)*l(2)+n)=(im+jn)^0.5;
                        end
                    end
                end
            end
        end
    end
end
end