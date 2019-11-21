function depict(t,sx,sy,sz,init_nutrient,nutrient_space,species_number,species_pos,species,species_name,species_div,plotcolors)

 figure(1);
 h = slice(permute(nutrient_space,[2 1 3]), sx, sy, sz);
 set(h,'EdgeColor','none',...
       'FaceColor','interp',...
       'FaceAlpha','interp');
       alpha color;
       alphamap('rampup');
       caxis([0 init_nutrient]);
 daspect([1 1 1]);
 title(['Simulation time: ', num2str(t)]);
 refresh;
 
 figure(2);
 nutrient_space(nutrient_space>0)=1;
 h = slice(permute(nutrient_space,[2 1 3]), sx, sy, sz);
 set(h,'EdgeColor','none',...
     'FaceColor','interp',...
     'FaceAlpha','interp');
     alpha color;
     alphamap('rampup');
     caxis([0 1]);
 daspect([1 1 1]);    
 title(['Simulation time: ', num2str(t)]);
 refresh;
 
 if t==0
  waitforbuttonpress;
  disp('Simulation has succesfully started');
 end
  
end



