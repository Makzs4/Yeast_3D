function species_pos = lennard_jones_1_0(species_pos,r_cutoff,t_lj,e,s,max_force,max_x,max_y,max_z,agar_height)

[n, dim] = size(species_pos);
norm_vect = cell(n,1);
force_vect = cell(n,1);
force_net = zeros(n,dim);
t = 0;

while 1
 [idx, dist] = rangesearch(species_pos,species_pos,r_cutoff);
 for i = 1:n
   % norm vectors %
   xi_x = species_pos(idx{i,1}(1),:)-species_pos(idx{i,1}(2:end),:);
   norm_vect{i,1} = xi_x/norm(xi_x);
   
   % force vectors %
   r = dist{i,1}(2:end).';
   s_r_6 = (s./r).^6;
   force_vect{i,1} = (-24*e.*s_r_6.*(1./r).*(2.*s_r_6-1)).*norm_vect{i,1};
   
   % sum of forces %
   force_net(i,:) = sum(force_vect{i,1},1); 
 end
 % maximizing force %
 force_net = min(force_net,  max_force);
 force_net = max(force_net, -max_force);
 
 % position update
 species_pos = species_pos + force_net;
 
 % set fix boundary %
 species_pos = fix_boundary(species_pos,max_x,max_y,max_z,agar_height);
 
 t = t+1;
 if (max(force_net,[],'all')<0.002 || t==t_lj)
  break;
 end
 
end

end