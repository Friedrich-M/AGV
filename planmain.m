h=0.5  %����ʱ����
t=[0:h:6]  %����ʱ������
x=[1 3 6 7 8 10 11 7 3 1 4 5 3]  %����·����ĺ���������
y=2*t  %����·���������������
s=zeros(5)  %����ֵ���г�ʼ�����ɷ������ã�
f0x=0  %x���б߽�������1����ʼ��
f0y=0  %y���б߽�������1����ʼ��

for i=1:length(t)-5  %��Ŀ�����5�����ϵ�·���滮��ʱ
%��x���н��й滮
    for j=1:5
        s(j)=x(i+j-1)  %���ɴ���ֵ����
    end
    
   m=tricurveonce(s,h,f0x)  %���ú����õ�����ط���ֵϵ��M����
   tt=[t(i):(h/100):t(i+1)]  %����ʱ������
   xx=zeros(length(tt),1)  %���ɴ�plot�켣������ֵ����
   for k=1:length(tt)
       xx(k)=(m(1)*(t(i+1)-tt(k))^3+m(2)*(tt(k)-t(i))^3)/6/h+(x(i)-m(1)*h*h/6)*(t(i+1)-tt(k))/h+(x(i+1)-m(2)*h*h/6)*(tt(k)-t(i))/h
   %���ݹ�ʽ����ÿһʱ�̶�Ӧx��ֵ
   end
   f0x=(-3*m(1)*(t(i+1)-tt(length(tt)))^2+3*m(2)*(tt(length(tt))-t(i))^2)/6/h-(x(i)-m(1)*h*h/6)/h+(x(i+1)-m(2)*h*h/6)/h
   %������һ�ι滮�ı߽�������1����һ�׵�������
   %��y���н��й滮
   for j=1:5
        s(j)=y(i+j-1)  %���ɴ���ֵ����
   end
   m=tricurveonce(s,h,f0y)  %���ú����õ�����ط���ֵϵ��M����
   yy=zeros(length(tt),1)  %���ɴ�plot�켣������ֵ����
   for k=1:length(tt)
       yy(k)=(m(1)*(t(i+1)-tt(k))^3+m(2)*(tt(k)-t(i))^3)/6/h+(y(i)-m(1)*h*h/6)*(t(i+1)-tt(k))/h+(y(i+1)-m(2)*h*h/6)*(tt(k)-t(i))/h
   end  %���ݹ�ʽ����ÿһʱ�̶�Ӧy��ֵ
   f0y=(-3*m(1)*(t(i+1)-tt(length(tt)))^2+3*m(2)*(tt(length(tt))-t(i))^2)/6/h-(y(i)-m(1)*h*h/6)/h+(y(i+1)-m(2)*h*h/6)/h
%������һ�ι滮�ı߽�������1����һ�׵�������
   plot(xx,yy,'LineWidth',2)  %�����滮��Ĺ켣��X-Y��
   grid on
   hold on
end  %ѭ������


%�����滮���ʣ5��ʱ
for j=1:5
    s(j)=x(length(t)+j-5)  %���ɴ���ֵ����
end
m=tricurveonce(s,h,f0x)  %���ú����õ�����ط���ֵϵ��M����
tt=[t(length(t)-4):(h/100):t(length(t))]  %����ʱ������
xx=zeros(length(tt),1)  %���ɴ�plot�켣������ֵ����
for i=1:4  %�ֶμ���
    for k=1:100
       xx(100*(i-1)+k)=(m(i)*(t(i+length(t)-4)-tt(100*(i-1)+k))^3+m(i+1)*(tt(100*(i-1)+k)-t(i+length(t)-5))^3)/6/h+(x(i+length(t)-5)-m(i)*h*h/6)*(t(i+length(t)-4)-tt(100*(i-1)+k))/h+(x(i+length(t)-4)-m(i+1)*h*h/6)*(tt(100*(i-1)+k)-t(i+length(t)-5))/h
    end  %���ݹ�ʽ����ÿһʱ�̶�Ӧx��ֵ
end
xx(length(tt))=xx(length(tt)-1)
for j=1:5
    s(j)=y(length(t)+j-5)  %���ɴ���ֵ����
end
m=tricurveonce(s,h,f0y)  %���ú����õ�����ط���ֵϵ��M����
yy=zeros(length(tt),1)  %���ɴ�plot�켣������ֵ����
for i=1:4  %�ֶμ���
    for k=1:100
       yy(100*(i-1)+k)=(m(i)*(t(i+length(t)-4)-tt(100*(i-1)+k))^3+m(i+1)*(tt(100*(i-1)+k)-t(i+length(t)-5))^3)/6/h+(y(i+length(t)-5)-m(i)*h*h/6)*(t(i+length(t)-4)-tt(100*(i-1)+k))/h+(y(i+length(t)-4)-m(i+1)*h*h/6)*(tt(100*(i-1)+k)-t(i+length(t)-5))/h
    end  %���ݹ�ʽ����ÿһʱ�̶�Ӧy��ֵ
end
yy(length(tt))=yy(length(tt)-1)
plot(xx,yy,'LineWidth',2)  %�����滮��Ĺ켣��X-Y��
grid on
for i=1:length(x)
    scatter(x(i),y(i),100)  %����·���滮�����ĵ���Ϊ�ο���֤
    hold on
end