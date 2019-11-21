function colony_new_pos = coordinates_2_0(colony_pos, colony_div_distance, agar_height)

n = size(colony_pos,1);
x = randn(n,1); y = randn(n,1); z = randn(n,1);
norm = 1./sqrt(x.^2+y.^2+z.^2);

colony_new_pos = [colony_pos(:,1)+x.*norm.*colony_div_distance(:,1),...
                  colony_pos(:,2)+y.*norm.*colony_div_distance(:,1),...
                  colony_pos(:,3)+z.*norm.*colony_div_distance(:,1)];

 if isempty(colony_new_pos(colony_new_pos(:,3)<agar_height,3))==0
  norm = 1./sqrt(x(colony_new_pos(:,3)<agar_height,:).^2+y(colony_new_pos(:,3)<agar_height,:).^2);
  r = realsqrt(colony_div_distance(colony_new_pos(:,3)<agar_height,1).^2-(colony_pos(colony_new_pos(:,3)<agar_height,3)-agar_height).^2);
  colony_new_pos(colony_new_pos(:,3)<agar_height,:) = [colony_pos(colony_new_pos(:,3)<agar_height,1)+x(colony_new_pos(:,3)<agar_height,:).*norm.*r,...
                                                       colony_pos(colony_new_pos(:,3)<agar_height,2)+y(colony_new_pos(:,3)<agar_height,:).*norm.*r,...
                                                       agar_height.*ones(size(norm,1),1)];
 end
end