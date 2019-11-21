function [dead_species_pos,dead_species_grid,dead_species,dead_species_step,...
          species_pos,species_grid,species_E,species,species_div,species_div_th,...
          species_init_E,species_colony_type,species_div_distance,species_g0_th,...
          popnum,species_death_th] = refresh_list(t,popnum,new_cell_species,survive_cell,dead_species_pos,dead_species_grid,dead_species,...
                                            dead_species_step,species_pos,species_grid,species_E,species,species_div,species_divpref,...
                                            species_div_th,species_init_E,species_colony_type,species_div_distance,species_g0_th,colony_new_pos,...
                                            init_E, div_th, colony_type, div_distance, g0_th, species_number, species_name,death_th,species_death_th)

new_id=find(new_cell_species);
new_cell_species=new_cell_species(new_id);                                         
                                         
dead_id=find(~survive_cell);                                          %
dead_species_pos=[dead_species_pos; species_pos(survive_cell==0,:)];    %
dead_species_grid=[dead_species_grid; species_grid(survive_cell==0,:)]; %
dead_species=[dead_species; species(survive_cell==0,:)];                %
dead_species_step=[dead_species_step; t.*ones(size(dead_id,1),1)];    %savig the data of dead cells

species_pos=species_pos(survive_cell==1,:);                             %
species_grid=species_grid(survive_cell==1,:);                           %
species_E=species_E(survive_cell==1,:);                                 %
species=species(survive_cell==1,:);                                     %
species_div=species_div(survive_cell==1,:);                             %
%species_divpref=species_divpref(survive_cell==1,:);                    %
species_div_th=species_div_th(survive_cell==1,:);                       %
species_init_E=species_init_E(survive_cell==1,:);                       %
species_colony_type=species_colony_type(survive_cell==1,:);             %
species_div_distance=species_div_distance(survive_cell==1,:);           %
species_death_th=species_death_th(survive_cell==1,:);                   %
species_g0_th=species_g0_th(survive_cell==1,:);                         %deleting the data of dead cells from the living cell's matrices

species_pos=[species_pos; colony_new_pos];                                                                 %
species_grid=[species_grid; ceil(colony_new_pos)];                                                         %
species_E=[species_E; lut(new_cell_species, init_E, species_number)];                                      %
species=[species; new_cell_species];                                                                       %
species_div=[species_div; ones(size(new_id,1),1)];                                                         %
species_div_th=[species_div_th; lut(new_cell_species, div_th, species_number)];                            %
species_init_E=[species_init_E; lut(new_cell_species, init_E, species_number)];                            %
species_colony_type=[species_colony_type; lut(new_cell_species, colony_type, species_number)];             %
species_div_distance=[species_div_distance; lut(new_cell_species, div_distance, species_number)];          %
species_g0_th=[species_g0_th; lut(new_cell_species, g0_th, species_number)];                               %
species_death_th=[species_death_th; lut(new_cell_species, death_th, species_number)];
%species_divpref=[species_divpref; new_dir];                                                               %adding the data of new cells

[sp_num, ~]=hist(species, species_name);
popnum(t+1,:)=[size(species_E,1), sp_num];
end