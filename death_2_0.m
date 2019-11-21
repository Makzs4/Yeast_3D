function [survive_cell, nutrient_space] = death_2_0(survive_cell, nutrient_space, species_death_th, species_E, species_grid)

survive_cell(species_E<species_death_th)=0;
if ~any(survive_cell)

 dead_species_E=species_E(species_E<species_death_th);
 dead_grid=sub2ind(size(nutrient_space),species_grid(:,1),species_grid(:,2),species_grid(:,3));
 dead_grid=dead_grid(species_E<species_death_th);
 [dead_grid,idx]=sort(dead_grid);
 dead_species_E=dead_species_E(idx);
 dead_grid=[dead_grid ones(size(dead_grid))];
 dead_grid_E=accumarray(dead_grid,dead_species_E);
 dead_grid_E=dead_grid_E(dead_grid_E~=0);

 nutrient_space(unique(dead_grid(:,1)))=nutrient_space(unique(dead_grid(:,1)))+dead_grid_E;
end

end