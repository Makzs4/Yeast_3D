function [survive_cell, nutrient_space] = death(s, s_akt, survive_cell, nutrient_space, death_th, species_E, species_grid)

 if species_E(s)<death_th(s_akt)
  survive_cell(s,1)=0; 
  
  nutrient_space(species_grid(s,1), species_grid(s,2), species_grid(s,3))=...
  nutrient_space(species_grid(s,1), species_grid(s,2), species_grid(s,3))+species_E(s);
 end

end

