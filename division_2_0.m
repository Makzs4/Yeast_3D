function [species_E, new_cell_species, new_dir] = division_2_0(s, s_akt, species_div, species_E, div_th, init_E, new_cell_species, new_dir, colony_type, branchprob, species_divpref, div_distrdev)

div = rand;
 if species_div(s)==1 && species_E(s)>=div_th(s_akt) && div<0.5
  species_E(s)=species_E(s)-init_E(s_akt);
  new_cell_species(s,1)=s_akt;
  c = colony_type(s_akt);
  switch c
      case 0
        new_dir(s,1)=2*pi*rand;
        
%       case 1                       %ezt még át kell gondolni
%         if div<branchprob(s_akt)
%          new_dir(s,1)=2*pi*rand;
%         else
%          new_dir(s,1)=species_divpref(s)+div_distrdev(s_akt).*randn;
%         end  
  end
 end
end

