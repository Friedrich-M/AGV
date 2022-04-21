%约束移动体在障碍栅格对角运动，通过优化邻接矩阵实现
%%%%%%%%%%%%%%%%%%%%% 约束AGV移动方式 %%%%%%%%%%%%%%%%%%%%%
function W=OPW(map,W)
% map 地图矩阵  % W 邻接矩阵
n = size(map);
num = n(1)*n(2);
for(j=1:n(1))
    for(z=1:n(2))
       if(map(j,z)==1)
          if(j==1)                  %若障碍物在第一行
             if(z==1)               %若障碍物为第一行的第一个
                W(j+1,j+n(2)*j)=Inf;
                W(j+n(2)*j,j+1)=Inf;
             else
                if(z==n(2))         %若障碍物为第一行的最后一个
                   W(n(2)-1,n(2)+n(1)*j)=Inf;
                   W(n(2)+n(1)*j,n(2)-1)=Inf;
                else                %若障碍物为第一行的其他
                    W(z-1,z+j*n(2))=Inf;
                    W(z+j*n(2),z-1)=Inf;
                    W(z+1,z+j*n(2))=Inf;
                    W(z+j*n(2),z+1)=Inf;
                end
             end
          end
          if(j==n(1))               %若障碍物在最后一行
             if(z==1)               %若障碍物为最后一行的第一个
                W(z+n(2)*(j-2),z+n(2)*(j-1)+1)=Inf;
                W(z+n(2)*(j-1)+1,z+n(2)*(j-2))=Inf;
             else
             if(z==n(2))            %若障碍物为最后一行的最后一个
                W(n(1)*n(2)-1,(n(1)-1)*n(2))=Inf;
                W((n(1)-1)*n(2),n(1)*n(2)-1)=Inf;
             else                   %若障碍物为最后一行的其他
                W((j-2)*n(2)+z,(j-1)*n(2)+z-1)=Inf;
                W((j-1)*n(2)+z-1,(j-2)*n(2)+z)=Inf;
                W((j-2)*n(2)+z,(j-1)*n(2)+z+1)=Inf;
                W((j-1)*n(2)+z+1,(j-2)*n(2)+z)=Inf;
             end
             end
          end
          if(z==1)              
             if(j~=1&&j~=n(1))       %若障碍物在第一列非边缘位置 
                W(z+(j-2)*n(2),z+1+(j-1)*n(2))=Inf;
                W(z+1+(j-1)*n(2),z+(j-2)*n(2))=Inf;
                W(z+1+(j-1)*n(2),z+j*n(2))=Inf;
                W(z+j*n(2),z+1+(j-1)*n(2))=Inf;
             end
          end
         if(z==n(2))
            if(j~=1&&j~=n(1))         %若障碍物在最后一列非边缘位置 
               W((j+1)*n(2),j*n(2)-1)=Inf;
               W(j*n(2)-1,(j+1)*n(2))=Inf;
               W(j*n(2)-1,(j-1)*n(2))=Inf;
               W((j-1)*n(2),j*n(2)-1)=Inf;
            end
         end
         if(j~=1&&j~=n(1)&&z~=1&&z~=n(2))   %若障碍物在非边缘位置
            W(z+(j-1)*n(2)-1,z+j*n(2))=Inf;
            W(z+j*n(2),z+(j-1)*n(2)-1)=Inf;
            W(z+j*n(2),z+(j-1)*n(2)+1)=Inf;
            W(z+(j-1)*n(2)+1,z+j*n(2))=Inf;
            W(z+(j-1)*n(2)-1,z+(j-2)*n(2))=Inf;
            W(z+(j-2)*n(2),z+(j-1)*n(2)-1)=Inf;
            W(z+(j-2)*n(2),z+(j-1)*n(2)+1)=Inf;
            W(z+(j-1)*n(2)+1,z+(j-2)*n(2))=Inf;
         end
       end
     end
   end
end