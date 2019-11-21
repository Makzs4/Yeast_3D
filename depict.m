function depict(t,sx,sy,sz,init_nutrient,nutrient_space,species_number,species_pos,species,species_name,species_div,plotcolors)

 %h = slice(X, Y, Z, nutrient_space, sx, sy, sz);
 h = slice(permute(nutrient_space,[2 1 3]), sx, sy, sz);
 set(h,'EdgeColor','none',...
       'FaceColor','interp',...
       'FaceAlpha','interp');
       alpha color;
       alphamap('rampup');
       caxis([0 init_nutrient]);
 daspect([1 1 1]);
       
 hold on;
 for i=1:species_number
  plot3(species_pos((species==species_name(i) & species_div==1),1),...
        species_pos((species==species_name(i) & species_div==1),2),...
        species_pos((species==species_name(i) & species_div==1),3),...
        '.','color', plotcolors{(i*2)},'MarkerSize', 5);
  plot3(species_pos((species==species_name(i) & species_div==0),1),...
        species_pos((species==species_name(i) & species_div==0),2),...
        species_pos((species==species_name(i) & species_div==0),3),...
        '.','color', plotcolors{(i*2)-1} ,'MarkerSize', 5);
 end
 hold off;
 title(['Simulation time: ', num2str(t)]);
 
 if t==0
  waitforbuttonpress;
  disp('Simulation has succesfully started');
 end
  
end