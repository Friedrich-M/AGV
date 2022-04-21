%规划无冲突路径%
function planningPath(map,PrePathSet,PreTimeWindow,PrePathIndex)
global SE;
global Path;
global TimeWindow;
n = size(SE,1);                      %获取任务数量
for i=2:n                            %第二个任务路径开始冲突检测（第一条任务优先级最高无需检测）
    num = size(PrePathSet{i},1);     %获取各任务预规划路径数量
    mark = 1;                        %冲突标志，0为无冲突
    for j=1:num
        Index = PrePathIndex{i}(j);
        [Mark] = Detection_TW(PrePathSet{i}(Index,:),PreTimeWindow{i}(Index,:),i);
        if sum(Mark(1,:)) == 0        %判断当前路径与优先级高的所有路径是否存在冲突
            Path{i} = PrePathSet{i}(Index,:);
            TimeWindow{i} = PreTimeWindow{i}(Index,:);
            mark = 0;
            break;
        end
    end
    if mark == 1                      %若当前预规划路径集合都存在冲突
        Index = PrePathIndex{i}(1);   %选取集合中第一条路径判断冲突类型
        [DT] = DetermineType(PrePathSet{i}(Index,:),PreTimeWindow{i}(Index,:),i);   
        [flag,W_TW,W_Pa,C_Pa,C_TW] = Get_WaittingChangePath(DT,map,PrePathSet{i}(Index,:),PreTimeWindow{i}(Index,:));
        if flag == 0      
            t1 = W_TW(1,end);
            t2 = C_TW(1,end);
            if t1 > t2
                Path{i} = C_Pa;
                TimeWindow{i} = C_TW;
            else
                Path{i} = W_Pa;
                TimeWindow{i} = W_TW;
            end
        else
             Path{i} = C_Pa;
             TimeWindow{i} = C_TW;
        end
    end 
end