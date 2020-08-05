function species_pos = fix_boundary(species_pos,max_x,max_y,max_z,agar_height)

species_pos(species_pos(:,1)>max_x,1) = max_x; 
species_pos(species_pos(:,2)>max_y,2) = max_y; 
species_pos(species_pos(:,3)>max_z,3) = max_z; 
species_pos(species_pos<0,:) = 0.01;             
species_pos(species_pos(:,3)<agar_height,3) = agar_height;

end

