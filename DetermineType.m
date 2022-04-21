function [DT]=DetermineType(Pa,TW,i)
% DT 冲突类型记录矩阵 
% 第一列  1：相遇冲突 2：节点冲突   
% 第二列  记录当前规划路径任务
% 第三列  冲突栅格在当前路径中的位置
% 第四列  当前路径与之前路径中第一次出现冲突的路径
% 第五列  冲突栅格在冲突路径中的位置
global Path;
global TimeWindow;
mark = 0;
k = length(Pa);                         %当前预规划路径栅格点数
DT = zeros(1,5);                        %冲突类型矩阵，记录各备选路径的冲突类型
for j=1:i-1
    n = length(Path{j});
    for z = 1:k
        t = Pa(1,z);                %遍历选择路径的经过的每个栅格
        [r,c] = find(Path{j}==t);   %选择路径的当前栅格是否存在于AGV1的路径
        if ~isempty(r)              %如果存在，时间窗冲突检测
            if TW(1,z+1)<TimeWindow{j}(c)||TW(1,z)>TimeWindow{j}(c+1)  %时间窗冲突检测
            else
                if z~=1&&c~=n
                     if Pa(z-1)==Path{j}(c+1)   %相遇路径类型判断
                         DT(1,1) = 1;           %相遇冲突类型
                         DT(1,2) = i;           %记录当前规划路径任务
                         DT(1,3) = z;           %冲突栅格在当前路径中的位置
                         DT(1,4) = j;           %冲突栅格在第一次出现的路径
                         DT(1,5) = c;           %冲突栅格在路径中的位置
                     else
                         DT(1,1) = 2;           %节点冲突类型
                         DT(1,2) = i;           %记录当前规划路径任务
                         DT(1,3) = z;           %冲突栅格在当前路径中的位置
                         DT(1,4) = j;           %冲突栅格在第一次出现的路径
                         DT(1,5) = c;           %冲突栅格在路径中的位置
                     end 
                else                      %发生在路径末节点的冲突都为节点冲突
                         DT(1,1) = 2;           %节点冲突类型
                         DT(1,2) = i;           %记录当前规划路径任务
                         DT(1,3) = z;           %冲突栅格在当前路径中的位置
                         DT(1,4) = j;           %冲突栅格在第一次出现的路径
                         DT(1,5) = c;           %冲突栅格在路径中的位置
                end
                mark = 1;
                break;
            end
        end
    end
    if mark == 1
            break;
    end
end


end