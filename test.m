close all;
clear;
clc;
map=[0 1 1 1 0 0 1 1 1 0 ;
     0 0 0 0 0 0 0 0 0 0 ;
     0 1 1 1 0 0 1 1 1 0 ;
     0 1 1 1 0 0 1 1 1 0 ;
     0 0 0 0 0 0 0 0 0 0 ;
     0 0 0 0 0 0 0 0 0 0 ;
     0 1 1 1 0 0 1 1 1 0 ;
     0 1 1 1 0 0 1 1 1 0 ;
     0 0 0 0 0 0 0 0 0 0 ;
     0 1 1 1 0 0 1 1 1 0 ;];

SD1 = [10,21];               %AGV1起止点
SD2 = [41,25];              %AGV2起止点
L = 1000;                    %AGV2路径备用条数

[W,Q,I,C] = MapInit(map);                      %环境初始化
[L1,sp1,spcost1]=dijkstraR(W,SD1(1),SD1(2),1); %设置始末栅格及路径条数(1)
[X1,Y1]=Get_xy(spcost1,sp1,map);               %得到X,Y坐标
[T1,N1] = GetTrastion(X1,Y1,sp1);              %得到所有路径的转弯次数矩阵
[R1] = rank(T1);                               %对转弯矩阵从小到大排序
[P1]=GetPath(L1,spcost1,R1);                   %得到约束条数的路径
[TW1] = Get_TimerWindow(spcost1,sp1,P1,N1,T1); %得到每条路径时间窗矩阵
[Q,I]=plotTW(map,TW1,sp1,1,P1,Q,C,I);          %画出时间窗
plotMap_Path(map,spcost1,1,P1,X1,Y1,C,I);      %得到环境地图

[L2,sp2, spcost2]=dijkstraR(W,SD2(1),SD2(2),L);%设置始末栅格及路径条数
[X2,Y2]=Get_xy(spcost2,sp2,map);               %得到X,Y坐标
[T2,N2] = GetTrastion(X2,Y2,sp2);              %得到所有路径的转弯次数矩阵
[R2] = rank(T2);                               %对转弯矩阵从小到大排序
[P2]=GetPath(L2,spcost2,R2);                   %得到约束条数的路径
[TW2] = Get_TimerWindow(spcost2,sp2,P2,N2,T2); %得到每条路径时间窗矩阵
[TW2,OUT,sp,P,spcos2,X2,Y2] = Detection_TW(map,SD2,P1,P2,sp1,sp2,spcost2,X2,Y2,TW1,TW2);
[Q,I]=plotTW(map,TW2,sp2,OUT,P2,Q,C,I);        %画出时间窗
plotMap_Path(map,spcost2,OUT,P2,X2,Y2,C,I);    %得到环境地图 


