function [species_E, new_cell_species, colony_new_pos] = division_3_0(t, agar_height, popnum, species, species_pos, species_div, species_E, species_div_th, species_div_distance, species_init_E, new_cell_species, species_colony_type,max_x,max_y,max_z)

div = rand(popnum(t,1),1);
                                                                                                                             
%%colony_type = 0 cells%%
colony_pos = species_pos(species_div==1 & species_E>=species_div_th & div<0.5 & species_colony_type==0,:); %getting the position of colony type 0 cells
colony_div_distance = species_div_distance(species_div==1 & species_E>=species_div_th & div<0.5 & species_colony_type==0,:); %getting the division distance of colony type 0 cells
colony_new_pos = coordinates_2_0(colony_pos, colony_div_distance, agar_height);
colony_new_pos = fix_boundary(colony_new_pos,max_x,max_y,max_z,agar_height);

%%colony_type = 1 cells%%
% ezt még ki kell találni :(
new_cell_species(species_div==1 & species_E>=species_div_th & div<0.5,:) = species(species_div==1 & species_E>=species_div_th & div<0.5,:); % determining species of new cells
                                                                                                                                            % (inheriting form parent cells

species_E(species_div==1 & species_E>=species_div_th & div<0.5,:) = species_E(species_div==1 & species_E>=species_div_th & div<0.5,:) -... % reducing cell energy
                                                               species_init_E(species_div==1 & species_E>=species_div_th & div<0.5,:);
                                                                                                                                
end