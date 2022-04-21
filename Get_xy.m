function [X,Y]=Get_xy(spcost,sp,map)
 % spcost 距离值  % sp  路径矩阵  % map 地图矩阵 
 if(spcost<999)                   %是否为不可达路径
     n = size(map);
     z = size(sp,1);               %路径条数
     for r=1:z
      M = size(sp{r,1},2);         %每条路径的路径点数    
      for m=1:M                  
       if rem(sp{r,1}(m),n(2))==0
         X(r,m)=n(2);
         Y(r,m)= floor(sp{r,1}(m)/n(2));
       else
         X(r,m)= rem(sp{r,1}(m),n(2));
         Y(r,m)= floor(sp{r,1}(m)/n(2))+1;
       end
      end
     end
  else                         
    X = 0;
    Y = 0;
 end
end