function [species_div] = decide_2_0(species_div, species_E, species_g0_th)

species_div(species_div==1 & species_E<species_g0_th) = 0;

species_div(species_div==0 & species_E>species_g0_th) = 1;

end

