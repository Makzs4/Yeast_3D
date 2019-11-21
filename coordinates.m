function colony_new_pos = coordinates(colony_pos, colony_div_distance, agar_height)

n = size(colony_pos,1);
colony_new_pos = zeros(n,3);

for i = 1:n
    xi = randn; yi = randn; zi = randn;
    norm = 1/sqrt(xi^2+yi^2+zi^2);
    colony_new_pos(i,1) = colony_pos(i,1)+xi*norm*colony_div_distance(i,1);
    colony_new_pos(i,2) = colony_pos(i,2)+yi*norm*colony_div_distance(i,1);
    colony_new_pos(i,3) = colony_pos(i,3)+zi*norm*colony_div_distance(i,1);
    
    if colony_new_pos(i,3) < agar_height
        norm = 1/sqrt(xi^2+yi^2);
        r = sqrt(colony_div_distance(i,1)^2-(colony_pos(i,3)-agar_height)^2);
        colony_new_pos(i,1) = colony_pos(i,1)+xi*norm*r;
        colony_new_pos(i,2) = colony_pos(i,2)+yi*norm*r;
        colony_new_pos(i,3) = agar_height;
    end    
end

end

