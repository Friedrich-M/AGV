%得到任务列表中所有任务的预规划路径集合%
function [PrePathSet,PreTimeWindow,PrePathIndex] = Preplanned_Path(map,W)
global SE;
global Path;
global TimeWindow;
n = size(SE,1);
L = 100;
Path = cell(n,1);               %定义各任务路径集合，存放最终规划路径
TimeWindow = cell(n,1);         %定义各任务路径时间窗集合，存放最终规划路径时间窗
PrePathSet = cell(n,1);         %定义各任务预规划路径集合
PreTimeWindow = cell(n,1);      %定义各任务预规划路径时间窗集合
PrePathIndex = cell(n,1);       %定义各任务预规划路径索引
for i=1:n
    if i==1
        [~,sp,distance]=dijkstraR(W,SE(i,1),SE(i,2),1);  %设置始末栅格及路径条数(1)
        if distance > 998
            error('路径不可达');
        end
        [X,Y]=Get_xy(distance,sp,map);                   %得到X,Y坐标
        [T,N] = GetTrastion(X,Y,sp);                     %得到所有路径的转弯次数矩阵
        [R] = rank(T);                                   %对转弯矩阵从小到大排序
        [P]=GetPath(1,distance,R);                       %得到约束条数的路径
%         [TW] = Get_TimerWindow(distance,sp,P,N,T);       %得到每条路径时间窗矩阵
        if iscell(sp)==1                                 %数据类型转换
           sp = cell2mat(sp);
        end
%         PreTimeWindow{i,1} = TW;                         %得到预规划路径时间窗                   
        PrePathSet{i,1} = sp(P,:);                       %得到预规划路径集合
        PrePathIndex{i,1} = P;                           %得到预规划路径索引
        Path{i,1} =  PrePathSet{i,1};                    %路径规划集合
        TimeWindow{i,1} = PreTimeWindow{i,1};            %路径时间窗集合
    else
        [L,sp,distance]=dijkstraR(W,SE(i,1),SE(i,2),L);  %设置始末栅格及路径条数
        if distance > 998
            error('路径不可达');
        end
        [X,Y]=Get_xy(distance,sp,map);                   %得到X,Y坐标
        [T,N] = GetTrastion(X,Y,sp);                     %得到所有路径的转弯次数矩阵
        [R] = rank(T);                                   %对转弯矩阵从小到大排序
        [P]=GetPath(L,distance,R);                       %得到约束条数的路径
%         [TW] = Get_TimerWindow(distance,sp,P,N,T);       %得到每条路径时间窗矩阵
        if iscell(sp)==1                                 %数据类型转换
           sp = cell2mat(sp);
        end
%         PreTimeWindow{i,1} = TW;                         %得到预规划路径时间窗                 
        PrePathSet{i,1} = sp;                            %得到预规划路径集合
        PrePathIndex{i,1} = P;                           %得到预规划路径索引
    end     
end