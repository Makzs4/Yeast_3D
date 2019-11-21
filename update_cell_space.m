function [cell_space] = update_cell_space(max_x, max_y, max_z, species_grid)

cell_space = zeros(max_x,max_y,max_z); %state space of the cells: 0:no cell, 1:cell, for diffusion matrices
species_grid = unique(species_grid,'rows');

for i = 1:size(species_grid,1)
 cell_space(species_grid(i,1),species_grid(i,2),species_grid(i,3))=1;
end

end

