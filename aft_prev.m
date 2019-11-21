function [U] = aft_prev(str, U, n, dim)

U = circshift(U, n, dim); % m�trix eltol�sa a dim dimenzi� ment�n n-el (+n: el�re, -n: h�tra)

 if str == 'p' % str-t�l f�gg�en eld�nti, hogy melyik sort melyikkel kell fel�l�rni
  switch dim % dimt�l f�gg�en a megfelel� dimenzi� ment�n v�gzi a sorcser�t
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