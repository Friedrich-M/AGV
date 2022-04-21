%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%dijkstra得到所有最短路径%%%%%%%%%%%%%%%%%%%%%
function [L,sp, spcost] =dijkstraR(W, s, d,q)
% W 邻接矩阵   % s 起点  % d 终点 %l 约束路径条数
% L 约束路径条数  % sp 所有路径矩阵  %spcost 最短路径距离
L = q;
n=size(W,1);
S(1:n) = 0;     %s, vector, set of visited vectors
dist(1:n) = inf;   % it stores the shortest distance between the source node and any other node;
prev = cell(1,n);
% prev(1:n) = n+1;    % Previous node, informs about the best previous node known to reach each  network node 
prev(1:n) = {
            n+1};
dist(s) = 0;
counter(1:n) = 1;
while sum(S)~=n
    candidate=[];
    for i=1:n
        if S(i)==0
            candidate=[candidate dist(i)];
        else
            candidate=[candidate inf];
        end
    end
    [u_index,u]=min(candidate);
    S(u)=1;
    for i=1:n
       if(dist(u)+W(u,i))<dist(i) % SEE DOCUMENTATION Switch 1 (add)
       %if (1 - (1 - dist(u)) * (1 - W(u,i))) < dist(i) % SEE DOCUMENTATION Switch 1 (mult)
          % dist(i) = (1 - (1 - dist(u)) * (1 - W(u,i))); % SEE DOCUMENTATION Switch 2 (mult)
            dist(i)=dist(u)+W(u,i); % SEE DOCUMENTATION switch 2 (add)
            prev(1,i) = {
            u};
            if counter > 1
                for j=2:counter
                    prev(counter,i) = {
            NaN};
                end
            end
            counter(i) = 1;
        elseif(dist(u)+W(u,i)) == dist(i) % SEE DOCUMENTATION Switch 3 (add)
%elseif(1 - (1 - dist(u)) * (1 - W(u,i))) == dist(i) % SEE DOCUMENTATION Switch 3 (mult) 
            prev(counter(i)+1,i) = {
            u};
            counter(i) = counter(i)+1;            
        end
    end
end
% Define a vector to represent how many ties are contained in the prev cell
% array corresponding to each node 
prevcolindex = ones(1,n); 
for i = 1:n
    for j = 2:size(prev,1)
        if isempty(prev{j,i}) == 1
            break;
        else
            prevcolindex(i) = j;
        end
    end
end
% Trace the branches of the path backwards beginning at d using the prev cell array. Record 
% the history of all steps each branch of the shortest path in backpaths cell array. 
% (Each step backwards along any branch in the path trace occupies a new cell in backpaths.)
backpaths = cell(1,1);
backpaths(1,1) = {
            d};
counters = 1;
counterf = 1;
test = 0;
while all(test == s) == 0 % The stopping criteria is that all remaining active branches (ie step histories that have not yet arrived at s) arrive at s simultaneuously
    test = s;
    for j = counters:counterf
        if backpaths{j}(1) == s 
            continue; % If a step history his already arrived at s, it is skipped
        end
        counterm = length(backpaths);
        for i = 1:prevcolindex(backpaths{j}) % Step backwards along each branch of the shortest path, and record the resulting history in a new cell in backpaths
            backpaths{counterm+i} = cat(2,prev{i,backpaths{j}(1)},backpaths{j});
        end
        test = cat(1,test,prev{i,backpaths{j}(1)});
    end
    counters = 1+counterf;
    counterf = length(backpaths);
end
% Extract the step histories that end (ie begin) at node s, and save them
% to sp (the shortest path array)
sp = cell(1,1);
for i = 1:counterf
    if backpaths{i}(1) == s && isempty(sp{1}) == 1
        sp = backpaths(i);
    elseif backpaths{i}(1) == s && isempty(sp{1}) == 0
        sp = cat(1,sp,backpaths(i));
    end
end
spcost = dist(d);
end