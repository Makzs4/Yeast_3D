function final_plots(max_t, species_number, plotcolors, active_cells, g0_cells, dead_cells, species, dead_species, species_pos, species_grid, dead_species_grid, species_div, max_z, agar_height, nutrient_space)

 center=zeros(species_number,3); 
 center_pos_y=cell(1,species_number*2);
 center_pos_x=cell(1,species_number*2);
 
 for i=1:species_number
  figure; %plots for growth curves
  hold on;
  plot(0:max_t,active_cells(:,i),'color',plotcolors{(i*2)});
  plot(0:max_t,g0_cells(:,i),'color',plotcolors{(i*2)-1});
  plot(0:max_t,active_cells(:,i)+g0_cells(:,i),'k-');
  plot(0:max_t,dead_cells(:,i)+active_cells(:,i)+g0_cells(:,i),'k-.');
  xlabel('timestep');
  ylabel('population');
  title(['Species #',num2str(i),' population']);
  legend({'active cells','G0 cells','living cells','all cells'});
  hold off;
  
  center(i,:)=mean(species_pos(species==i,:));
  center_pos_y{(i*2)}=species_pos((abs(species_pos(:,2)-center(i,2))<=0.1 & species_div==1),:);
  center_pos_x{(i*2)}=species_pos((abs(species_pos(:,1)-center(i,1))<=0.1 & species_div==1),:);
  center_pos_y{(i*2-1)}=species_pos((abs(species_pos(:,2)-center(i,2))<=0.1 & species_div==0),:);
  center_pos_x{(i*2-1)}=species_pos((abs(species_pos(:,1)-center(i,1))<=0.1 & species_div==0),:);
  
  figure; % plots for x and y dimensionwise slices
  subplot(2,1,1);
  hold on;
  plot(center_pos_y{(i*2)}(:,1),center_pos_y{(i*2)}(:,3),'.','color',plotcolors{(i*2)},'MarkerSize',5);
  plot(center_pos_y{(i*2-1)}(:,1),center_pos_y{(i*2-1)}(:,3),'.','color',plotcolors{(i*2-1)},'MarkerSize',5);
  xlabel('x');
  ylabel('z');
  ylim([agar_height max_z ]);
  title(['Species #',num2str(i),' y cross section']);
  set(gca,'Color',rgb('LightGray'));
  hold off;
  
  subplot(2,1,2)
  hold on;
  plot(center_pos_x{(i*2)}(:,2),center_pos_x{(i*2)}(:,3),'.','color',plotcolors{(i*2)},'MarkerSize',5);
  plot(center_pos_x{(i*2-1)}(:,2),center_pos_x{(i*2-1)}(:,3),'.','color',plotcolors{(i*2-1)},'MarkerSize',5);
  xlabel('y');
  ylabel('z');
  ylim([agar_height max_z ]);
  title(['Species #',num2str(i),' x cross section']);
  set(gca,'Color',rgb('LightGray'));
  hold off;
  
  %cell density plots
  a=accumarray([species_grid(species(:,1)==i,1), species_grid(species(:,1)==i,2)],1); %only living cells
  a2=zeros(size(nutrient_space(:,:,1)));
  a2(1:size(a,1),1:size(a,2))=a;
  figure;
  imagesc(a2);
  title(['Cell density plot of species #',num2str(i), ', living cells only']);
  colorbar;
  
  a=accumarray([[species_grid(species(:,1)==i,1);dead_species_grid(dead_species(:,1)==i,1)],...
                [species_grid(species(:,1)==i,2);dead_species_grid(dead_species(:,1)==i,2)]],1); %dead cells included
  a2=zeros(size(nutrient_space(:,:,1)));
  a2(1:size(a,1),1:size(a,2))=a;
  figure;
  imagesc(a2);
   title(['Cell density plot of species #',num2str(i), ', both living and dead cells']);
  colorbar;
 end
 
end

