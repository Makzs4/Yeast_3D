function [survive_cell, nutrient_space] = death_1_2(species,popnum,t,survive_cell,nutrient_space,death_th,species_E,species_grid)

 for s=1:popnum(t,1) %going through all of the curretly alive cell's life cycle one by one
  s_akt=species(s,1); %deriving the species of the current cell
  if species_E(s)<death_th(s_akt)
   survive_cell(s,1)=0; 

   nutrient_space(species_grid(s,1), species_grid(s,2), species_grid(s,3))=...
   nutrient_space(species_grid(s,1), species_grid(s,2), species_grid(s,3))+species_E(s);
  end
 end
end

