%% Initiate some random positions
%yeast_pos(:,3) = 20+(22-20).*rand(300,1);
yeast_pos(:,[1,2]) = 35+(65-35).*rand(300,2); %yeast cells with random positions near the agar
yeast_pos(:,3) = 20;
plot3(yeast_pos(:,1),yeast_pos(:,2),yeast_pos(:,3),'.');
xlim([0 100]);
ylim([0 100]);

%% Get the coordinates of occupied cells
grid_pos = unique(ceil(yeast_pos),'rows','stable');

%% Build adjacency list
n = size(grid_pos,1);
adj_list = cell(n,2);

for i = 1:n
 adj_list{i,1} = grid_pos(i,:); %add the nodes
 adj_list{i,2} = [adj_list{i,2}; [grid_pos(i,1),grid_pos(i,2),grid_pos(i,3)-1]]; %add node directly under(part of the agar)
 for j = i:n
  if is_adjacent(grid_pos(i,:),grid_pos(j,:))
   adj_list{i,2} = [adj_list{i,2}; grid_pos(j,:)]; %fill in adjacency list
   adj_list{j,2} = [adj_list{j,2}; grid_pos(i,:)];
  end    
 end    
end