%%%%% YEAST MODEL 3D %%%%%

tstart=tic; %for testing speed

%%% READ IN %%%
inputname='3D_parameters.csv';

% PLATE PARAMETERS %
dt=dlmread(inputname, ';', 'B2..B2'); %time step
dx=dlmread(inputname, ';', 'B3..B3'); %space step
max_x=dlmread(inputname, ';', 'B4..B4'); %size of space along x axis
max_y=dlmread(inputname, ';', 'B5..B5'); %size of space along y axis
max_z=dlmread(inputname, ';', 'B6..B6'); %size of space along z axis
max_t=dlmread(inputname, ';', 'B7..B7'); %iteration number (the time of the simulation)
init_nutrient=dlmread(inputname, ';', 'B8..B8'); %initial nutrient density
diff_co_nutrient_agar=dlmread(inputname, ';', 'B9..B9'); %diffusion coefficienst: nutrient diffuses in agar
diff_co_nutrient_air=dlmread(inputname, ';', 'B10..B10'); %diffusion coefficienst: nutrient diffuses in air
diff_co_oxigen_agar=dlmread(inputname, ';', 'B11..B11'); %diffusion coefficienst: oxigen diffuses in agar
diff_co_oxigen_air=dlmread(inputname, ';', 'B12..B12'); %diffusion coefficienst: oxigen diffuses in air
diff_co_nutrient_cell=dlmread(inputname, ';', 'B13..B13'); %diffusion coefficienst: nutrient diffuses in cell
diff_co_oxigen_cell=dlmread(inputname, ';', 'B14..B14'); %diffusion coefficienst: oxigen diffuses in cell
agar_height=dlmread(inputname, ';', 'B15..B15'); %height of culture medium
diff_cnt=dlmread(inputname, ';', 'B16..B16'); %number of diffusion steps/agent life cycle

% CELL PARAMETERS %
init_E=dlmread(inputname, ';', 'B21..K21'); %initial energy
nutrient_uptake=dlmread(inputname, ';', 'B22..K22'); %nutrient uptake
nutrient_uptake_eff=dlmread(inputname, ';', 'B23..K23'); %nutrient uptake efficiency
div_th=dlmread(inputname, ';', 'B24..K24'); %division threshold (in terms of energy)
div_distance=dlmread(inputname, ';', 'B25..K25'); %division distance
death_th=dlmread(inputname, ';', 'B26..K26'); %death threshold (in terms of energy)
metab_E=dlmread(inputname, ';', 'B27..K27'); %energy usage by metabolism
colony_type=dlmread(inputname, ';', 'B28..K28'); %type of colony
g0_factor=dlmread(inputname, ';', 'B29..K29');  %penalty in g0 state (constant multiplier)
g0_th=dlmread(inputname, ';', 'B30..K30'); %g0 threshold (in terms of energy)
branchprob=dlmread(inputname, ';', 'B31..K31'); %branching probability
div_distrdev=dlmread(inputname, ';', 'B32..K32'); %division direction deviation
div_distrdev(div_distrdev > 0)=pi./div_distrdev(div_distrdev > 0);
initnum_species=dlmread(inputname, ';', 'B33..K33'); %initial cell number
initdev=dlmread(inputname, ';', 'B34..K34'); %initial cell deviation
initpos(1,:)=dlmread(inputname, ';', 'B35..K35'); %initial population center along x axis
initpos(2,:)=dlmread(inputname, ';', 'B36..K36'); %initial population center along y axis
initpos(3,:)=agar_height * double(initpos(1,:)~=0); %initial population center along z axis, if other dimensions != 0, then it's = the culture medium's height

% VISUALISATION PARAMETERS %
isdraw=dlmread(inputname, ';', 'B46..B46'); %1:yes, 0:no
plotstep=dlmread(inputname, ';', 'B47..B47'); %visualisation step
resolution=dlmread(inputname, ';', 'B48..D48'); %resolution of the plots

% PHYSICS PARAMETERS %
r_cutoff = dlmread(inputname, ';', 'B53..B53'); %cutoff distance(Lennard-Jones)
epsilon = dlmread(inputname, ';', 'B54..B54'); %for Lennard-Jones force
sigma = dlmread(inputname, ';', 'B55..B55'); %for Lennard-Jones force
max_force = dlmread(inputname, ';', 'B56..B56'); %for Lennard-Jones force
t_lj = dlmread(inputname, ';', 'B57..B57'); %maximum iteration number of L-J simulation


