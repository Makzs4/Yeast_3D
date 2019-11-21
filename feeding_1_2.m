function [species_E, nutrient_space] = feeding_1_2(species, popnum, t, species_div, nutrient_uptake, nutrient_uptake_eff, species_grid, g0_factor, metab_E, species_E, nutrient_space)

 for s=1:popnum(t,1) %going through all of the curretly alive cell's life cycle one by one
  s_akt=species(s,1); %deriving the species of the current cell

 if species_div(s) == 0 %determining how much nutrient the cell would like to consume based on it's species and cell state
  nutrient_uptake_akt = nutrient_uptake(s_akt) * g0_factor(s_akt);
  metab_e_akt = metab_E(s_akt) * g0_factor(s_akt); 
 elseif species_div(s) == 1
  nutrient_uptake_akt = nutrient_uptake(s_akt);
  metab_e_akt = metab_E(s_akt);
 end

 if nutrient_space(species_grid(s,1), species_grid(s,2), species_grid(s,3)) < nutrient_uptake_akt %if the agar has less nutrient, it can only consume that much
  nutrient_uptake_akt = nutrient_space(species_grid(s,1), species_grid(s,2), species_grid(s,3));
 end

 nutrient_space(species_grid(s,1), species_grid(s,2), species_grid(s,3)) =...
 nutrient_space(species_grid(s,1), species_grid(s,2), species_grid(s,3)) - nutrient_uptake_akt;
 species_E(s) = species_E(s) + nutrient_uptake_akt * nutrient_uptake_eff(s_akt) - metab_e_akt;
 end

end