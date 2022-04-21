%得到各路经时间窗%
function [TW] = Get_TimerWindow(spcost,sp,P,N,T)
% spcost 路径距离   
% sp 路径矩阵  
% P 选择的路径矩阵
% N 转弯栅格矩阵 
% TW 时间窗矩阵
% T 每条路径转弯次数矩阵
%经过一个栅格所需时间定义（/s）%
acceleration_time = 0.5;   %加速所需时间
stop_time = 0.5;           %制动所需时间
work_time = 5;             %工作所需时间
turn_time = 1;             %转弯所需时间
uniform_time = 1;          %匀速所需时间
% 经过一个栅格所需时间定义（/s）%
TW = [ ];
if(spcost < 999)                   %判断路径是否可达
    n =  size(P,2);                %得到路径条数
    for i =1:n
        t = 1;                     %为转弯次数赋初值
        m = size(sp{P(i)},2);      %得到当前路径的栅格点数
        for j =1:m
            if j == 1              %判断是否为起始点
                TW(i,j+1) = acceleration_time+0.75;
            elseif t <= T(1,P(i))     %判断转弯次数是否超过转弯矩阵索引
                if sp{P(i)}(j)==N(P(i),t)   %判断是否为转弯栅格点
                TW(i,j+1)=TW(i,j)+stop_time+turn_time+acceleration_time+0.5;
                t = t+1;
                elseif j == m      %判断是否为目标栅格点
                TW(i,j+1) =  TW(i,j)+ stop_time+work_time;
                else               %匀速行驶栅格点
                TW(i,j+1) =  TW(i,j)+ uniform_time;
                end
            elseif j == m          %判断是否为目标栅格点
                TW(i,j+1) =  TW(i,j)+ stop_time+work_time;
            else                   %匀速行驶栅格点
                TW(i,j+1) =  TW(i,j)+ uniform_time;
            end
        end
    end
 else
    TW = 0;    %若路径不可达TW为0
 end
end