%%% INITIALISATION %%%
t=0;
sx = linspace(1, max_x, resolution(1,1)); %
sy = linspace(1, max_y, resolution(1,2)); %
sz = linspace(1, max_z, resolution(1,3)); %for plotting
plotcolors={rgb('LimeGreen'),rgb('Green'),rgb('LightSalmon'),rgb('Red'),rgb('LightBlue'),rgb('Blue'),rgb('Lavender'),rgb('Purple')};

species_number = sum(initnum_species > 0);
species_name=1:species_number;
area_matrix = zeros(max_t+1,species_number); %area of colonies
active_cells = zeros(max_t+1,species_number); %number of active cells
g0_cells = zeros(max_t+1,species_number); %number of g0 cells
dead_cells = zeros(max_t+1,species_number);
popnum=zeros(max_t+1,species_number+1); %population of colonies
popnum(1,:)=[sum(initnum_species), initnum_species(1:species_number)];
species_pos=nan(popnum(1,1),3); %position of the cells along the x,y and z axes
species_E=nan(popnum(1,1),1); %energy of cells
species=nan(popnum(1,1),1); %species of cells, represented by a number
species_div=nan(popnum(1,1),1); %wether a cell can divide or not
species_div_th=nan(popnum(1,1),1); %division threshold of each cell
species_init_E=nan(popnum(1,1),1); %initial energy of each cell
species_colony_type=nan(popnum(1,1),1); %colony type of each cell
species_div_distance=nan(popnum(1,1),1); %division distance of each cell
species_g0_th=nan(popnum(1,1),1); %g0 threshold of each cell
species_death_th=nan(popnum(1,1),1);
species_divpref=nan(popnum(1,1),1); % ???
borders=[0 cumsum(initnum_species)]; %to know where a species's cells end and another species's cells begin in species_pos
dead_species_pos=[];  %
dead_species_grid=[]; %
dead_species_step=[]; %
dead_species=[];      % matrices for the data of dead cells

for i=1:species_number
 species_pos(borders(i)+1:borders(i+1),:)=[initpos(1,i)+initdev(i).*randn(initnum_species(i),1),...
                                           initpos(2,i)+initdev(i).*randn(initnum_species(i),1),...
                                           initpos(3,i).*ones(initnum_species(i),1)]; %gives the cells their unique positions
 species(borders(i)+1:borders(i+1))=species_name(i)*ones(initnum_species(i),1); %filling species with the initial cell's data
 species_E(borders(i)+1:borders(i+1))=init_E(i).*ones(initnum_species(i),1); %filling species_E with the initial cell's data
 species_init_E(borders(i)+1:borders(i+1))=init_E(i).*ones(initnum_species(i),1); %filling species_init_E with the initial cell's data
 species_div(borders(i)+1:borders(i+1))=ones(initnum_species(i),1); %filling species_div with the initial cell's data
 species_div_th(borders(i)+1:borders(i+1))=div_th(i).*ones(initnum_species(i),1); %filling species_div_th with the initial cell's data
 species_colony_type(borders(i)+1:borders(i+1))=colony_type(i).*ones(initnum_species(i),1); %filling species_colony_type with the initial cell's data
 species_div_distance(borders(i)+1:borders(i+1))=div_distance(i).*ones(initnum_species(i),1); %filling species_div_distance with the initial cell's data
 species_g0_th(borders(i)+1:borders(i+1))=g0_th(i).*ones(initnum_species(i),1);
 species_death_th(borders(i)+1:borders(i+1))=death_th(i).*ones(initnum_species(i),1);
 active_cells(1,i)=initnum_species(i);
 g0_cells(1,i)=0;
 dead_cells(1,i)=0;
 if colony_type(i)==1
  species_divpref(borders(i)+1:borders(i+1))=2*pi*rand(initnum_species(i),1); %???
 end
end

species_pos = fix_boundary(species_pos,max_x,max_y,max_z);

species_grid=ceil(species_pos); %tells in witch grid each cell is located

nutrient_space = zeros(max_x,max_y,max_z); %state space of the nutrient in the culture media
nutrient_space(:,:,1:agar_height) = init_nutrient; % filling the nutrient space with the initial agar

