% 时间窗路径类型以及冲突检测 %
function [TW2,OUT,sp,P,spcos2,X2,Y2] = Detection_TW(map,SD2,P1,P2,sp1,sp2,spcos,X,Y,TW1,TW2)
% map 环境地图矩阵
% SD2  AGV2起止点 
% OUT 无冲突路径标识
% P1 AGV1路径索引矩阵
% P2 AGV2路径索引矩阵
% sp1 AGV1路径矩阵
% sp2 AGV2路径矩阵
% TW1 AGV1时间窗矩阵
% TW2 AGV2时间窗矩阵        
m = length(P2);                     %得到AGV2的可选择路径数
mark = 0;                           %冲突标志，0为无冲突
rol = 1;                            %无碰撞路径记录向量索引标志
record =  Inf(m,2);                 %无冲突路径用时记录矩阵
  %%%%%%%%%%%%%%%%%判断备用路径是否有无碰撞路径并选择%%%%%%%%%%%%%%%%%
 for i = 1:m                        %判断所有路径的时间窗是否冲突
     k = length(sp2{P2(i)});        %得到AGV2选择路径的栅格点数
     for j = 1:k                    %判断当前路径的时间窗是否冲突
         t = sp2{P2(i)}(j);         %遍历选择路径的经过的每个栅格
         [r,c] = find(sp1{P1(1)}==t); %选择路径的当前栅格是否存在于AGV1的路径
         if ~isempty(r)              %如果存在，时间窗冲突检测
             if TW2(i,j+1)<TW1(1,c)||TW2(i,j)>TW1(1,c+1)  %时间窗冲突检测
                  mark = 0;        
             else
                  mark = 1;
                 break;
             end
         end
     end
     if mark == 0
         record(rol,1) = i;  %记录当前无冲突的路径索引
         record(rol,2) = TW2(i,k+1); %记录当前无碰撞路径所用时间
         rol = rol+1;
     end
 end
 
 OUT = min(record(:,2));    %选取用时最少的无碰撞路径
 if OUT ~= Inf
    [R,C] = find(record(:,2)==OUT);
    OUT = record(R(1),1);   %得到无碰撞路径用时最少的第一条路径索引
    P = P2;
    sp = sp2;
    X2 = X;
    Y2 = Y;
    spcos2 = spcos;
 else
     OUT = 0;                            %可选路径索引标记,0表示无可用路径
 end
 
 if OUT==0                                         %若备用路径都存在冲突
   [DT]=DetermineType(P1,P2,sp1,sp2,TW1,TW2);      %判断冲突类型
   [TW2,TW_a,P_a,sp_a,spcost_a,X_a,Y_a,flag] = Get_waitTW(map,SD2,spcos,DT,P1,P2,sp1,sp2,TW1,TW2,X,Y);   %得到等待策略以及临时障碍点时间窗
   
      n2 = size(TW2,1);                 %判断两种策略的时间成本大小
      spend2 = zeros(1,n2);
      for z2 = 1:n2
          spend2(z2) = TW2(z2,end);
      end
      t2 = min(spend2);
   
   
      n_a = size(TW_a,1);
      spend_a = zeros(1,n_a);
      for z_a = 1:n_a
          spend_a(z_a) = TW_a(z_a,end);
      end
      t_a = min(spend_a);
   if flag == 0                       %包含类相遇，无法采用等待策略
      if t_a < t2                     %若临时障碍点策略时间成本小于等待策略
         x = find(spend_a==min(spend_a));
         OUT = x;
         P = P_a;
         sp = sp_a;
         TW2 = TW_a;
         X2  = X_a;
         Y2  = Y_a;
         spcos2 = spcost_a;
      else                            %若临时障碍点策略时间成本大于等待策略
         x = find(spend2==min(spend2));
         OUT = x;
         P = P2;
         sp = sp2;
         X2 = X;
         Y2 = Y;
         spcos2 = spcos;
      end
   else
        x = find(spend_a==min(spend_a));
         OUT = x;
         P = P_a;
         sp = sp_a;
         TW2 = TW_a;
         X2  = X_a;
         Y2  = Y_a;
         spcos2 = spcost_a;
   end
 end
end