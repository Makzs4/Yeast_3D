function [species_div] = decide(s, s_akt, species_div, species_E, g0_th)

if species_div(s)==1 && species_E(s)<g0_th(s_akt)
       species_div(s)=0; %G0
elseif species_div(s)==0 && species_E(s)>=g0_th(s_akt)
       species_div(s)=1;
end

end

