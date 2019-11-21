function [D1, D2, D3] = conductivity_matrix_3_0(P, agar, dif_co_cell, dif_co_air, dif_co_agar)
D1=dif_co_air*ones(size(P,1)+1, size(P,2), size(P,3));
D2=dif_co_air*ones(size(P,1), size(P,2)+1, size(P,3));
D3=dif_co_air*ones(size(P,1), size(P,2), size(P,3)+1);

D1(:,:,1:agar) = dif_co_agar;
D1(cat(1, zeros(1,size(P,2),size(P,3)), P)==1 & cat(1, P, zeros(1,size(P,2),size(P,3)))==1) = dif_co_cell;

D2(:,:,1:agar) = dif_co_agar;
D2(cat(2, zeros(size(P,1),1,size(P,3)), P)==1 & cat(2, P, zeros(size(P,1),1,size(P,3)))==1) = dif_co_cell;

D3(:,:,1:agar) = dif_co_agar;%D3(:,:,2:agar) = dif_co_agar;
D3(cat(3, zeros(size(P,1),size(P,2),1), P)==1 & cat(3, P, zeros(size(P,1),size(P,2),1))==1) = dif_co_cell;

end