%%% PLOT OF INITIAL STATE %%%
if isdraw == 1
 depict(t,sx,sy,sz,init_nutrient,nutrient_space,species_number,species_pos,species,species_name,species_div,plotcolors);
end

profile on;

%%% CELL'S LIFE CYCLE %%%
for t = 1:dt:max_t
 new_cell_species=zeros(popnum(t,1),1); %matrix for possible newly born cells at time t
 survive_cell=ones(popnum(t,1),1); %matrix for cells which survive at time t
 new_dir=zeros(popnum(t,1),1); %matrix for direction of cell multiplication
    
 order=randperm(popnum(t,1)); %randomising the order in witch the cells get to act
 species_pos=species_pos(order,:);
 species_grid=species_grid(order,:);
 species_E=species_E(order,:);
 species=species(order,:);
 species_div=species_div(order,:);
 %species_divpref=species_divpref(order,:);
 species_div_th=species_div_th(order,:);
 species_init_E=species_init_E(order,:);
 species_colony_type=species_colony_type(order,:);
 species_div_distance=species_div_distance(order,:);
 species_g0_th=species_g0_th(order,:);
 species_death_th=species_death_th(order,:);
 
  % FEEDING %
  [species_E, nutrient_space] = feeding_1_2(species, popnum, t, species_div, nutrient_uptake, nutrient_uptake_eff, species_grid, g0_factor, metab_E, species_E, nutrient_space);
 
  % DECIDE (g0 or active cell) %
  species_div = decide_2_0(species_div, species_E, species_g0_th);
 
  % CELL DVISION %
  [species_E, new_cell_species, colony_new_pos] = division_3_0(t, agar_height, popnum, species, species_pos, species_div,...
                                                               species_E, species_div_th, species_div_distance, species_init_E,...
                                                               new_cell_species, species_colony_type, max_x, max_y, max_z);
                                                           
  % CELL DEATH %                                                          
  [survive_cell, nutrient_space] = death_2_0(survive_cell, nutrient_space, species_death_th, species_E, species_grid);

  % LENNARD-JONES FORCES %
  species_pos = lennard_jones_1_0(species_pos,r_cutoff,t_lj,epsilon,sigma,max_force,max_x,max_y,max_z,agar_height);
   
  [dead_species_pos,dead_species_grid,dead_species,dead_species_step,...
   species_pos,species_grid,species_E,species,species_div,species_div_th,...
   species_init_E,species_colony_type,species_div_distance,species_g0_th,...
   popnum,species_death_th] = refresh_list(t,popnum,new_cell_species,survive_cell,dead_species_pos,dead_species_grid,dead_species,...
                                           dead_species_step,species_pos,species_grid,species_E,species,species_div,species_divpref,...
                                           species_div_th,species_init_E,species_colony_type,species_div_distance,species_g0_th,colony_new_pos,...
                                           init_E, div_th, colony_type, div_distance, g0_th, species_number, species_name,death_th,species_death_th);
                    
   cell_space = update_cell_space(max_x, max_y, max_z, species_grid); %updating cell_space from species grid
 
  % DIFFUSION OF NUTRIENT %
  nutrient_space = diffusion(diff_cnt,dx,dt,cell_space,nutrient_space,agar_height,diff_co_nutrient_agar,diff_co_nutrient_air,diff_co_nutrient_cell);
 
  for i=1:species_number
   active_cells(t+1,i) = numel(species_pos(species==species_name(i) & species_div==1));
   g0_cells(t+1,i) = numel(species_pos(species==species_name(i) & species_div==0));
   dead_cells(t+1,i) = numel(dead_species_pos(dead_species==species_name(i)));
  end
 
  if (isdraw==1 && mod(t,plotstep)==0)
   pause(0.1);   
   depict(t,sx,sy,sz,init_nutrient,nutrient_space,species_number,species_pos,species,species_name,species_div,plotcolors);
  elseif (isdraw==0 && t==0+dt)
   disp('Simulation has succesfully started');   
  end
 
  if (t==max_t)
   final_plots(max_t,species_number,plotcolors,active_cells,g0_cells,dead_cells,species,dead_species,species_pos,...
               species_grid,dead_species_grid,species_div,max_z,agar_height,nutrient_space);
   disp('Simulation has terminated');
   fprintf('\n');
  end
 
end

profile viewer;   
elapsedtime=toc(tstart)/60; %for testing speed