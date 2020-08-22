function x = is_adjacent(v1,v2)
 dx = abs(v1(1,1)-v2(1,1));
 dy = abs(v1(1,2)-v2(1,2));
 dz = abs(v1(1,3)-v2(1,3));
 x = (dx + dy + dz == 1);
end