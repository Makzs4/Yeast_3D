function nutrient_space = diffusion(diff_cnt,dx,dt,cell_space,nutrient_space,agar_height,diff_co_nutrient_agar,diff_co_nutrient_air,diff_co_nutrient_cell)
 
 [D1, D2, D3] = conductivity_matrix_3_0(cell_space,agar_height,diff_co_nutrient_cell,diff_co_nutrient_air,diff_co_nutrient_agar);
 
 for i=1:diff_cnt
     
  nutrient_space_2 = nutrient_space;

  nutrient_space_2_prev_1 = aft_prev('p',nutrient_space_2,1,1); nutrient_space_2_aft_1 = aft_prev('a',nutrient_space_2,-1,1);
  nutrient_space_2_prev_2 = aft_prev('p',nutrient_space_2,1,2); nutrient_space_2_aft_2 = aft_prev('a',nutrient_space_2,-1,2);
  nutrient_space_2_prev_3 = aft_prev('p',nutrient_space_2,1,3); nutrient_space_2_aft_3 = aft_prev('a',nutrient_space_2,-1,3);
    
  nutrient_space = nutrient_space_2 + ((dt/(dx^2)) * (D1(2:end,:,:) .* (nutrient_space_2_aft_1-nutrient_space_2)+...
                                                      D1(1:end-1,:,:) .* (nutrient_space_2_prev_1-nutrient_space_2)+...
                                                      D2(:,2:end,:) .* (nutrient_space_2_aft_2-nutrient_space_2)+...
                                                      D2(:,1:end-1,:) .* (nutrient_space_2_prev_2-nutrient_space_2)+...
                                                      D3(:,:,2:end) .* (nutrient_space_2_aft_3-nutrient_space_2)+...
                                                      D3(:,:,1:end-1) .* (nutrient_space_2_prev_3-nutrient_space_2)));
 end                                              
end