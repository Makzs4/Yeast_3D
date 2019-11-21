function [P1,P2,P3,A1,A2,A3] = aft_prev_dont_use(U)

% for some reason it is slower than aft_prev

P1=circshift(U,1,1); P2=circshift(U,1,2); P3=circshift(U,1,3);
A1=circshift(U,-1,1); A2=circshift(U,-1,2); A3=circshift(U,-1,3);

P1(1,:,:) = P1(2,:,:); P2(:,1,:) = P2(:,2,:); P3(:,:,1) = P3(:,:,2);
A1(end,:,:) = A1(end-1,:,:); A2(:,end,:) = A2(:,end-1,:); A3(:,:,end) = A3(:,:,end-1);

end

