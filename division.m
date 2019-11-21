function [species_E, new_cell_species, new_dir] = division(s, s_akt, species_div, species_E, div_th, init_E, new_cell_species, new_dir, colony_type, branchprob, species_divpref, div_distrdev)

div = rand;
if species_div(s)==1 && species_E(s)>=div_th(s_akt) && div<0.5
 species_E(s)=species_E(s)-init_E(s_akt);
 new_cell_species(s,1)=s_akt;
 
 if colony_type(s_akt)==1
  if div<branchprob(s_akt)
   new_dir(s,1)=2*pi*rand;
  else
   new_dir(s,1)=species_divpref(s)+div_distrdev(s_akt).*randn;  
  end
 elseif colony_type(s_akt)==0
   new_dir(s,1)=2*pi*rand;
 end  
end
 
end

