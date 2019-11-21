function [U] = aft_prev(str, U, n, dim)

U = circshift(U, n, dim); % mátrix eltolása a dim dimenzió mentén n-el (+n: elõre, -n: hátra)

 if str == 'p' % str-tõl függõen eldönti, hogy melyik sort melyikkel kell felülírni
  switch dim % dimtõl függõen a megfelelõ dimenzió mentén végzi a sorcserét
      case 1
          U(1,:,:) = U(2,:,:);
      case 2
          U(:,1,:) = U(:,2,:);
      case 3
          U(:,:,1) = U(:,:,2);
  end
  
 elseif str == 'a'
  switch dim
    case 1
        U(end,:,:) = U(end-1,:,:);
    case 2
        U(:,end,:) = U(:,end-1,:);
    case 3
        U(:,:,end) = U(:,:,end-1);
  end
  
 end
 
end