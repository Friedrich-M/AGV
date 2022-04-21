%得到转弯次数矩阵
function [T,N] = GetTrastion(X,Y,sp)
% X Y路径栅格坐标矩阵   
% sp 路径集合矩阵
% T 每条路径转弯次数矩阵 
% N 每条路径转弯栅格记录矩阵
 n = size(X,1);
 T = [ ];
 N = [ ];
 for i=1:n
     m = 1;
     T(1,i) = 0;
     q = size(X(i,:),2);
     for j = 3:q
         y1 = Y(i,j)-Y(i,j-1);
         x1 = X(i,j)-X(i,j-1);
         y2 = Y(i,j-1)-Y(i,j-2);
         x2 = X(i,j-1)-X(i,j-2);
         k1 = y1/x1;  %斜率K1
         k2 = y2/x2;  %斜率K2
         if(k1~=k2)   %斜率不同转弯次数+1
             T(1,i) = T(1,i)+1;
             N(i,m) = sp{i}(j-1);
             m = m+1;
         else
             T(1,i) = T(1,i);
         end
     end
 end
 end
