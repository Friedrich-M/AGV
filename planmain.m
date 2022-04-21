h=0.5  %设置时间间隔
t=[0:h:6]  %生成时间序列
x=[1 3 6 7 8 10 11 7 3 1 4 5 3]  %设置路径点的横坐标序列
y=2*t  %设置路径点的纵坐标序列
s=zeros(5)  %待插值序列初始化（可反复利用）
f0x=0  %x序列边界条件（1）初始化
f0y=0  %y序列边界条件（1）初始化

for i=1:length(t)-5  %距目标点有5个以上的路径规划点时
%对x序列进行规划
    for j=1:5
        s(j)=x(i+j-1)  %生成待插值序列
    end
    
   m=tricurveonce(s,h,f0x)  %调用函数得到三弯矩法插值系数M向量
   tt=[t(i):(h/100):t(i+1)]  %生成时间序列
   xx=zeros(length(tt),1)  %生成待plot轨迹横坐标值序列
   for k=1:length(tt)
       xx(k)=(m(1)*(t(i+1)-tt(k))^3+m(2)*(tt(k)-t(i))^3)/6/h+(x(i)-m(1)*h*h/6)*(t(i+1)-tt(k))/h+(x(i+1)-m(2)*h*h/6)*(tt(k)-t(i))/h
   %根据公式计算每一时刻对应x的值
   end
   f0x=(-3*m(1)*(t(i+1)-tt(length(tt)))^2+3*m(2)*(tt(length(tt))-t(i))^2)/6/h-(x(i)-m(1)*h*h/6)/h+(x(i+1)-m(2)*h*h/6)/h
   %更新下一次规划的边界条件（1）即一阶导数连续
   %对y序列进行规划
   for j=1:5
        s(j)=y(i+j-1)  %生成待插值序列
   end
   m=tricurveonce(s,h,f0y)  %调用函数得到三弯矩法插值系数M向量
   yy=zeros(length(tt),1)  %生成待plot轨迹纵坐标值序列
   for k=1:length(tt)
       yy(k)=(m(1)*(t(i+1)-tt(k))^3+m(2)*(tt(k)-t(i))^3)/6/h+(y(i)-m(1)*h*h/6)*(t(i+1)-tt(k))/h+(y(i+1)-m(2)*h*h/6)*(tt(k)-t(i))/h
   end  %根据公式计算每一时刻对应y的值
   f0y=(-3*m(1)*(t(i+1)-tt(length(tt)))^2+3*m(2)*(tt(length(tt))-t(i))^2)/6/h-(y(i)-m(1)*h*h/6)/h+(y(i+1)-m(2)*h*h/6)/h
%更新下一次规划的边界条件（1）即一阶导数连续
   plot(xx,yy,'LineWidth',2)  %画出规划后的轨迹（X-Y）
   grid on
   hold on
end  %循环结束


%当待规划点仅剩5个时
for j=1:5
    s(j)=x(length(t)+j-5)  %生成待插值序列
end
m=tricurveonce(s,h,f0x)  %调用函数得到三弯矩法插值系数M向量
tt=[t(length(t)-4):(h/100):t(length(t))]  %生成时间序列
xx=zeros(length(tt),1)  %生成待plot轨迹横坐标值序列
for i=1:4  %分段计算
    for k=1:100
       xx(100*(i-1)+k)=(m(i)*(t(i+length(t)-4)-tt(100*(i-1)+k))^3+m(i+1)*(tt(100*(i-1)+k)-t(i+length(t)-5))^3)/6/h+(x(i+length(t)-5)-m(i)*h*h/6)*(t(i+length(t)-4)-tt(100*(i-1)+k))/h+(x(i+length(t)-4)-m(i+1)*h*h/6)*(tt(100*(i-1)+k)-t(i+length(t)-5))/h
    end  %根据公式计算每一时刻对应x的值
end
xx(length(tt))=xx(length(tt)-1)
for j=1:5
    s(j)=y(length(t)+j-5)  %生成待插值序列
end
m=tricurveonce(s,h,f0y)  %调用函数得到三弯矩法插值系数M向量
yy=zeros(length(tt),1)  %生成待plot轨迹纵坐标值序列
for i=1:4  %分段计算
    for k=1:100
       yy(100*(i-1)+k)=(m(i)*(t(i+length(t)-4)-tt(100*(i-1)+k))^3+m(i+1)*(tt(100*(i-1)+k)-t(i+length(t)-5))^3)/6/h+(y(i+length(t)-5)-m(i)*h*h/6)*(t(i+length(t)-4)-tt(100*(i-1)+k))/h+(y(i+length(t)-4)-m(i+1)*h*h/6)*(tt(100*(i-1)+k)-t(i+length(t)-5))/h
    end  %根据公式计算每一时刻对应y的值
end
yy(length(tt))=yy(length(tt)-1)
plot(xx,yy,'LineWidth',2)  %画出规划后的轨迹（X-Y）
grid on
for i=1:length(x)
    scatter(x(i),y(i),100)  %画出路径规划给出的点作为参考验证
    hold on
end